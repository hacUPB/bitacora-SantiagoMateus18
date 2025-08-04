## Reto 1
### RAE1: Código - Sumar los primeros 100 números naturales
Programa en lenguaje ensamblador Hack para:

```
int i = 1;
int sum = 0;
while (i <= 100) {
   sum += i;
   i++;
}
```
### Solución: 

```
// i = 1
@1
D=A
@i
M=D

// sum = 0
@sum
M=0

(LOOP)
// if (i > 100) goto END
@i
D=M
@101
D=D-A
@END
D;JGE

// sum = sum + i
@sum
D=M
@i
D=D+M
@sum
M=D

// i = i + 1
@i
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP
```
### RAE2: Pruebas del programa

Verifiqué que i empiece en 1 y sum en 0 observando los valores en RAM[16] y RAM[17].
Al comparar i con 101, validé que al llegar a 101, el programa salte a (END).
Instrucción sum += i:
Observé cómo sum crece cada vez que pasa por el ciclo (ver RAM[17]).
Confirmé que i crece de 1 a 100 (ver RAM[16]).

## Reto 2:
### RAE1: Código - Inicial
int i = 1;
int sum = 0;
while (i <= 100) {
    sum += i;
    i++;
}

### Solución
int sum = 0;
for (int i = 1; i <= 100; i++) {
    sum += i;
}

### RAE2: Prueba del programa
El programa no ha sido testeado por un fallo en el editor de código Visual Studio Code. Sin embargo fue editado directamente del codigo del profesor. 

## Reto 3: 

## RAE1: Código - Reto 1
```
// i = 1
@1
D=A
@i
M=D

// sum = 0
@sum
M=0

(LOOP)
// if (i > 100) goto END
@i
D=M
@101
D=D-A
@END
D;JGE

// sum = sum + i
@sum
D=M
@i
D=D+M
@sum
M=D

// i = i + 1
@i
M=M+1

@LOOP
0;JMP

(END)
@END
0;JMP
```
### RAE2: Funcionalidad
Funciona ya que es el mismo código efectuado en el Reto 1, por ende no hay necesidad de testearlo.

## Reto 4: 
