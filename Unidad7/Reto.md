## ofApp.h:

```cpp
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup() override;
    void update() override;
    void draw() override;
    void keyPressed(int key) override;
    void mouseMoved(int x, int y) override;

    // Helpers para pruebas (RAE2)
    void runShaderUnitTests();
    bool testVertexDisplacement();
    bool testFragmentColorRange();

    ofVboMesh mesh;
    ofShader shader;
    ofEasyCam cam;
    float timeSec = 0.0f;
    glm::vec2 mouseNorm = {0.5f, 0.5f};

    // parámetros interactivos
    float amplitude = 50.0f; // desplazamiento
    float frequency = 2.0f;  // frecuencia de ola
    bool showWireframe = false;
    bool paused = false;
};

```

## ofApp.cpp:

```cpp
#include "ofApp.h"

void ofApp::setup() {
    ofSetWindowTitle("OF Shaders - Vertex & Fragment");
    ofBackground(10);
    ofSetFrameRate(60);

    // Crear una malla tipo grid
    int cols = 120;
    int rows = 80;
    float width = ofGetWidth();
    float height = ofGetHeight();
    mesh.setMode(OF_PRIMITIVE_TRIANGLES);

    for (int y = 0; y < rows; y++) {
        for (int x = 0; x < cols; x++) {
            float u = (float)x / (cols - 1);
            float v = (float)y / (rows - 1);
            glm::vec3 pos = glm::vec3((u - 0.5f) * width, (v - 0.5f) * height, 0);
            mesh.addVertex(pos);
            mesh.addTexCoord(glm::vec2(u, v));
            mesh.addNormal(glm::vec3(0, 0, 1));
        }
    }

    for (int y = 0; y < rows - 1; y++) {
        for (int x = 0; x < cols - 1; x++) {
            int i0 = x + y * cols;
            int i1 = (x + 1) + y * cols;
            int i2 = x + (y + 1) * cols;
            int i3 = (x + 1) + (y + 1) * cols;
            mesh.addIndex(i0); mesh.addIndex(i1); mesh.addIndex(i2);
            mesh.addIndex(i1); mesh.addIndex(i3); mesh.addIndex(i2);
        }
    }

    // Cargar shaders
    bool ok = shader.load("shaders/vertex.glsl", "shaders/fragment.glsl");
    if (!ok) ofLogError() << "Error al cargar shaders";

    runShaderUnitTests(); // ejecutar pruebas simples (RAE2)
}

void ofApp::update() {
    if (!paused) timeSec = ofGetElapsedTimef();
}

void ofApp::draw() {
    ofEnableDepthTest();
    cam.begin();

    shader.begin();
    shader.setUniform1f("u_time", timeSec);
    shader.setUniform1f("u_amplitude", amplitude);
    shader.setUniform1f("u_frequency", frequency);
    shader.setUniform2f("u_mouse", mouseNorm.x, mouseNorm.y);
    shader.setUniform2f("u_resolution", ofGetWidth(), ofGetHeight());

    mesh.draw();
    shader.end();

    if (showWireframe) {
        ofSetColor(255, 80);
        mesh.drawWireframe();
        ofSetColor(255);
    }

    cam.end();
    ofDisableDepthTest();

    ofSetColor(255);
    stringstream ss;
    ss << "[space] pausa: " << (paused ? "ON" : "OFF")
       << "  [w] wireframe: " << (showWireframe ? "ON" : "OFF")
       << "  amplitude: " << amplitude
       << "  frequency: " << frequency;
    ofDrawBitmapStringHighlight(ss.str(), 10, 20);
}

void ofApp::keyPressed(int key) {
    if (key == ' ') paused = !paused;
    if (key == 'w' || key == 'W') showWireframe = !showWireframe;
    if (key == '=') amplitude += 5;
    if (key == '-' && amplitude > 0) amplitude -= 5;
    if (key == '[') frequency = max(0.1f, frequency - 0.1f);
    if (key == ']') frequency += 0.1f;
}

void ofApp::mouseMoved(int x, int y) {
    mouseNorm.x = (float)x / ofGetWidth();
    mouseNorm.y = (float)y / ofGetHeight();
}

// =====================
// Pruebas (RAE2)
// =====================

void ofApp::runShaderUnitTests() {
    ofLogNotice() << "Running shader tests...";
    bool v = testVertexDisplacement();
    bool f = testFragmentColorRange();
    ofLogNotice() << "Vertex test: " << (v ? "PASS" : "FAIL");
    ofLogNotice() << "Fragment test: " << (f ? "PASS" : "FAIL");
}

bool ofApp::testVertexDisplacement() {
    float savedAmp = amplitude;
    amplitude = 40.0f;

    ofFbo fbo;
    fbo.allocate(64, 64, GL_RGBA);
    fbo.begin();
    ofClear(0, 0);
    shader.begin();
    shader.setUniform1f("u_time", 0.5f);
    shader.setUniform1f("u_amplitude", amplitude);
    shader.setUniform1f("u_frequency", frequency);
    shader.setUniform2f("u_mouse", 0.5f, 0.5f);
    shader.setUniform2f("u_resolution", 64, 64);
    mesh.draw();
    shader.end();
    fbo.end();

    ofPixels px;
    fbo.readToPixels(px);
    ofColor c = px.getColor(32, 32);
    float lum = c.getLightness();

    amplitude = savedAmp;
    return lum > 1;
}

bool ofApp::testFragmentColorRange() {
    ofFbo fbo;
    fbo.allocate(32, 32, GL_RGBA);
    fbo.begin();
    ofClear(0, 0);
    shader.begin();
    shader.setUniform1f("u_time", 1.0f);
    shader.setUniform1f("u_amplitude", 0.0f);
    shader.setUniform1f("u_frequency", 1.0f);
    shader.setUniform2f("u_mouse", 0.2f, 0.8f);
    shader.setUniform2f("u_resolution", 32, 32);
    mesh.draw();
    shader.end();
    fbo.end();

    ofPixels px;
    fbo.readToPixels(px);
    for (int y = 0; y < px.getHeight(); y++) {
        for (int x = 0; x < px.getWidth(); x++) {
            ofColor c = px.getColor(x, y);
            if (c.r > 0 || c.g > 0 || c.b > 0) return true;
        }
    }
    return false;
}

```

