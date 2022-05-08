!classDefinition: #NumeroTest category: 'Numeros-Parte2-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:50'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 16:17:58'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:39:57'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:10'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:22'!
test07EnteroDividesEnteroCorrectly

	self assert: one equals: two / two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:40:57'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:20'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:34'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: fiveHalfs equals: oneHalf / oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:41:58'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: (Entero with: 6) / (Entero with: 5) equals: one + oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:42:29'!
test12FraccionAddsEnteroCorrectly

	self assert: (Entero with: 6) / (Entero with: 5) equals: oneFifth + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: twoFifth equals: two * oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:27'!
test14FraccionMultipliesEnteroCorrectly

	self assert: twoFifth equals: oneFifth * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:40'!
test15EnteroDividesFraccionCorrectly

	self assert: fiveHalfs equals: one / twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:43:58'!
test16FraccionDividesEnteroCorrectly

	self assert: twoTwentyfifth equals: twoFifth / five! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:44:53'!
test19AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:13'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (two/five) * (five/two)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:27'!
test21DividingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf / oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:45:40'!
test22DividingEnterosCanReturnAFraccion

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:17'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:50:32'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: Numero canNotDivideByZeroErrorDescription equals: anError messageText ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:21'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two equals: three - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:36'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: oneFifth equals: twoFifth - oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:46:50'!
test29EnteroSubstractsFraccionCorrectly

	self assert: oneHalf equals: one - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:11'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: oneFifth equals: sixFifth - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:25'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: one equals: threeHalfs - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:44'!
test32SubstractingSameEnterosReturnsZero

	self assert: zero equals: one - one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:47:59'!
test33SubstractingSameFraccionesReturnsZero

	self assert: zero equals: oneHalf - oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:16'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: negativeThreeHalfs equals: one - fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:45'!
test35FibonacciZeroIsOne

	self assert: one equals: zero fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:48:58'!
test36FibonacciOneIsOne

	self assert: one equals: one fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:24'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: five equals: four fibonacci.
	self assert: three equals: three fibonacci. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:40'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: Entero negativeFibonacciErrorDescription equals: anError messageText ]! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:52:17'!
test39NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated
		! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/5/2022 03:53:27'!
test40NegationOfFraccionIsCorrect

	self assert: negativeOne / two equals: oneHalf negated ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte2-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


!Numero methodsFor: 'error' stamp: 'JMS 5/8/2022 15:49:47'!
aFraccionCantBeZero	

	self! !

!Numero methodsFor: 'error' stamp: 'JMS 5/8/2022 15:53:07'!
aFraccionCantHaveOneAsDenominator

	self! !

!Numero methodsFor: 'error' stamp: 'JMS 5/8/2022 15:47:41'!
canNotDivideByZero

	self! !

!Numero methodsFor: 'error' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !


!Numero methodsFor: 'private' stamp: 'RB 5/8/2022 18:49:49'!
beAddedToAFraccion: anAugend
	
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'RB 5/8/2022 18:51:59'!
beAddedToAnEntero: anAugend
	
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'RB 5/8/2022 18:52:17'!
beMultipliedToAFraccion: aMultiplier
	
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'RB 5/8/2022 18:53:21'!
beMultipliedToAnEntero: aMultiplier
	
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'RB 5/8/2022 18:53:36'!
divideAFraccion: aDividend
	
	self subclassResponsibility.! !

!Numero methodsFor: 'private' stamp: 'RB 5/8/2022 18:53:49'!
divideAnEntero: aDividend
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte2-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 5/7/2020 17:47:38'!
canNotDivideByZeroErrorDescription

	^'No se puede Dividir por Cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'JMS 5/8/2022 15:51:59'!
invalidNumberTypeErrorDescription

	^ 'Tipo de Número Inválido'! !


!classDefinition: #Entero category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Entero methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:16:18'!
* aMultiplier 
		
	^aMultiplier beMultipliedToAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:43:10'!
+ anAdder 

	^anAdder beAddedToAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:25:41'!
- aSubtrahend 
	
	^aSubtrahend negated beAddedToAnEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:21:11'!
/ aDivisor 
	
	^ aDivisor divideAnEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 16:34:03'!
fibonacci

	self subclassResponsibility.! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'JS 5/5/2022 03:55:37'!
initializeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !


!Entero methodsFor: 'asserting' stamp: 'JMS 5/8/2022 18:00:11'!
assertIsNotOne: numerator
	
	^Fraccion safeCreateWith: numerator over: self.
! !

!Entero methodsFor: 'asserting' stamp: 'JMS 5/8/2022 18:02:07'!
assertIsNotZero: aDivisor

	| greatestCommonDivisor numerator denominator |

	greatestCommonDivisor := self greatestCommonDivisorWith: aDivisor. 
	numerator := self // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	^denominator assertIsNotOne: numerator.! !

!Entero methodsFor: 'asserting' stamp: 'JMS 5/8/2022 18:01:58'!
assertWith: aDividend
	
	^aDividend assertIsNotZero: self.! !


!Entero methodsFor: 'private' stamp: 'JMS 5/7/2022 15:42:49'!
beAddedToAFraccion: anAugend
	
	^anAugend beAddedToAnEntero: self.
! !

!Entero methodsFor: 'private' stamp: 'JMS 5/5/2022 20:13:20'!
beAddedToAnEntero: anAugend
	
	^self class with: anAugend integerValue + self integerValue.

! !

!Entero methodsFor: 'private' stamp: 'JMS 5/7/2022 15:49:13'!
beMultipliedToAFraccion: aMultiplier
	
	^aMultiplier beMultipliedToAnEntero: self.
! !

!Entero methodsFor: 'private' stamp: 'JMS 5/7/2022 14:06:29'!
beMultipliedToAnEntero: aMultiplier
	
	^Entero with: (aMultiplier integerValue * self integerValue).
! !

!Entero methodsFor: 'private' stamp: 'JMS 5/7/2022 15:20:54'!
divideAFraccion: aDividend
	
	^aDividend numerator / (self * aDividend denominator).
! !

!Entero methodsFor: 'private' stamp: 'JMS 5/7/2022 15:21:11'!
divideAnEntero: aDividend
	
	^Fraccion with: aDividend over: self.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numeros-Parte2-Ejercicio'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'JMS 5/8/2022 17:47:40'!
negativeFibonacciErrorDescription

	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'JMS 5/8/2022 18:04:24'!
with: aValue 
	
	Entero subclasses
		detect: [ :subClass | subClass includes: aValue] 
		ifFound: [ :subClass | ^subClass new initializeWith: aValue] 
		ifNone: [ self error: 'aValue debe ser anInteger'].! !


!classDefinition: #GreaterThanOne category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #GreaterThanOne
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!GreaterThanOne methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 16:17:02'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GreaterThanOne class' category: 'Numeros-Parte2-Ejercicio'!
GreaterThanOne class
	instanceVariableNames: ''!

!GreaterThanOne class methodsFor: 'private' stamp: 'JMS 5/8/2022 15:30:00'!
includes: aValue

	^aValue > 1.
	
! !


!classDefinition: #Negative category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Negative
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Negative methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 16:15:11'!
fibonacci
	
	self error: Entero negativeFibonacciErrorDescription.! !


!Negative methodsFor: 'private' stamp: 'JMS 5/8/2022 17:59:47'!
assertWith: aDividend
	
	^aDividend negated / self negated.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negative class' category: 'Numeros-Parte2-Ejercicio'!
Negative class
	instanceVariableNames: ''!

!Negative class methodsFor: 'private' stamp: 'JMS 5/8/2022 15:30:00'!
includes: aValue

	^aValue negative.
	

! !


!classDefinition: #One category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!One methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 16:15:28'!
fibonacci
	
	^Entero with: 1.! !


!One methodsFor: 'error' stamp: 'JMS 5/8/2022 15:54:04'!
aFraccionCantHaveOneAsDenominator

	self error: self class aFraccionCantHaveOneAsDenominatorErrorDescription.! !


!One methodsFor: 'private' stamp: 'JMS 5/8/2022 18:00:11'!
assertIsNotOne: numerator
	
	^numerator.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'One class' category: 'Numeros-Parte2-Ejercicio'!
One class
	instanceVariableNames: ''!

!One class methodsFor: 'private' stamp: 'JMS 5/8/2022 15:30:00'!
includes: aValue

	^aValue = 1.! !


