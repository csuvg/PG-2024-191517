# Proyecto de Graduación

## Descripción
Este proyecto consiste en el desarrollo de una aplicación móvil para recorridos virtuales dentro de un campus universitario, con el objetivo de evaluar la viabilidad de la reciente adquisición de sensores de banda ultraancha (UWB). La aplicación integra estos sensores para determinar la ubicación precisa de los usuarios y así guiar al usuario en el tour. También utiliza los sensores del celular para detectar la orientación del dispositivo y así dibujar una flecha en la pantalla.

La implementación se realizó utilizando la arquitectura MVVM combinada con Clean Architecture, lo que garantizó un diseño escalable y modular, facilitando futuras ampliaciones y el desarrollo de pruebas unitarias.

También se incluye un simulador de sensores para permitir el desarrollo de funcionalidades sin utilizar el hardware real. Este simulador utiliza el protocolo UDP para comunicarse con la aplicación y simular los datos de los sensores.

## Instrucciones de instalación

### sensor-dashboard
Este es el frontend del simulador de sensores. Está programado en Javascript y utiliza React para la interfaz gráfica. Para utilizarlo se deben ejecutar los siguientes comandos:

1. ```cd src/sensor-dashboard```
2. ```npm install```
3. ```npm start```

### sensor-simulation-server
Este es el backend del simulador de sensores. Está programado en Javascript y utiliza Node.js para el servidor. Para utilizarlo se deben ejecutar los siguientes comandos:

1. ```cd src/sensor-simulation-server```
2. ```npm install```
3. ```npm start```

### uvg-tour-app
Esta aplicación de iOS está programada en Swift y utiliza SwiftUI para la interfaz gráfica. Para utilizarla es necesario contar con una computadora que tenga macOS y Xcode instalado. Los pasos para ejecutar la aplicación son los siguientes:

1. ```cd src/uvg-tour-app```
2. ```abrir UVG\ Tour.xcodeproj```
3. Ejecutar la aplicación en un simulador o en un dispositivo físico.


## Demostración
A continuación se muestra un video de la aplicación en funcionamiento:

[Ver demo del proyecto](demo/Demo.mp4)