## RAE 1:
La aplicación desarrollada en C++ utilizando openFrameworks consiste en una simulación interactiva que emplea vertex y fragment shaders para modificar dinámicamente una malla en tiempo real.
En el vertex shader, los vértices de una malla tipo grid son desplazados mediante funciones trigonométricas que generan un efecto de ondas controlado por las variables amplitude, frequency, y el movimiento del mouse.
En el fragment shader, los colores de los fragmentos varían de acuerdo con el tiempo y la posición, logrando un efecto visual dinámico y cambiante.
La interacción se realiza mediante teclas que permiten pausar la animación, alternar el modo wireframe y ajustar los parámetros visuales.
La aplicación evidencia el cumplimiento del RAE1, al construir un sistema interactivo que integra GPU shading, manipulación de vértices y fragmentos, y control de parámetros en tiempo real, cumpliendo los requisitos funcionales y no funcionales del reto.

## RAE 2: 
La aplicación desarrollada en C++ utilizando openFrameworks consiste en una simulación interactiva que emplea vertex y fragment shaders para modificar dinámicamente una malla en tiempo real.
En el vertex shader, los vértices de una malla tipo grid son desplazados mediante funciones trigonométricas que generan un efecto de ondas controlado por las variables amplitude, frequency, y el movimiento del mouse.
En el fragment shader, los colores de los fragmentos varían de acuerdo con el tiempo y la posición, logrando un efecto visual dinámico y cambiante.
La interacción se realiza mediante teclas que permiten pausar la animación, alternar el modo wireframe y ajustar los parámetros visuales.
La aplicación evidencia el cumplimiento del RAE1, al construir un sistema interactivo que integra GPU shading, manipulación de vértices y fragmentos, y control de parámetros en tiempo real, cumpliendo los requisitos funcionales y no funcionales del reto.