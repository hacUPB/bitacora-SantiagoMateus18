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

## 