# Preguntas Teóricas

## Abstracción de los tests 01 y 02:

En los tests 01 y 02, el código repetido mide el tiempo en el que se realiza una acción particular. Una entidad de la realidad que cumple esta función es un cronómetro.

Curiosamente, aunque en una primera aproximación implementamos con mensajes dicho ente, descrubrimos más tarde que la clase TestCase (Superclase de CustomerBookTest) ya responde a mensajes aptos para resolver el problema. Por lo tanto, descartamos nuestro modelo y utilizamos el protocolo de TestCase ya definido en Cuis que cumple el mismo propósito. Dicese, abstraernos de colaboraciones redundantes en los tests y cronómetrar su evaluación.

## Cómo representar en Smalltalk

En Smalltalk al representar entes de la realidad se puede utilizar objetos (individuales) o clases (con instancias). A la hora de trabajar con objetos, se crea un modelo particular de una entidad real. Se lo modifica a través del tiempo a partir de la creación de mensajes que puede responder (y sus respectivos métodos). Por otro lado, al trabajar con clases, creamos diferentes instancias de estas y les enviamos mensajes que las definen. Los objetos pueden tener una relación de padre e hijo, mientras que las clases tienen relación de clase, subclase y superclase. 

## Teoría de Naur

En una parte del paper se nos presenta el caso de un equipo A que crea un compilador y un equipo B que va a construir sobre el código del grupo A para hacer una extensión a ese compilador. Vemos que cuando el grupo B creaba código y lo mandaba al grupo A, estos notaban que no estaban haciendo uso de lo que ya estaba implementado, sino que creaban nuevas cosas que hacían lo mismo, destruyendo el poder y simplicidad del código. 
El equipo B estaba repitiendo código cuando todo el tiempo pudo usar lo que ya estaba ahí, muy parecido a lo que vimos en este ejercicio. 
Vimos esto de primera mano en los test uno y dos. Cuando quisimos quitar los mensajes repetidos lo primero que hicimos fue crear nuevos mensajes que funcionaran como un cronómetro para mensajes, sin embargo si los desarrolladores de smalltalk hubieran visto eso, rápidamente me hubieran dicho que ya existe una función que hace lo que yo intento hacer, pues ellos conocen el entorno que crearon.
