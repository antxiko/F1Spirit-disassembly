# F-1 Spirit - The Way to Formula 1 (Konami, 1987, MSX1) - desensamblado
#
# El orden de las cosas: trazar el flujo -> generar el listado -> comprobar que
# vuelve a dar la ROM byte a byte -> las comprobaciones que el reensamblado NO
# cubre.
#
# LO QUE CAMBIA RESPECTO A LOS CARTUCHOS DE 16 KB DE LA SERIE: esto es un
# MegaROM de 128 KB con el mapper Konami SCC, 16 paginas de 8 KB. Cada pagina
# es un modulo (p00..p15) con su propio org -el sitio donde el mapper la pone
# para ejecutarla, ver tools/paginas.py-, su trazado, sus notas y su listado.
# `make verify` reensambla las 16 y las concatena: tiene que salir la ROM
# entera, byte a byte.
#
# La ROM no se distribuye. Hace falta en la raiz como f1spirit.rom, y
# `make comprueba` verifica el sha256.

ROM      = f1spirit.rom
SHA      = 3b9afd12b29680abb655f05d24e0970954c38e48c5ccb24227d6c710474396a7
SRC      = src
WORK     = work
TITULO   = F-1 SPIRIT - Konami (1987) - MSX1 - MegaROM RC-752 de 128 KB (Konami SCC)

PAGINAS  = 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15

# Donde se ejecuta cada pagina. Es la misma tabla que `python3 tools/paginas.py
# lista` (un test lo comprueba); esta copiada aqui para no lanzar python 32
# veces por cada make.
ORG_00 = 0x4000
ORG_01 = 0x6000
ORG_02 = 0x8000
ORG_03 = 0xa000
ORG_04 = 0x6000
ORG_05 = 0x8000
ORG_06 = 0xa000
ORG_07 = 0x6000
ORG_08 = 0x8000
ORG_09 = 0xa000
ORG_10 = 0x6000
ORG_11 = 0x8000
ORG_12 = 0xa000
ORG_13 = 0x6000
ORG_14 = 0x8000
ORG_15 = 0xa000
ORG    = $(ORG_$(1))

# Los arneses de openMSX (tools/omsx_*.tcl) dejan aqui lo que midan.
OMSX     = $(WORK)/omsx

all: listado verify sanity test

$(ROM):
	@echo "=================================================================="
	@echo " Falta $(ROM), y este repositorio NO lo distribuye."
	@echo ""
	@echo " Es F-1 Spirit (Konami, RC-752, 1987) para MSX, 131072 bytes exactos."
	@echo " Ponlo aqui con ese nombre. Para comprobar que es el mismo:"
	@echo "     shasum -a 256 $(ROM)"
	@echo "     $(SHA)"
	@echo ""
	@echo " Sin el se puede leer el listado ya generado en $(SRC)/, y los"
	@echo " tests que no dependen del binario siguen pasando."
	@echo "=================================================================="
	@false

comprueba: $(ROM)
	@echo "$(SHA)  $(ROM)" | shasum -a 256 -c -

# Reconocimiento: cabecera, escrituras al mapper, SCC, y la comprobacion de
# que la regla pagina -> org la cumplen todos los llamadores de las rutinas
# de banco. Es la base sobre la que se apoya todo lo demas.
reconoce: $(ROM)
	@python3 tools/reconocimiento.py $(ROM)

# Las 16 paginas cortadas de la ROM, una por fichero.
$(WORK)/p00.bin: $(ROM) tools/paginas.py
	@mkdir -p $(WORK)
	python3 tools/paginas.py corta $(ROM) $(WORK)

paginas: $(WORK)/p00.bin

# El trazado sigue el flujo desde los puntos de entrada DE CADA PAGINA. Los
# que no se pueden deducir estaticamente -ganchos de interrupcion, destinos
# de saltos indirectos, y aqui ademas las llamadas desde OTRA pagina- estan
# declarados en el .entries, cada uno con su justificacion.
define REGLA_TRAZA
$(WORK)/p$(1).trace.json: $(WORK)/p00.bin $(SRC)/p$(1).entries $(SRC)/p$(1).nocode tools/z80trace.py
	python3 tools/z80trace.py $(WORK)/p$(1).bin $(call ORG,$(1)) $(SRC)/p$(1).entries \
	        $(WORK)/p$(1) $(SRC)/p$(1).nocode
