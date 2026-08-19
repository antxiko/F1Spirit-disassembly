# Que pagina hay mapeada en el destino de cada llamada fuera de pagina.
#
# Lee work/omsx/externos.txt (lineas "pagina_origen origen destino", lo genera
# el paso previo del Makefile o a mano desde los trace.json), pone un punto
# de ruptura en cada origen -condicionado a que la pagina que esta mapeada en
# el origen sea la suya, porque 0x6470 existe en cinco paginas- y cuando
# salta apunta que bloque de 8 KB tiene el mapper en la direccion DESTINO.
# Eso lo dice el depurable "romblocks" del cartucho, que openMSX mantiene
# byte a byte. Resultado en work/omsx/bancos.log: "origen destino pagina".
#
# Corre el tiempo que se le diga (env F1_SEGUNDOS, 60 por defecto) y sale.
# Con la demo de titulo solo se resuelven las llamadas de esa parte; para
# el resto hace falta jugar (o un replay).
#
# Si se da F1_REPLAY=nombre, graba la partida (reverse) y la guarda como
# replay cada minuto, al salir y al pulsar CTRL+F12: asi la proxima medida
# no necesita al jugador (reverse loadreplay nombre). Pinta en pantalla
# cuantas llamadas lleva resueltas.
#
#   F1_SEGUNDOS=1800 F1_REPLAY=f1_partida1 openmsx -machine Philips_VG_8020 \
#       -cart f1spirit.rom -script tools/omsx_bancos.tcl
#
# Con F1_LOADREPLAY=nombre reproduce ese replay (sin jugador, a toda
# velocidad: throttle off) y mide sobre el; F1_SEGUNDOS es entonces el
# tiempo EMULADO a cubrir. F1_LOG cambia el fichero de salida (por defecto
# work/omsx/bancos.log).
#
#   F1_LOADREPLAY=f1_partida1 F1_SEGUNDOS=2400 F1_LOG=work/omsx/bancos_replay.log \
#       openmsx -machine Philips_VG_8020 -cart f1spirit.rom -script tools/omsx_bancos.tcl
set segundos 60
if {[info exists ::env(F1_SEGUNDOS)]} { set segundos $::env(F1_SEGUNDOS) }
set replay ""
if {[info exists ::env(F1_REPLAY)]} { set replay $::env(F1_REPLAY) }
set loadreplay ""
if {[info exists ::env(F1_LOADREPLAY)]} { set loadreplay $::env(F1_LOADREPLAY) }
set logpath "work/omsx/bancos.log"
if {[info exists ::env(F1_LOG)]} { set logpath $::env(F1_LOG) }
set ROMBLOCKS "F1-Spirit - The Way To Formula 1 romblocks"
set log [open $logpath w]
array set visto {}
set resueltas 0
set fin [open "work/omsx/externos.txt" r]
set n 0
while {[gets $fin linea] >= 0} {
    lassign $linea pag ori dst
    set ori 0x$ori
    set dst 0x$dst
    # pagina 0: fija, sin condicion; las demas: que la mapeada en el origen sea la suya
    if {$pag == 0} {
        set cond {}
    } else {
        set cond [format {[debug read "%s" %d] == %d} $ROMBLOCKS $ori $pag]
    }
    debug set_bp $ori $cond [list apunta $pag $ori $dst]
    incr n
}
close $fin
proc apunta {pag ori dst} {
    global ROMBLOCKS log visto resueltas n
    set bloque [debug read $ROMBLOCKS $dst]
    set clave [format "%d %04X %04X %d" $pag $ori $dst $bloque]
    if {![info exists visto($clave)]} {
        set visto($clave) 1
        incr resueltas
        puts $log [format "p%02d:%04X -> %04X  pagina %d   t=%.1f" $pag $ori $dst $bloque [machine_info time]]
        flush $log
        osd configure contador -text [format "bancos: %d / %d" $resueltas $n]
    }
}
# El despachador Konami (p00 0x40DA: `call` seguido de tabla de palabras)
# acaba en `jp (hl)` en 0x40E3, y sus destinos no salen en externos.txt
# porque el trazador no puede leer la tabla con bancos. Un bp AHI caza todos:
# HL = destino, DE-1 = la entrada de la tabla (en la pagina que sea).
proc despacha {} {
    global ROMBLOCKS log visto resueltas
    set hl [reg HL]
    set ent [expr {[reg DE] - 1}]
    if {$ent < 0x4000 || $ent >= 0xC000} { return }
    set pori [debug read $ROMBLOCKS $ent]
    set pdst [debug read $ROMBLOCKS $hl]
    set clave [format "D %d %04X %04X %d" $pori $ent $hl $pdst]
    if {![info exists visto($clave)]} {
        set visto($clave) 1
        incr resueltas
        puts $log [format "DESP p%02d:%04X -> %04X  pagina %d   t=%.1f" $pori $ent $hl $pdst [machine_info time]]
        flush $log
    }
}
debug set_bp 0x40E3 {} despacha

puts $log "$n puntos de ruptura; $segundos segundos"
flush $log

# contador en pantalla
osd create rectangle marco -x 2 -y 2 -w 120 -h 12 -rgba 0x00000080
osd create text contador -x 4 -y 2 -size 9 -rgba 0xffffffff -text "bancos: 0 / $n"

if {$replay ne ""} {
    reverse start
    proc guarda_replay {} {
        global replay
        catch {reverse savereplay $replay}
        after time 60 guarda_replay
    }
    after time 60 guarda_replay
}

proc termina {} {
    global replay log
    if {$replay ne ""} { catch {reverse savereplay $replay} }
    puts $log "fin"
    close $log
    exit
}
if {$loadreplay ne ""} {
    # reproducir: el replay trae su propia maquina; los bps son globales
    reverse loadreplay $loadreplay
    set throttle off
}
after time $segundos termina
# red de seguridad: si el temporizador emulado se pierde al cargar un replay,
# salir igualmente a los 15 minutos REALES
after realtime 900 termina
# CTRL+F12: el jugador da por terminada la partida (guarda replay y sale)
bind "CTRL+F12" termina
