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
 ```
int i = 1;
int sum = 0;
while (i <= 100) {
    sum += i;
    i++;
}
 ```
### Solución
 ```
int sum = 0;
for (int i = 1; i <= 100; i++) {
    sum += i;
}
```
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
### ¿Cómo se declara un puntero en C++?
Un puntero se declara utilizando el operador * junto al tipo de dato que apunta. Esto indica que la variable almacenará una dirección de memoria.

### ¿Cómo se define un puntero en C++?
Un puntero se define asignándole la dirección de otra variable, lo cual se hace mediante el operador &.

¿Cómo se almacena en C++ la dirección de memoria de una variable?
La dirección de memoria de una variable se obtiene utilizando el operador &, que devuelve la ubicación en memoria de dicha variable.

### ¿Cómo se escribe el contenido de la variable a la que apunta un puntero?
Se accede o modifica el contenido de la variable apuntada utilizando el operador *, lo que se conoce como desreferenciación.

## Reto 5:

### RAE1: Código - Inicial
 ```
int var = 10;
int *punt;
punt = &var;
*punt = 20;
 ```

### Solución
 ```
// var = 10
@10
D=A
@var
M=D

// punt = &var
@var      // Obtener la dirección de var
D=A       // Guardar esa dirección en D
@punt
M=D       // Guardar la dirección en punt

// *punt = 20
@20
D=A       // Valor que queremos asignar
@punt
A=M       // Ir a la dirección almacenada en punt
M=D       // Almacenar 20 en esa dirección

// Fin del programa (bucle infinito)
(END)
@END
0;JMP

// Variables simbólicas (RAM[16], RAM[17], etc.)
(var)
(punt)
 ```
## Reto 6: YA DESARROLLADO.

## Reto 7:

#### Nota: Estaba difícil la verdad. Me demoré resto. Casi que ni con Chatgpt.

### RAE1: Código - Inicial
 ```
int var = 10;
int bis = 5;
int *p_var;
p_var = &var;
bis = *p_var;
 ```

### Solución: 

 ```
// Declaración de variables
@16    // Dirección de 'var'
D=A
@var
M=D

@17    // Dirección de 'bis'
D=A
@bis
M=D

@18    // Dirección de 'p_var'
D=A
@p_var
M=D

// Inicialización: var = 10
@10
D=A
@16    // Dirección de 'var'
M=D

// Inicialización: bis = 5
@5
D=A
@17    // Dirección de 'bis'
M=D

// p_var = &var
@16
D=A
@18    // Dirección de 'p_var'
M=D

// bis = *p_var
@18    // Dirección de 'p_var'
A=M    // Ahora A = 16 (valor de p_var)
D=M   
@17 
 ```

 ### RAE2: Explicación
 Queremos que el programa almaecene 2 variables, cada una con su valor numérico, y que la tercera variable tenga el valor de la primera, y que la segunda termine con el valor de la tecera que es a su vez el valor de la primera, es decir: todas quedan con 10. Lo que nuestro programa hace es definir el registro D como 10 en tal caso de que la variable "bis" (la segunda variable) sea = a "*p_var"(la tercera variable) y ya que "*p_var" es = a 10, "bis" va a ser = 10. Por lo que el programa funciona correctamente.

 Pd: Espero que sí funcione.

 ## Reto 8:

- ¿Qué hace esto `int *pvar;`?
Estamos declarando un puntero llamado "pvar" de tipo "int" (entero).
- ¿Qué hace esto `pvar = var;`?
Esto (se supone) que asigna el valor o contenido (lo que hay en la dirección de memoria) de "var" al puntero que creamos "pvar". Sin embargo, para que esto funcione, necesitamos definir que nos referimos a la memoria de "var" y se hace de esta forma: "pvar = &var". Esto para que cuando usemos *pvar podamos ir a la dirección de memoria de "var".
- ¿Qué hace esto `var2 = *pvar`?
Aquí nos referimos al contenido al cual apunta el puntero "pvar" para guardarlo en la memoria de "var2". Es decir, "var2" ahora contiene el valor de la variable a la cual apuntaba "pvar". Esto tiene un nombre y es "desreferenciación".
- ¿Qué hace esto `pvar = &var3`?
Esta instrucción le asigna al puntero pvar la dirección de memoria de "var3". por lo que *pvar (el puntero) accede o en su caso modifica el contenido de var3. (Es la forma correcta de lo que se comentaba en la pregunta 2)

### Reto 9: 
