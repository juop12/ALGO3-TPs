# Preguntas Teóricas:

## Aporte de los mensajes de DD
En un Double Dispatch, el receptor de un mensaje es polimórfico, sin embargo también lo es el parámetro que se le pasa.
El primer llamado es un mensaje a una clase polimórfica que aporta solo la mitad de la información, debido al doble polimorfísmo. 

El segundo llamado será enviado al colaborador del primer llamado y tendrá como colaborador externo al objeto que recibió el primer llamado, aportando así, el resto de la información. De esta forma, el comportamiento de las colaboraciones cambia dependiendo de la relación entre ambos objetos.

## Lógica de instanciado

Por definición, una clase Abstracta no instancia objetos, sin embargo, una clase concreta sí. El lugar más óptimo para instanciar un objeto es en el apartado Class de la clase de dicho objeto o de alguna de sus SuperClases. Se debe instanciar en dicho apartado ya que sino se están mezclando los conceptos de instancia y clase. 

> Es más sencillo explicarlo con un ejemplo:
> 
> Se tiene dos entes, una silla y una idea de silla. Las sillas son instancias de la idea de silla (clase silla). Si se quiere crear una silla nueva, no se le pediría a la silla que lo haga. Es más lógico pedirselo a la idea de silla ya que es la base de todas las sillas posibles.

Si se crean objetos desde distintos lugares y de formas diferentes intentaríamos buscar un patrón entre ellos. Luego, buscaríamos abstraer el código de forma tal que pudieramos decantarle la responsabilidad de instanciarlos a la clase o la SuperClase apropiada.

## Nombres de las categorías de métodos
Normalmente nombramos las categorías de métodos basándonos en qué hacen los métodos que pertenecen a esa categoría. Un buen ejemplo es cómo se categorizan los mensajes de la clase Entero; tiene secciones para los operadores aritméticos, la inicialización o para acceder a colaboradores internos. 

Si son métodos que solo son llamados por otros métodos dentro de la misma clase, serán categorizados como "privados". En el caso de que verifiquen condiciones, serán puestos en "asserting", y si son mensajes de error, estarán en "error".

## Subclass Responsibility

Ponemos este mensaje en la SuperClase porque es una clase abstracta. Es decir, nunca se tendrá un objeto de clase Numero. Sin embargo, al ver la clase y leer subclassResponsibility se sabe que si se crea una nueva subclase en la jerarquía, esta tendrá que saber responder el mensaje con un método propio.

## No rompas

Romper encapsulamiento no está bien ya que a la hora de leer el código se volvería confuso entender el flujo de la información. Por otra parte, un modelo sin encapsulamiento no modelaría la realidad correctamente. Esto se debe a que es importante respetar las privacidades y responsabilidades de los entes de la realidad a la hora de incluirlos en el modelo. Hay ciertos colaboradores y mensajes que deben ser privados entre clases o no tienen la necesidad de ser públicos.


