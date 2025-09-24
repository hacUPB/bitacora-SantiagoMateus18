# Sesión 1: 

```
class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};
```
## ¿Qué representa la clase Particle?
representa una particula con dos componentes: posición en X ^ Y.

## Respuesta del promt para ChatGPT: 
Un objeto en C++ es una instancia concreta de una clase: ocupa memoria y contiene su propio estado (atributos) y comportamiento (métodos) definidos por la clase.

## Se almacenan de forma contigua?
sí, en el mismo bloque donde se crea el objeto.

## ¿qué indica el tamaño del objeto sobre su estructura interna?
indica cómo está organizado internamente en memoria. Por ejemplo, en este caso, el tamaño será de 8 bytes, y no contiene espacios rellenados o en blanco.

## ¿Que es un objeto desde la memoria?
Un objeto desde la memoria es un bloque de memoria almacenado de forma contigua, que guarda información de atributos no estáticos ni métodos. Si hay punteros en el objeto, en la clase objeto, el dicho objeto solo guardará la dirección de memoria del puntero en cuestión, no los datos que posea el puntero, sin importar en que parte de la memoria estén dichos datos, el objeto nunca los guardará. 

## ¿Como influyen los atributos y metodos en el tamaño y la estructura de un objeto?
Algunos atributos del objeto no se guardan en la memoria, la cual afecta directamente al tamaño. Solo los atributos NO estáticos reflejan un aumento o disminución en el tamaño del objeto, puesto que algunos atributos no afectan el tamaño. Tales como los estáticos que no reflejan nada de peso o como los punteros no almacenan datos, solo direcciones de memoria (dicha dirección de memoria si tiene un peso, pero mínimo) sin importar en que parte de la memoria sean creados. Los métodos dan igual porque no se guardan en la memoria contigua de la clase objeto, se guardan en la memoria del programa.  

## Conclusión: 
El análisis muestra que los objetos en C++ solo almacenan en su memoria los atributos no estáticos, mientras que los estáticos se ubican en una región global y los métodos residen en la memoria del programa. Además, los punteros dentro de un objeto solo guardan direcciones, no los datos a los que apuntan, lo que influye directamente en cómo se gestiona la memoria (heap, stack o global). Esto impacta el diseño de clases, pues obliga a decidir con cuidado qué atributos deben ser parte de la instancia, cuándo conviene usar punteros y cómo equilibrar eficiencia y claridad en la gestión de recursos.

# Sesión 2: 

## ¿Dónde se almacenan los datos y métodos de una clase en C++ en la memoria?
Los atributos de un objeto se almacenan en el stack o en el heap según cómo se instancien. Los atributos estáticos se guardan en la memoria global del programa. Los métodos no se guardan dentro del objeto, sino en la sección de código (text segment).

## ¿En qué parte de la memoria se encuentran las vtable de cada objeto?
Las vtables se almacenan en una región global de solo lectura del programa. Cada objeto con métodos virtuales guarda un puntero oculto que apunta a su vtable.

## ¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?
Cada objeto con métodos virtuales añade un puntero extra a la vtable, lo que aumenta su tamaño en 4 u 8 bytes dependiendo de la arquitectura.

## ¿Qué papel juegan las vtables en el polimorfismo?
Las vtables permiten el polimorfismo dinámico, ya que guardan las direcciones de los métodos virtuales. Así, en tiempo de ejecución, se elige la implementación correcta según el tipo real del objeto.

## ¿Cómo se implementan los métodos virtuales en C++?
Se implementan mediante la vtable. Cada clase con métodos virtuales genera su propia tabla con punteros a los métodos. Los objetos tienen un puntero oculto a esa tabla y las llamadas se resuelven accediendo a ella en tiempo de ejecución.

## ¿Cuál es la relación entre los punteros a métodos y la vtable?
Los punteros a funciones son atributos explícitos que almacenan una dirección de función. En cambio, los punteros a métodos virtuales se gestionan automáticamente a través de la vtable. Ambos son direcciones de código, pero los punteros explícitos aumentan el tamaño del objeto directamente, mientras que los virtuales usan el puntero a la vtable.

## ¿Cómo afectan estos mecanismos al rendimiento del programa?
Los punteros a funciones hacen las llamadas directas, mientras que los métodos virtuales requieren una indirección adicional a través de la vtable. Esto introduce una ligera pérdida de eficiencia, aunque a cambio permiten flexibilidad con polimorfismo dinámico.

## ¿Dónde residen los datos y métodos de una clase en la memoria?
Los datos residen en el stack, heap o región global según cómo se instancie. Los métodos siempre residen en la sección de código del programa. Las vtables se guardan en memoria global y los objetos solo almacenan un puntero a ellas.

## ¿Cómo interactúan las diferentes partes en tiempo de ejecución?
Cuando un objeto se crea, se reservan sus atributos en stack o heap y, si tiene métodos virtuales, se asigna el puntero a su vtable. Al llamar métodos normales, se accede directamente al código; al llamar métodos virtuales, se consulta primero la vtable.

