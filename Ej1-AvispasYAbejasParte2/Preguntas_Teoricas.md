# Preguntas Teóricas:

## Sobre implementar funcionalidad

  Implementamos los primeros test en clase y nos centramos en pasar cada prueba de manera secuencial. Por lo tanto, no pasaron los 3 tests de una. En nuestro caso particular, decidimos verificar cada test y luego volver a verificar sus anteriores. En definitiva, seguimos este orden al hacer las pruebas.

<pre>
  1. |1      |
  2. |2 1 2  | 
  3. |3 1 2 3|
</pre>
  
  En el caso (2.) verificamos el test 2, luego el 1 y luego el 2 denuevo para estar seguros de que todo anda correctamente.
  
  Implementar el codigo a partir de tus pruebas me parece una buena idea ya que vas avanzando de a pasitos y siempre tenes un codigo que funciona y se puede verificar.
  
## Sobre código repetido

  Tenemos casos de código repetido. En nuestro caso, las orugas y las polillas se ven representadas de manera muy similar. Creemos que podriamos haber representado  a los recursos del dominio de otra forma. Por ejemplo, un único objeto ( lista ) que contenga a todos los recursos necesarios y los atributos asociados a ellos. Asímismo, podríamos haber creado una única categoría de mensajes más general, llamada recursos, que reciba colaboradores externos, como oruga o polilla, y regule   las interacciones del resto de objetos con estos recursos.
  
  El objeto Habitat es, en nuestro caso, el gran regulador de recursos y datos de todo el programa. Es decir, el hábitat es el responsable de ver si hay suficientes polillas u orugas y dejar huevos. En definitiva, este objeto hace todas las operaciones necesarias y posee colaboradores internos con la información de los recursos. Esto se debe a que el hábitat funciona como un centro de información; ayuda a mantener una abstracción simple y sencilla de la realidad. 
  
  A grandes rasgos, hacer que cada insecto guarde información acerca de sus respectivos recursos y huevos puede ser, como no, beneficioso. En particular, que cada insecto tenga de colaborador interno a sus respectivos huevos es una representación más fiel de la realidad que la que planteamos. Sin embargo, esto haría que el programa sea más complejo en términos de jerarquía.
  
  Por lo tanto, a pesar de siempre poder mejorar nuestra representación de la realidad, por el momento y teniendo en cuenta el problema que estamos atacando, no vemos necesario cambiar el rumbo de nuestro programa.
  
## Sobre código repetido 2
  Nuestro código siguió un modelo de Wittgenstein, pues al darnos cuenta de que los insectos tenían muchos mensajes que se parecían, incluso Oriana y Ornella teniendo los mismos mensajes, decidimos que tuvieran una relación de parentesco. 
  
Con respecto a la implementación, guardamos la cantidad de huevos de avispa como un colaborador interno del habitat, también utilizamos un diccionario para  llevar la cuenta de cuantos hijos tenía cada avispa, teniendo como claves los nombres de los insectos (Ornella y Oriana compartiendo un lugar).

La verdad, para poder hacerlo de esta forma tuvimos que pensar un tanto más. Pudimos haber hecho algo más simple y probablemente también hubiera funcionado. Sin embargo me parece que valió la pena usar un diccionario, para modularizar mejor los mensajes y que todo quede más ordenado. Además, nos sirve utilizar cosas nuevas para estar más preparados a la hora de afrontar problemas más complejos.  
  
