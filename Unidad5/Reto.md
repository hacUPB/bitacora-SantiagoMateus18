## Diseño y desarrollo del proyecto

### Pregunta 1: ¿Cuál fue la idea inicial de tu proyecto de arte generativo en openFrameworks?
Mi idea fue generar una aplicaicón de escritorio que simulara un "Paint" sencillo donde lo único que se pudiera editar son los componentes de un rostro. 

### Pregunta 2: ¿Qué tipo de pinceles, figuras o dinámicas decidiste implementar y por qué?
Decidí implementar 3 pinceles, con distinto grosor, forma y color para que el usuario tuviera elementos no tan limitados de edición.

### Pregunta 3: ¿Cómo aplicaste los conceptos de encapsulamiento, herencia y polimorfismo en el diseño de tus pinceles/clases?

Foto del programa mostrando la cara base dibujada.
![alt text](image-7.png)


Foto mostrando el uso de un pincel (círculo, cuadrado o dinámico).
![alt text](image-8.png)


Foto mostrando el cambio de color o grosor.
![alt text](image-9.png)

## Experimentación – Memoria, rendimiento y optimización

### Pregunta 4: ¿Qué impacto tuvieron tus decisiones de diseño (uso de objetos, clases, métodos virtuales, etc.) en el rendimiento del programa?
El uso de clases y métodos virtuales permitió flexibilidad y polimorfismo, pero añadió una ligera sobrecarga en el rendimiento, aunque casi imperceptible en este proyecto.

### Pregunta 5: ¿Qué mediciones hiciste en Visual Studio para comprobar memoria y rendimiento?
El uso de clases y métodos virtuales permitió flexibilidad y polimorfismo, pero añadió una ligera sobrecarga en el rendimiento, aunque casi imperceptible en este proyecto.

### Pregunta 6: ¿Intentaste optimizar alguna parte del código? ¿Cómo?
Ooptimicé evitando cálculos innecesarios en draw() y usando estructuras simples como vectores en lugar de contenedores más pesados.

Foto de una prueba de rendimiento en Visual Studio (por ejemplo, FPS o profiler).
![alt text](image-11.png)

## PROMT PARA ChatGPT: "¿Cómo puedo optimizar mi proyecto de arte generativo en openFrameworks para mejorar el rendimiento? ¿Qué impacto tienen los métodos virtuales y cómo puedo minimizar su sobrecarga?" 

Usa ofMesh / VBOs / instancing para reducir draw calls.
Mueve cálculos a shaders en GPU.
Evita recalcular datos que no cambian cada frame.
Métodos virtuales añaden una ligera sobrecarga por la vtable.
Minimízala usando final, plantillas (CRTP) o composición en lugar de herencia profunda.

## Reflexión y Ajuste Final

### Pregunta 7: ¿Qué ajustes finales realizaste para mejorar el código o la experiencia de usuario?
Implementé cambios en la organización para unir distintos tipos de datos y que la memoria se usara de forma más ahorrativa o asertiva. Además, diseñé funciones para que fuera más intuitivo, fácil de usar y personalizable. Una funcion final importante fue el uso de una memoria que guarda los tamaños y colores de los puntos, para que cuando el usuario al cambiar sus atributos, como color y tamaño, no cambie  los puntos ya dibujados anteriormente.

### Pregunta 8: ¿Cómo influyó el entendimiento de los mecanismos internos de OOP en tu forma de programar el proyecto?
Por medio de los conocimientos adquiridos en clase pude determinar maneras sencillas pero funcionales para generar encapsulamiento de clases y que tengan atributos no editables o alterables. El polimorfismo y la herencia se ve en como implementé el cambio de tamaños y 'Brushes' en el código. 

## Pregunta 9: ¿Qué desafíos enfrentaste y cómo los resolviste?
En general lo más difícil fue implementar cada cosa que se me ocurría, ya fuera algo estético o funcional para implementar herencia y polimorfismo.

## Pregunta 10: ¿Qué aprendiste sobre el equilibrio entre diseño (código limpio, OOP) y eficiencia (rendimiento, optimización)?
Aprendí que un buen diseño con OOP hace el código más claro y mantenible, pero a veces hay que sacrificar complejidad para no perder eficiencia en el rendimiento.

Foto de la versión final del proyecto funcionando.
![alt text](image-12.png)
 
## Evidencias de Resultados de Aprendizaje (RAE)

### RAE1: Construcción de la aplicación interactiva.
#### Pregunta 11: ¿Cómo demuestras que tu aplicación cumple con los requisitos funcionales y no funcionales establecidos?
El código deja en claro el uso de polimorfismos y herencia entre clases. Y los requisitos no funcionales como el ajuste de memoria también por medio de la gestión de la misma, eliminando lo que no y utilizando variables con métodos ya creados por OF, junto con atributos "unidos".