## Conclusión:
El análisis muestra que los objetos en C++ solo almacenan directamente sus atributos no estáticos, mientras que los métodos residen en la sección de código y los estáticos en memoria global. Las vtables permiten el polimorfismo dinámico, pero añaden un pequeño costo en memoria y en tiempo de ejecución. Comprender esta interacción ayuda a diseñar clases más eficientes, equilibrando flexibilidad con rendimiento al decidir entre métodos virtuales, punteros a funciones y atributos simples.

# Sesión 3: 

## ¿Cómo implementa el compilador el encapsulamiento en C++?
El compilador implementa el encapsulamiento controlando el acceso según los modificadores (private, protected, public). Los miembros privados siguen ocupando memoria dentro del objeto, pero el compilador impide el acceso directo a ellos generando errores de compilación si se intenta usarlos desde fuera de la clase.

## Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?
Lo que lo impide es una verificación del compilador en tiempo de compilación. La memoria está ahí, pero las reglas del lenguaje bloquean el acceso directo al nombre de esos atributos.

## ¿Qué es el encapsulamiento y cuál es su propósito en la programación orientada a objetos?
El encapsulamiento es el principio que restringe el acceso directo a los datos internos de una clase, exponiendo solo lo que se considere necesario mediante interfaces públicas. Su propósito es proteger el estado del objeto y mantener un control claro de cómo se manipula.

## ¿Por qué es importante proteger los datos de una clase y restringir el acceso desde fuera de la misma?
Porque evita que el estado interno del objeto sea modificado de manera indebida o inconsistente. Esto ayuda a mantener la integridad de los datos y facilita el mantenimiento del código.

## ¿Qué significa reinterpret_cast y cómo afecta la seguridad del programa?
reinterpret_cast permite forzar una conversión de tipos en memoria sin validaciones de seguridad. Al usarlo, se puede acceder a datos que deberían estar ocultos, rompiendo las barreras de encapsulamiento y comprometiendo la seguridad y estabilidad del programa.

## ¿Por qué crees que se pudo acceder a los miembros privados de MyClass en este experimento, a pesar de que el compilador normalmente lo impediría?
Porque los modificadores de acceso solo funcionan a nivel de compilador. Internamente, los datos privados siguen estando en memoria contigua dentro del objeto, por lo que con punteros y conversiones forzadas se puede acceder a ellos.

## ¿Cuáles podrían ser las consecuencias de utilizar técnicas como las mostradas en este experimento en un programa real?
Podría causar errores graves, corrupción de memoria, violación de la seguridad de datos y comportamientos indefinidos, además de hacer el código imposible de mantener.

## ¿Qué implicaciones tiene este experimento sobre la confianza en las barreras de encapsulamiento que proporciona C++?
Muestra que las barreras son lógicas, no físicas. En C++ el encapsulamiento depende del compilador, pero no es una protección absoluta contra accesos de bajo nivel.

## ¿Cómo se organizan los atributos en memoria?
En un objeto derivado, primero se almacenan los atributos de la clase base en orden, y luego se agregan los atributos de la clase derivada. Todo queda en memoria contigua dentro del objeto.

## ¿Qué sucede si agregamos más niveles de herencia?
Cada nivel de herencia agrega sus atributos al bloque de memoria del objeto en orden jerárquico: primero los de la clase base más lejana, luego los de las derivadas intermedias, y finalmente los de la derivada más específica.

## ¿Cómo utiliza el programa las vtables para el polimorfismo?
Cada clase con métodos virtuales genera una tabla (vtable) con punteros a sus métodos. Cada objeto guarda un puntero oculto a la vtable de su clase. Cuando se llama un método virtual, el programa consulta la vtable para encontrar la implementación correspondiente.

## ¿Cuál es el impacto en el rendimiento?
El uso de vtables introduce una indirección adicional en las llamadas a métodos virtuales, lo que es un pequeño costo en tiempo de ejecución y en memoria (un puntero extra por objeto). Sin embargo, este costo suele ser mínimo frente a la flexibilidad que se gana.

## ¿Cómo se implementan internamente el encapsulamiento, la herencia y el polimorfismo?
1. El encapsulamiento se implementa con verificaciones del compilador, que impiden acceder a miembros privados/protegidos aunque sigan ocupando memoria.
2. La herencia se refleja en memoria con los atributos de la clase base seguidos de los de la derivada.
3. El polimorfismo se implementa mediante vtables y punteros ocultos en los objetos que permiten llamadas dinámicas a métodos virtuales.

## Análisis: ventajas y desventajas en términos de eficiencia y complejidad.
### Encapsulamiento: Ventaja: mantiene integridad de datos. Desventaja: puede romperse con técnicas de bajo nivel.

### Herencia: Ventaja: reutilización y organización del código. Desventaja: cada nivel aumenta el tamaño y complejidad del objeto.

### Polimorfismo: Ventaja: flexibilidad y comportamiento dinámico. Desventaja: introduce un pequeño costo en memoria y rendimiento.