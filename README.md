# Aplicación de prueba para Huemul Solutions

Un proyecto desarrollado en Flutter

## Introducción

Este proyecto tenia como requerimiento el poder interactuar con una API REST, implementando todas las funciones necesarias, tales como GET, PUT, DELETE y UPDATE, con las cuales el usuario puede ingresar nuevos items, modificarlos, eliminarlos y listarlos. Todo desde la interfaz de la aplicación.

Esta aplicación fue probada en un celular con Android y desde Google Chrome, desde ambas plataformas se puede realizar las mismas funciones.
Para ejecutar esta aplicación, lo primero es descargar e instalar la ultima version de Flutter desde la página oficial, luego se debe instalar el IDE Android Studio, el cual permite ejecutar la aplicación tanto en celulares con Android o desde el navegador o aplicación de escritorio.

## Ejecución desde Navegador

Una nota importante,  para que desde el navegador Chrome se pueda interactuar con la API, fue necesario desactivar una opción de seguridad, ya que los navegadores tienen una medida de seguridad que impide conectarse a fuentes externas, si es que desde el servidor no se le da acceso. (CORS, Cross Origin Resource Sharing). Y como en este caso no tuve acceso al lado del servidor, solo pude desactivar esa medida de seguridad. Pero en un entorno real, se debe hacer una modificación en el servidor para que esta solución sea definitiva.

A continuación se muestran los pasos que se realizaron para desactivar esta configuración y que permitiera interactuar con la API desde el navegador Chrome:

/*
Solución temporal a error CORS cross origin de conexion a API desde chrome
1- Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
2- Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
3- Find '--disable-extensions'
4- Add '--disable-web-security'

La solucion definitiva seria que desde el server donde esta la API permitan el origen de esta app
*/


## Nota sobre el resultado con el request GET ALL

Al hacer la request GET ALL, desde Postman o desde la aplicación, solo devolvía un resultado, posiblemente por alguna configuración que se haya hecho desde el servidor. por lo que para poder hacer una lista con los resultados, se tuvo que hacer un ciclo for que va iterando por las IDs, agregandolas al final de la URL de la API, solución que tampoco es la ideal, ya que solo muestra desde la ID 1 hasta la 10 y toma un tiempo en cargar. 

Por lo que para esto también se hizo una solución temporal. En entorno real, la API debería dar un listado con todos los resultados al hacer un request GET, y eso se tendría que configurar desde el lado del servidor.
