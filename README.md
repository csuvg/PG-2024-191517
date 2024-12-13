# Proyecto de Graduación

Este proyecto consiste en el desarrollo de una aplicación móvil para recorridos virtuales dentro de un campus universitario, con el objetivo de evaluar la viabilidad de la reciente adquisición de sensores de banda ultraancha (UWB). La aplicación integra estos sensores para determinar la ubicación precisa de los usuarios y así guiar al usuario en el tour. También utiliza los sensores del celular para detectar la orientación del dispositivo y así dibujar una flecha en la pantalla.

La implementación se realizó utilizando la arquitectura MVVM combinada con Clean Architecture, lo que garantizó un diseño escalable y modular, facilitando futuras ampliaciones y el desarrollo de pruebas unitarias.

También se incluye un simulador de sensores para permitir el desarrollo de funcionalidades sin utilizar el hardware real. Este simulador utiliza el protocolo UDP para comunicarse con la aplicación y simular los datos de los sensores.