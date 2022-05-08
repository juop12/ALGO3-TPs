# Preguntas Teóricas:

## Aporte de los mensajes de DD
En un Double Dispatch, el receptor de un mensaje es polimórfico, sin embargo también lo es el parámetro que se le pasa.
El primer llamado es un mensaje a una clase polimórfica normal, pero en este caso aporta solo la mitad de la información, ya que el parámetro de ese mensaje también es polimórfico. 

El segundo llamado será al parámetro del primer llamado y tendrá como parámetro al objeto que hizo el primer llamado, de esa forma cambiando su comprotamiento dependiendo de la relación entre ambos objetos y aportando el resto de la información.

## Lógica de instanciado
Antes de este ejercicio siempre instanciabamos los objetos en los métodos de los mensajes, sin embargo ahora está implementado un mensaje setUp en donde se instancian los objetos. 

Nos parece que cuando tenemos muchos tests en los que haremos uso de objetos para verificar resultados y vamos a reutilizar algunos de estos en los tests conviene instanciarlos en un mensaje, pues quedan más ordenados y nos evitamos repetir código.

Sin embargo si vamos a reutilizar los nombres de las variables pero el objeto adentro va a ser distinto, entonces nos parece mejor instanciar en cada test, pues así no hay conflicto entre ellos.

## Nombres de las categorías de métodos
Normalmente nombramos las las categorías de métodos basándonos en su función. Un buen ejemplo es como se ven los mensajes de la clase entero, que tiene secciones para los operadores aritméticos, la inicialización o acceder a datos.

## Subclass Responsibility

Ponemos este mensaje en la superclase porque esta en una clase abstracta. Nunca tendremos un objeto de clase Numero, por lo que cuando los programadores ven la clase y leen Subclass Responsibility saben que si crean una nueva subclase en la jerarquía, esta debería saber responder el mensaje con un método.

## No rompas

Romper encapsulamiento no estaría bien porque leer el programa se volvería confuso. Ha ciertas cosas que tienen que ser privadas para cada clase y puede hacer nuestro código más confuso de leer usarlas cuando trabajamos en otro espacio.