### RAE2: Pruebas de las partes y del todo de la aplicación.
#### Pregunta 12: ¿Qué pruebas hiciste a cada parte del proyecto (pinceles, cambio de color, tamaño, temporizador)?
Probé cada método mientras diseñaba la interfaz con tal de ver si funcionaba en ese momento. Cada cambio que le hice era probado inmediatamente. Finalmente después de tener el Reto que entregué en Unidad4, proseguí a probarlo entero cada parte que poseía. 

### Pregunta 13: ¿Qué pruebas hiciste al proyecto completo y cómo comprobaste que funciona de manera correcta?
Realicé diversos dibujos, probé que el grosor de los puntos cambiara, intercambié el pincel por los 3 que hay. Probé todos los colores y la interfaz visual funciona a la perfección pues todos los textos se encuentran visibles.

## Prueba de funcionamiento total: 
[Video con todas las funciones (Sin VOZ)](https://www.youtube.com/watch?v=94VWEn7CR-Y)

## Código completo

``` .h:
#pragma once

#include "ofMain.h"

class Node {
public:
	int value;
	Node * next;

	Node(int v) {
		value = v;
		next = nullptr;
	}
};



class Queue {
public:
	Node * front;
	Node * rear;

	Queue() {
		front = rear = nullptr;
	}

	~Queue() {
		clear();
	}

	void enqueue(int v) {
		Node * nuevo = new Node(v);
		if (rear == nullptr) {
			front = rear = nuevo;
		} else {
			rear->next = nuevo;
			rear = nuevo;
		}
	}

	void clear() {
		while (front != nullptr) {
			Node * temp = front;
			front = front->next;
			delete temp;
		}
		rear = nullptr;
	}

	int backValue() {
		if (rear != nullptr) return rear->value;
		return 0;
	}
};

class Brush {
public:
	virtual ~Brush() { }
	virtual void draw(float x, float y, ofColor color) = 0;
	virtual void increaseSize() { }
	virtual void decreaseSize() { }
	virtual float getSize() const { return 0.f; }
};

class CircleBrush : public Brush {
protected:
	float radius;

public:
	CircleBrush(float r = 5.0f)
		: radius(r) { }
	void draw(float x, float y, ofColor color) override {
		ofSetColor(color);
		ofDrawCircle(x, y, radius);
	}
	void increaseSize() override { }
	void decreaseSize() override { }
	float getSize() const override { return radius; }
};

class SquareBrush : public Brush {
protected:
	float size;

public:
	SquareBrush(float s = 6.0f)
		: size(s) { }
	void draw(float x, float y, ofColor color) override {
		ofSetColor(color);
		ofDrawRectangle(x - size / 2.0f, y - size / 2.0f, size, size);
	}
	void increaseSize() override { size += 1.0f; }
	void decreaseSize() override {
		if (size > 1.0f) size -= 1.0f;
	}
	float getSize() const override { return size; }
};


class DynamicCircleBrush : public CircleBrush {
public:
	DynamicCircleBrush(float r = 5.0f)
		: CircleBrush(r) { }

	void increaseSize() override { radius += 1.0f; }
	void decreaseSize() override {
		if (radius > 1.0f) radius -= 1.0f;
	}
};


class ofApp : public ofBaseApp {

public:
	void setup();
	void update();
	void draw();
	void push_back();
	void clear();
	void keyPressed(int key);
	void keyReleased(int key);
	void mouseMoved(int x, int y);
	void mouseDragged(int x, int y, int button);
	void mousePressed(int x, int y, int button);
	void mouseReleased(int x, int y, int button);
	void mouseEntered(int x, int y);
	void mouseExited(int x, int y);
	void windowResized(int w, int h);
	void dragEvent(ofDragInfo dragInfo);
	void gotMessage(ofMessage msg);
	void PopPoint();

	struct ColorPoint {
		ofVec2f position;
		ofColor color;
		float size;
		char brushType;
	};

	vector<ColorPoint> points;
	bool flag = false;
	ofColor color;
	std::map<char, ofColor> colorMap;
	std::map<char, std::string> colorName;

	Queue cola;
	int lastSecond = -1;

	Brush * currentBrush = nullptr;
};
```

```.cpp:
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
	//Background
	ofSetBackgroundColor(224, 224, 224);
	color = ofColor::black;

	colorMap['q'] = ofColor(245, 39, 39); //Rojo
	colorName['q'] = "Rojo";
	colorMap['w'] = ofColor(77, 54, 54); //Marron
	colorName['w'] = "Marron";
	colorMap['e'] = ofColor(84, 198, 232); //Celeste
	colorName['e'] = "Celeste";
	colorMap['r'] = ofColor(163, 113, 113); //Rosa oscuro (arrugas y demás)
	colorName['r'] = "Rosa oscuro para arrugas y otros";
	colorMap['t'] = ofColor(0); //Negro again
	colorName['t'] = "Negro otra vez";

	 if (currentBrush) delete currentBrush;
	currentBrush = new DynamicCircleBrush(5.0f);
}

//--------------------------------------------------------------
void ofApp::update(){
	int currentSecond = (int)ofGetElapsedTimef();

	if (currentSecond != lastSecond) {
		cola.enqueue(currentSecond);
		lastSecond = currentSecond;
	}
}
//--------------------------------------------------------------
void ofApp::PopPoint() {
	if (!points.empty())
	{
		points.pop_back();
	}
}

//--------------------------------------------------------------
void ofApp::draw(){
	//Cara
	ofSetColor(255, 220, 180);
	ofDrawCircle(ofGetWidth() / 2, ofGetHeight() / 2, 200);

	for (const auto & cp : points) {
		ofSetColor(cp.color);
		if (cp.brushType == 'C') {
			ofDrawCircle(cp.position, cp.size);
		} else if (cp.brushType == 'S') {
			ofDrawRectangle(cp.position.x - cp.size / 2, cp.position.y - cp.size / 2, cp.size, cp.size);
		} else if (cp.brushType == 'D') {
			ofDrawCircle(cp.position, cp.size); // Dynamic Circle
		}
	}

		int y = 20;

		for (auto const & [key, col] : colorMap) {
			string KeyStr(1, key);
			string info = "Tecla: " + KeyStr + "-> Color: " + colorName[key];
			ofSetColor(0);
			ofDrawBitmapString(info, 20, y);
			y += 20;
		}

		string message = "Dibuja una carita, lo que tu quieras :D ";
		ofSetColor(0);
		ofDrawBitmapString(message, 600, 20);

		string message2 = "Designed por Santiago Mateus";
		ofSetColor(0);
		ofDrawBitmapString(message2, 600, 640);

		ofSetColor(0);
		ofDrawBitmapString("Segundos transcurridos:", 20, ofGetHeight() - 40);
		ofDrawBitmapString(ofToString(cola.backValue()), 20, ofGetHeight() - 20);

		string message3 = "Oprime [1], [2] y [3] para elegir distintos pinceles";
		ofSetColor(0);
		ofDrawBitmapString(message3, 600, 60);

		ofSetColor(0);
		string brushInfo = "Ancho del Pincel: ";
		if (currentBrush) brushInfo += ofToString(currentBrush->getSize());
		ofDrawBitmapString(brushInfo, 600, 100);
	

}


//--------------------------------------------------------------
void ofApp::clear() {

	points.clear();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){
	if (colorMap.find(key) != colorMap.end()) {
		color = colorMap[key];
	}
	if (key == 'c') {
		PopPoint();
	}

	if (key == 'd') {
		clear();
	}

	if (key == '+' || key == '=') { // '=' por teclas sin shift en algunos layouts
		if (currentBrush) currentBrush->increaseSize();
	}
	if (key == '-') {
		if (currentBrush) currentBrush->decreaseSize();
	}

	// Cambiar tipo de pincel: 1 = circle, 2 = square, 3 = dynamic circle
	if (key == '1') {
		delete currentBrush;
		currentBrush = new CircleBrush(5.0f);
		std::cout << "Brush cambiado a CircleBrush (fijo)" << std::endl;
	}
	if (key == '2') {
		delete currentBrush;
		currentBrush = new SquareBrush(8.0f);
		std::cout << "Brush cambiado a SquareBrush" << std::endl;
	}
	if (key == '3') {
		delete currentBrush;
		currentBrush = new DynamicCircleBrush(6.0f);
		std::cout << "Brush cambiado a DynamicCircleBrush (Aumenta y Disminuye)" << std::endl;
	}

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
	if (currentBrush != nullptr)
	{
		ColorPoint cp;
		cp.position = ofVec2f(x, y);
		cp.color = color;
		cp.size = currentBrush->getSize();

		if (dynamic_cast<DynamicCircleBrush*>(currentBrush)) {
			cp.brushType = 'D'; // Dynamic Circle Brush
		}
		else if (dynamic_cast<SquareBrush*>(currentBrush)) {
			cp.brushType = 'S'; // Square Brush
		}
		else if (dynamic_cast<CircleBrush*>(currentBrush)) {
			cp.brushType = 'C'; // Circle Brush
		}

		points.push_back(cp);
	}
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
	flag = true;
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
	flag = false;
}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
```