!One class methodsFor: 'error descriptions' stamp: 'JMS 5/8/2022 15:53:15'!
aFraccionCantHaveOneAsDenominatorErrorDescription

	^ 'una fraccion no puede tener denominador 1 porque sino es un entero'! !


!classDefinition: #Zero category: 'Numeros-Parte2-Ejercicio'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Zero methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 16:15:44'!
fibonacci
	
	^Entero with: 1.! !


!Zero methodsFor: 'error' stamp: 'JMS 5/8/2022 15:54:22'!
aFraccionCantBeZero
	
	self error: self class aFraccionCantBeZeroErrorDescription.! !

!Zero methodsFor: 'error' stamp: 'JMS 5/8/2022 15:56:23'!
canNotDivideByZero
	
	"Tambien puedo cambiar el self class por Numero."
	self error: self class canNotDivideByZeroErrorDescription.! !


!Zero methodsFor: 'private' stamp: 'JMS 5/8/2022 17:58:58'!
assertIsNotZero: aDivisor

	^self! !

!Zero methodsFor: 'private' stamp: 'JMS 5/8/2022 17:59:47'!
assertWith: aDividend
	
	self canNotDivideByZero.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: 'Numeros-Parte2-Ejercicio'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'private' stamp: 'JMS 5/8/2022 15:30:00'!
includes: aValue

	^aValue isZero.! !


!Zero class methodsFor: 'error descriptions' stamp: 'JMS 5/8/2022 15:51:30'!
aFraccionCantBeZeroErrorDescription

	^ 'una fraccion no puede ser cero'! !


!classDefinition: #Fraccion category: 'Numeros-Parte2-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte2-Ejercicio'!

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:15:46'!
* aMultiplier 
	
	^aMultiplier beMultipliedToAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:15:52'!
+ anAdder 
	
	^ anAdder beAddedToAFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:22:41'!
- aSubtrahend 
	
	^aSubtrahend negated beAddedToAFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'JMS 5/7/2022 15:20:54'!
/ aDivisor 
	
	^aDivisor divideAFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'initialization' stamp: 'JMS 5/8/2022 15:53:07'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	
	aNumerator aFraccionCantBeZero .
	aDenominator aFraccionCantHaveOneAsDenominator .
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'private' stamp: 'JMS 5/7/2022 15:13:18'!
beAddedToAFraccion: anAugend
	
	| newNumerator newDenominator |
	
	newNumerator := (anAugend numerator * self denominator) + (self numerator * anAugend denominator).
	newDenominator := anAugend denominator * self denominator.
	
	^ newNumerator / newDenominator .! !

!Fraccion methodsFor: 'private' stamp: 'JMS 5/5/2022 20:13:06'!
beAddedToAnEntero: anAugend
	
	^anAugend * self denominator + self numerator / self denominator
	
! !

!Fraccion methodsFor: 'private' stamp: 'JMS 5/7/2022 14:06:18'!
beMultipliedToAFraccion: aMultiplier
	
	| newNumerator newDenominator |
	
	newNumerator := aMultiplier numerator * self numerator.
	newDenominator := aMultiplier denominator * self denominator.
	
	^ newNumerator / newDenominator.
! !

!Fraccion methodsFor: 'private' stamp: 'JMS 5/7/2022 15:48:18'!
beMultipliedToAnEntero: aMultiplier
	
	^aMultiplier * self numerator / self denominator.! !

!Fraccion methodsFor: 'private' stamp: 'JMS 5/7/2022 15:20:54'!
divideAFraccion: aDividend
	
	^(aDividend numerator * self denominator) / (aDividend denominator * self numerator).! !

!Fraccion methodsFor: 'private' stamp: 'JMS 5/7/2022 15:21:11'!
divideAnEntero: aDividend
	
	^aDividend * self denominator / self numerator.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numeros-Parte2-Ejercicio'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'JMS 5/8/2022 18:04:39'!
with: aDividend over: aDivisor
		
	^aDivisor assertWith: aDividend.! !


!Fraccion class methodsFor: 'private' stamp: 'JMS 5/8/2022 17:56:45'!
safeCreateWith: aDividend over: aDivisor

	^self new initializeWith: aDividend over: aDivisor.! !
