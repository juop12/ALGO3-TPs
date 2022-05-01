# Preguntas Teóricas

## Abstracción de los tests 01 y 02:

El los tests 01 y 02 el tipo de código que se repite es el que mide el tiempo en el que se realizan una acción, por lo que la entidad de la realidad que podemos crear en nuestro código para poder usarla en ambos tests es un cronómetro.
Cuariosamente, aunque en un primer momento implementamos con mensajes una función para medir el tiempo, luego nos dimos cuenta que la clase TestCase (Superclase de CustomerBookTest) ya tenía implementada un mensaje que cumplía esta función por lo que lo pudimos usar para nuestros fines.

## Cómo representar en Smalltalk

En smalltalk para representar entes de la realidad podemos utilizar clases u objetos. Al trabajar con objetos, tenemos un objeto que vamos modificando con el tiempo a través de mensajes, mientras que al trabajar con clases, creamos diferentes instancias de estas y les pasamos mensajes. Los objetos pueden tener una relación de padres e hijos, mientras que las clases tienen relación de clase, subclase y superclase. 

## Teoría de Naur

En una parte del paper se nos presenta el caso de un equipo A que crea un compilador y un equipo B que va a construir sobre el código del grupo A para hacer una extensión a ese compilador. Vemos que cuando el grupo B creaba código y lo mandaba al grupo A, estos notaban que no estaban haciendo uso de lo que ya estaba implementado, sino que creaban nuevas cosas que hacían lo mismo, destruyendo el poder y simplicidad del código. 
El equipo B estaba repitiendo código cuando todo el tiempo pudo usar lo que ya estaba ahí, muy parecido a lo que vimos en este ejercicio. 
Vimos esto de primera mano en los test uno y dos. Cuando quisimos quitar los mensajes repetidos lo primero que hicimos fue crear nuevos mensajes que funcionaran como un cronómetro para mensajes, sin embargo si los desarrolladores de smalltalk hubieran visto eso, rápidamente me hubieran dicho que ya existe una función que hace lo que yo intento hacer, pues ellos conocen el entorno que crearon.
