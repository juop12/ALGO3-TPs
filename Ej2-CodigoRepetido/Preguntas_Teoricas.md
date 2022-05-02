# Preguntas Teóricas

## Abstracción de los tests 01 y 02:

En los tests 01 y 02, el código repetido mide el tiempo en el que se realiza una acción particular. Una entidad de la realidad que cumple esta función es un cronómetro.

Curiosamente, aunque en una primera aproximación implementamos con mensajes dicho ente, descrubrimos más tarde que la clase TestCase (Superclase de CustomerBookTest) ya responde a mensajes aptos para resolver el problema. Por lo tanto, descartamos nuestro modelo y utilizamos el protocolo de TestCase ya definido en Cuis que cumple el mismo propósito. Dicese, abstraernos de colaboraciones redundantes en los tests y cronómetrar su evaluación.

## Cómo representar en Smalltalk

En Smalltalk al representar entes de la realidad se puede utilizar objetos (individuales) o clases (con instancias). A la hora de trabajar con objetos, se crea un modelo particular de una entidad real. Se lo modifica a través del tiempo a partir de la creación de mensajes que puede responder (y sus respectivos métodos). Por otro lado, al trabajar con clases, creamos diferentes instancias de estas y les enviamos mensajes que las definen. Los objetos pueden tener una relación de padre e hijo, mientras que las clases tienen relación de clase, subclase y superclase. 

## Teoría de Naur

Quitar código repetido está ligado a las ideas de Naur, incluso fue el foco principal en uno de los ejemplos explicados en el paper. 

Ejemplo: 

    Se nos presenta el caso de un equipo A que crea un compilador y un equipo B que va a construir sobre el código del grupo A para hacer una extensión a ese     compilador. Cuando el grupo B escribe el código y lo manda al grupo A, estos notan que no se estaba haciendo uso de funciones implementadas previamente por ellos. El grupo B creó funciones que cumplían el mismo propósito que otras ya existentes, destruyendo el poder y simplicidad del código original. 

El equipo B repitió código cuando pudo usar lo que ya estaba implementado, muy parecido a lo que nos sucedió en este ejercicio. Vimos esto de primera mano en los test 01 y 02, para quitar las colaboraciones repetidas lo primero que hicimos fue definir nuevos mensajes que funcionaran como un cronómetro. Sin embargo, los desarrolladores de Cuis habrían utilizado mensajes ya existentes, pues ellos conocen el entorno que crearon.

En conclusión, la relación entre la teoría de Naur y quitar código repetido, es que, generalmente, el código repetido es producto de desconocer la manera más eficiente de construir sobre un software dado. No conociendo el programa y sus capacidades en profundidad, se piensa en reinventar la rueda. Así surgen las colaboraciones redundantes.