endef
$(foreach p,$(PAGINAS),$(eval $(call REGLA_TRAZA,$(p))))

trace: $(foreach p,$(PAGINAS),$(WORK)/p$(p).trace.json)

# Un listado por pagina: src/f1spirit_pNN.asm, con el org de esa pagina.
define REGLA_LISTADO
$(SRC)/f1spirit_p$(1).asm: $(WORK)/p$(1).trace.json $(SRC)/p$(1).notes tools/mkasm.py
	python3 tools/mkasm.py $(WORK)/p$(1).bin $(call ORG,$(1)) $(WORK)/p$(1).trace.json \
	        $(SRC)/p$(1).notes $(WORK)/msx.sym $(SRC)/f1spirit_p$(1).asm \
	        "$(TITULO) - pagina $(1) (se ejecuta en $(call ORG,$(1)))"
endef
$(foreach p,$(PAGINAS),$(eval $(call REGLA_LISTADO,$(p))))

listado: $(foreach p,$(PAGINAS),$(SRC)/f1spirit_p$(p).asm)

# La prueba que decide si el desensamblado es fiable: cada pagina reensambla
# a sus 8192 bytes, y las 16 concatenadas dan la ROM entera.
verify: $(WORK)/p00.bin
	@for p in $(PAGINAS); do \
	  sh tools/verify_build.sh $(SRC)/f1spirit_p$$p.asm $(WORK)/p$$p.bin \
	     `python3 tools/paginas.py org $$p` $(WORK)/p$$p.out.bin || exit 1; \
	done
	@sh tools/verify_rom.sh $(WORK) $(ROM) $(SHA)

# Lo que el reensamblado NO puede cazar: que unos datos se esten leyendo como
# codigo. El binario sale identico igual, porque los bytes no cambian; lo unico
# que cambia es lo que decimos de ellos.
sanity: trace
	@echo "=================================================================="
	@echo " la regla pagina -> org la cumplen todos los llamadores"
	@echo "=================================================================="
	@python3 tools/reconocimiento.py $(ROM) | tail -1
	@echo "=================================================================="
	@echo " ningun byte declarado como datos puede salir como codigo"
	@echo "=================================================================="
	@for p in $(PAGINAS); do \
	  python3 tools/check_trace.py $(WORK)/p$$p.trace.json $(SRC)/p$$p.nocode | tail -1 || exit 1; \
	done
	@python3 tools/check_datos_como_codigo.py $(WORK) $(SRC)
	@echo "=================================================================="
	@echo " ningun despachador trazado con su tabla sin proteger"
	@echo "=================================================================="
	@python3 tools/despachadores.py $(WORK) $(SRC) | tail -1
	@echo "=================================================================="
	@echo " ningun punto de entrada puede caer dentro de una zona de datos"
	@echo "=================================================================="
	@for p in $(PAGINAS); do \
	  python3 tools/check_entradas.py $(SRC)/p$$p.entries $(SRC)/p$$p.notes \
	          $(SRC)/p$$p.nocode | tail -1 || exit 1; \
	done
	@echo "=================================================================="
	@echo " ni un byte del cartucho sin asignar (las 16 paginas)"
	@echo "=================================================================="
	@python3 tools/presupuesto.py $(WORK) $(SRC)

# Las llamadas que cada pagina hace FUERA de si misma, agrupadas por destino:
# es la lista de semillas candidatas para las otras paginas. No siembra nada
# sola: cada una hay que resolverla sabiendo que pagina estaba mapeada.
externos: trace
	@python3 tools/externos.py $(WORK) $(SRC)
	@python3 tools/siembra_medidas.py $(WORK) $(SRC) --solo-lista

test:
	@echo "=================================================================="
	@echo " Tests"
	@echo "=================================================================="
	@python3 -m unittest discover -s tests -v

clean:
	rm -f $(WORK)/p*.trace.json $(WORK)/p*.blocks $(WORK)/p*.out.bin \
	      $(WORK)/f1spirit_reensamblada.rom $(WORK)/pasmo.err

.PHONY: all comprueba reconoce paginas trace listado verify sanity externos test clean
