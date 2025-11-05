## Act 1
¿Qué es un computador digital moderno?
Es una máquina electrónica que procesa datos en forma binaria para ejecutar programas.
¿Cuáles son sus partes?
CPU, memoria (RAM), almacenamiento, dispositivos de entrada y salida, y buses.

## Act 2
¿Qué es un programa?
Conjunto de instrucciones que la computadora ejecuta para realizar una tarea.

¿Qué es lenguaje ensamblador?
Lenguaje simbólico cercano al lenguaje de máquina, más fácil de entender para humanos.

¿Qué es lenguaje de máquina?
Código binario que la CPU ejecuta directamente.

## Act 3
¿Qué son PC, D y A?

PC: Registro que indica la siguiente instrucción.

D: Registro para datos temporales.

A: Registro para direcciones o datos.

¿Para qué los usa la CPU?
PC controla la secuencia de instrucciones; D y A almacenan datos o direcciones para operaciones.

## Act 4
Código dado:

  ```
@16384
D = A
@16
M = D
  ```
Guarda el valor 16384 en la posición 16 de la RAM.

Programa para guardar 100 en la posición 32:
  ```
@100
D = A
@32
M = D
  ```