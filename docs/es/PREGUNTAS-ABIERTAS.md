# Preguntas abiertas

Lo que sigue sin cerrar. Está aquí para que se vea qué falta, no para
disimularlo.

## El `jp 0xBE2E` de la cabecera

En 0x4015, justo detrás de la firma de Konami, hay un `jp 0xBE2E`. Es una
entrada pensada para que la llame **otro cartucho**, pero no se sabe quién
saltaría ahí ni con qué página mapeada en 0xA000, así que tampoco se sabe a qué
código se llega.

## Los 504 bytes que faltan por trazar

De los 131.072 bytes del cartucho, **504** siguen marcados como pendientes de
trazar: 0,4 %. No es que no se sepa qué son —están dentro de bloques
identificados—, es que el trazador no llega a ellos desde ningún punto de
entrada conocido y por eso no se pueden dar por código con seguridad.

## Rutinas sin llamador

Además de las ocho puertas de la página 0 que se cuentan en los hallazgos, hay
un puñado de rutinas repartidas por las demás páginas cuyos bytes no aparecen
como destino de ningún salto. Algunas son claramente restos —variantes de otra
rutina de al lado—, pero de otras no se puede descartar que se llegue por una
dirección calculada.

## Qué son exactamente algunos campos de la ficha del coche

La ficha del coche tiene más de cien bytes y no todos están atados a un
comportamiento visible. Los que se usan en las cuentas están claros —posición,
velocidades, ángulo, marcha, revoluciones, combustible, desgaste—, pero quedan
contadores y banderas que solo se leen en un sitio y de los que no se ha podido
decir para qué sirven sin verlos en marcha.

## La tabla de umbrales de exceso por terreno

Hay una tabla de dieciséis punteros indexada por el terreno, y **las dieciséis
entradas apuntan al mismo sitio**. O sobra, o quedó preparada para una variante
que no llegó a usarse.

## Los ocho bytes de p02 0x8ECE

Ocho bytes (04 01 04 01 02 04 02 01) entre dos rutinas sin llamador, que no
referencia nadie en el cartucho.

## La marca oculta de Konami

Manuel Pazos documentó que los cartuchos de Konami llevan escondido, al final
de la ROM, su número de catálogo RC7xx y el título en katakana. En este volcado
**no aparece**: los finales de las dieciséis páginas son relleno 0xFF o datos
gráficos. O este cartucho no la lleva, o está en un sitio distinto del que se ha
mirado.

## Lo que no se ha medido en el emulador

Buena parte de lo que hay escrito sale de leer el código, no de verlo correr.
Las cosas que se han comprobado en openMSX están marcadas como tales en las
notas del desensamblado; el resto es lectura, y aunque se ha revisado dos veces,
una tercera lectura seguiría destapando cosas. Ha pasado ya varias veces.
