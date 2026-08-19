# Fuerza los subestados de carrera que ninguna partida alcanzo, para verlos
# y medir sus bancos. Carga el medidor normal (tools/omsx_bancos.tcl: bps en
# cada llamada fuera de pagina, log, OSD, replay) y anade la tecla R: cada
# pulsacion escribe el SIGUIENTE indice de la lista en E250 -el indice del
# despachador de carrera 0x5A3D (tabla 0x5A40)- y lo pinta en pantalla. Hay
# que estar DENTRO de una carrera (estado 5 del despachador principal) para
# que el salto tenga efecto. El jugador dice que ve; el log dice que pagina.
#
#   F1_SEGUNDOS=3600 F1_REPLAY=f1_fuerza openmsx -machine Philips_VG_8020 \
#       -cart f1spirit.rom -script tools/omsx_fuerza_estados.tcl
#
# Lista: env F1_ESTADOS (por defecto las entradas de 0x5A3D sin medir el
# 2026-08-19). Tambien vale para otros despachadores cambiando F1_DIR.
source tools/omsx_bancos.tcl
set estados {4 14 16 17 18 26 27 28}
if {[info exists ::env(F1_ESTADOS)]} { set estados $::env(F1_ESTADOS) }
set dir_estado 0xE250
if {[info exists ::env(F1_DIR)]} { set dir_estado $::env(F1_DIR) }
set i_estado -1
# En pantalla, grande: que subestado se ha forzado (y cual es el i-esimo de
# la lista) y, debajo, el valor REAL de E250 en cada momento (el juego puede
# cambiarlo enseguida), refrescado cada decima de segundo.
osd create rectangle marco2 -x 2 -y 16 -w 250 -h 40 -rgba 0x000000a0
osd create text forzado -x 4 -y 16 -size 18 -rgba 0xffff00ff -text "R: fuerza el primero de ($estados)"
osd create text actual -x 4 -y 36 -size 14 -rgba 0x80ff80ff -text "E250 ahora: ?"
proc refresca {} {
    global dir_estado
    osd configure actual -text [format "E250 ahora: %d" [debug read memory $dir_estado]]
    after time 0.1 refresca
}
refresca
proc fuerza_siguiente {} {
    global estados i_estado dir_estado log
    incr i_estado
    if {$i_estado >= [llength $estados]} { set i_estado 0 }
    set e [lindex $estados $i_estado]
    set antes [debug read memory $dir_estado]
    debug write memory $dir_estado $e
    osd configure forzado -text [format "FORZADO: %d   (%d de %d)" $e [expr {$i_estado + 1}] [llength $estados]]
    puts $log [format "FORZADO (%04X) %d -> %d   t=%.1f" $dir_estado $antes $e [machine_info time]]
    flush $log
}
bind R fuerza_siguiente
# HOME: reset del MSX (si un salto deja el juego colgado, se vuelve al titulo,
# se entra en carrera y R sigue por donde iba la lista).
proc reinicia {} {
    global log
    puts $log [format "RESET   t=%.1f" [machine_info time]]
    flush $log
    osd configure forzado -text "RESET (HOME); entra en carrera y pulsa R"
    reset
}
bind HOME reinicia
