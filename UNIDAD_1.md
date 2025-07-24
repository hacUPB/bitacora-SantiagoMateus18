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
## Retos:

### 1
  ```
@1978
D=A
  ```
### 2
  ```
@69
D=A
@100
M=D
  ```
### 3
  ```
@24
D=M
@200
M=D
  ```
### 4
  ```
@100
D=M
@15
D=D-A
@100
M=D
  ```
### 5
```
@0
D=M
@1
D=D+M
@69
D=D+A
@2
M=D
```
### 6
```
@100
D;JMP
```
### 7
```
@100
D=A
@50
D=D-A
@20
D;JLT
```
### 8
Suma el contenido de var1 y var2, y guarda el resultado en var3.

las variables están en 16,17 y 18 respectivamente.

### 9
El programa inicia declarando dos variables: i y sum. Primero, le da a i el valor de 1, y a sum el valor de 0. Luego, toma el valor de i (que es 1) y se lo suma a sum, que en ese momento vale 0, así que sum ahora vale 1. Finalmente, aumenta el valor de i en 1, haciendo que i pase de valer 1 a valer 2.

las variables están en 16 y 17 respectivamente.

el código optimizado queda asi: 
```
@i
M=M+1
```
### 10
```
@R0
D = M       
D = D + D   
@R1
M = D  
```
### 11
El programa inicializa una variable i con el valor 1000, y luego entra en un ciclo (LOOP) que revisa si i es igual a 0. Si lo es, salta a la etiqueta CONT y termina el ciclo. Si i no es cero, le resta 1 y vuelve al principio del ciclo (LOOP). Esto se repite 1000 veces, disminuyendo i desde 1000 hasta 0.

i está en el registro 16 de la ram

Los comentarios no se almacenan

La primera instrucción carga el valor 1000 en el registro A (A = 1000).

La instrucción @1000 está en la ROM, en la dirección 0.

LOPP Y CONT Son etiquetas que marcan posiciones en el código, usadas como destinos de saltos (JMP, JEQ, etc.).
LOOP Marca el inicio del ciclo.
CONT Marca el punto donde se continúa después de que i == 0.

La diferencia es que i es un dato, una posición de RAM y CONT es una dirección en el código, una etiqueta que el programa puede saltar a ella.

### 12
```
@R1
D = M       
@R2
D = D + M   
@69
D = D + A   
@R4
M = D 
```
### 13
```
(LOOP)
goto LOOP
@R0
D=M
@0
D=D-A
@R1
D;JGE

@R1
M=-1
@LOOP
0,JMP

@R1
M=1
@LOOP
0;JMP
(LOOP)
```
### 14
```
@R1
D=M
@R4
M=D
```
### 15
```
@0
D = A
@counter
M = D

(LOOP)
@counter
D = M
@R1
D = D - M
@END
D;JEQ

@R0
D = M
@counter
D = D + M
@addr
M = D        

@addr
A = M       
M = -1       

@counter
M = M + 1

@LOOP
0;JMP
(END)

@END
0;JMP         
```

### 16
```
@0
D = A
@sum
M = D
@0
D = A
@j

M = D
(LOOP)
@j
D = M
@10
D = D - A
@END
D;JEQ
@arr
D = A
@j
A = M
A = D + A   
D = M       
@sum
M = D + M
// j = j + 1
@j
M = M + 1
@LOOP
0;JMP
(END)
@END
0;JMP
```
la dirección de la base arr es ram16.
Después de arr0 a arr9 (10 posiciones), la siguiente posición libre es RAM26.
La dirección de j es la siguiente: ram27

### 17
```
@7
D=D-A     
@69
D;JEQ 
```
### 18

<img width="578" height="405" alt="Captura de pantalla 2025-07-24 105308" src="https://github.com/user-attachments/assets/d7cf1f43-e2bc-4c43-81d2-c55e96b19acf" />

### 19
El programa dibuja un patrón en la pantalla de la computadora Hack, utilizando memoria de video directamente (@16384 y similares), y emplea bucles y saltos condicionales para recorrer y modificar posiciones de memoria.

### 20
```
@100

D=A // verificar si es 100

@24576

D=D-M

@DRAW

D;JEQ // Si D es igual a cero saltar a la parte de dibujar el bitmap

@100

D;JMP

(DRAW)

function void draw(int location)
{
	var int memAddress; 
	let memAddress = 16384+location;
	// column 0
	// column -5
	do Memory.poke(memAddress -5, ~32767);
	do Memory.poke(memAddress +27, 24576);
	do Memory.poke(memAddress +59, 12288);
	do Memory.poke(memAddress +91, 4096);
	do Memory.poke(memAddress +123, 4096);
	do Memory.poke(memAddress +155, 4096);
	do Memory.poke(memAddress +187, 8192);
	do Memory.poke(memAddress +219, 24576);
	do Memory.poke(memAddress +251, -2048);
	do Memory.poke(memAddress +283, -30720);
	do Memory.poke(memAddress +315, 6144);
	do Memory.poke(memAddress +347, 28672);
	do Memory.poke(memAddress +379, -16384);
	do Memory.poke(memAddress +411, 0);
	// column -4
	do Memory.poke(memAddress -4, 63);
	do Memory.poke(memAddress +28, 448);
	do Memory.poke(memAddress +60, 256);
	do Memory.poke(memAddress +92, 384);
	do Memory.poke(memAddress +124, 510);
	do Memory.poke(memAddress +156, 2);
	do Memory.poke(memAddress +188, 2);
	do Memory.poke(memAddress +220, 60);
	do Memory.poke(memAddress +252, 241);
	do Memory.poke(memAddress +284, 769);
	do Memory.poke(memAddress +316, 512);
	do Memory.poke(memAddress +348, 512);
	do Memory.poke(memAddress +380, 515);
	do Memory.poke(memAddress +412, 508);
	do Memory.poke(memAddress +444, 0);
	// column -3
	// column -2
	// column -1
	return;
}

D;JMP
```








