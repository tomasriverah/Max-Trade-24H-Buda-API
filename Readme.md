
## Tomás Rivera H 

Hola, primero que todo gracias por tomarte el tiempo de revisar este repositorio. Para correrlo se debe correr el archivo ```main.rb```, el cual despues de un par de segundos y algunos mensajes en consola debería entregar un archivo ```out.html```. Este archivo contiene la tabla pedida con la transacción más alta de cada mercado en que transa buda.com en las ultimas 24h. El código tiene varios comentarios que espero ayuden a su legibilidad.

La idea general del programa, es obtener primero los id de mercado. Posteriormente se itera sobre cada uno ellos obteniendo la transacción más alta de las ultimas 24h. Para realizar esto se utiliza la API de Buda llamando a al historial de transacciones por timestamp y con el máximo permitido de acuerdo a la documentación. Esto se realiza hasta que el ultimo timestamp de transacción es de una antigüedad mayor a 24h. En cada una de estas iteraciones se registra el valor máximo y se verifica que su timestamp sea valido por antigüedad. Finalmente cuando se obtienen todos los maximos se llama a la función que genera el html y entrega el output final.

La tarea está hecha en ```ruby 2.6.5p114```. Esta tarea ocupa los modulos de ```rails``` 5.2.4.4, ```rest-client``` 2.0.2-3.1, y ```json```.

El archvio out.html es un ejemplo del output esperado. A continuación un ejemplo de como se ve.

![alt text](./Tabla.png?raw=true "Table")




Espero puedas correr los script sin inconvenientes.

Saludos!