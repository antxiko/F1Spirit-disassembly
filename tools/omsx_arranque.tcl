# Prueba de arranque en openMSX: deja correr el juego unos segundos y apunta
# la sombra del mapper (F0F1/F0F2/F0F3), los dispositivos depurables (para
# ver como llama openMSX al mapper del cartucho) y que hay en E1C0/E1C1 (el
# estado del juego). Sale solo. Salida en work/omsx/arranque.log.
#
#   openmsx -machine Philips_VG_8020 -cart f1spirit.rom -script tools/omsx_arranque.tcl
set f [open "work/omsx/arranque.log" w]
proc apunta {f} {
    puts $f "t=[machine_info time]"
    puts $f "debug list: [debug list]"
    set m [debug read memory 0xF0F1]
    set m2 [debug read memory 0xF0F2]
    set m3 [debug read memory 0xF0F3]
    puts $f [format "sombra mapper F0F1/F0F2/F0F3 = %02X %02X %02X" $m $m2 $m3]
    puts $f [format "E1C0 (estado)=%02X E1C1=%02X E1C3=%02X E1DE (otro cartucho)=%02X" \
        [debug read memory 0xE1C0] [debug read memory 0xE1C1] [debug read memory 0xE1C3] [debug read memory 0xE1DE]]
    puts $f [format "H.KEYI FD9A = %02X %02X %02X" [debug read memory 0xFD9A] [debug read memory 0xFD9B] [debug read memory 0xFD9C]]
    puts $f "PC=[format %04X [reg PC]]"
    foreach d [debug list] {
        if {[string match -nocase "*rom*" $d] || [string match -nocase "*mapper*" $d] || [string match -nocase "*scc*" $d] || [string match -nocase "*cart*" $d]} {
            catch {puts $f "  $d: [debug desc $d] size=[debug size $d]"}
        }
    }
    flush $f
}
after time 2 [list apunta $f]
after time 6 [list apunta $f]
after time 10 {
    apunta $f
    close $f
    exit
}
