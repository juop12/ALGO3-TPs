!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: two equals: one + one! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:00:32'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: four equals: two * two! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:10'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: sevenTenths equals: oneFifth + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:01:43'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: twoTwentyfifth equals: oneFifth * twoFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:11'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:28'!
test10AddingFraccionesCanReturnAnEntero

	self assert: one equals: oneHalf + oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:03:42'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: one equals: (twoFifth) * (fiveHalfs) ! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:04:04'!
test14NegationOfEnteroIsCorrect

	self assert: negativeTwo equals: two negated! !

!NumeroTest methodsFor: 'tests' stamp: 'JS 5/1/2022 18:05:06'!
test15NegationOfFraccionIsCorrect

	self assert: (Numero with: negativeOne over: two) equals: oneHalf negated! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'JMS 5/2/2022 21:24:43'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: 'value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 15:56:32'!
* aMultiplier 

	"(type = #Entero and: [aMultiplier type = #Entero]) ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	(type = #Fraccion and: [aMultiplier type = #Fraccion]) ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ]."
		
	"self error: 'Tipo de número no soportado'"
	
	^self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 16:38:14'!
+ anAdder 
	
	"(type = #Entero and: [anAdder type = #Entero]) ifTrue:
		[ ^self class with: value + anAdder integerValue ].
	
	(type = #Fraccion and: [anAdder type = #Fraccion]) ifTrue:
		[ | newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator ]."
	
	"self error: 'Tipo de número no soportado'"
	
	^self subclassResponsibility .
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 16:19:15'!
negated
	
	"type = #Entero ifTrue:
		[ ^self * (self class with: -1) ].
	type = #Fraccion ifTrue:
		[ ^self class with: numerator * (self class with: -1) over: denominator ]."
	
	^self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'jMS 5/3/2022 16:12:31'!
isNegative
	
	"type = #Entero ifTrue:
		[ ^value < 0 ].
	type = #Fraccion ifTrue:
		[ ^denominator < 0 ]."
		
	^self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'JMS 5/2/2022 21:45:19'!
isOne

	"type = #Entero ifTrue:
		[ ^value = 1 ].
	type = #Fraccion ifTrue:
		[ ^false ]."
	
	^self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'JMS 5/2/2022 21:24:17'!
isZero

	"type = #Entero ifTrue:
		[ ^value = 0 ].
	type = #Fraccion ifTrue:
		[ ^false ]."
		
	^self subclassResponsibility .! !


!Numero methodsFor: 'initialization' stamp: 'jMS 5/3/2022 16:58:10'!
initializeWith: aValue
	
	value := aValue! !

!Numero methodsFor: 'initialization' stamp: 'jMS 5/3/2022 16:58:15'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:33:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !


!Numero methodsFor: 'printing' stamp: 'jMS 5/3/2022 16:36:50'!
printOn: aStream
	
	"type = #Entero ifTrue:
		[ aStream print: value ].
	
	type = #Fraccion ifTrue:
		[ aStream 
			print: numerator;
			nextPut: $/;
			print: denominator ]."
	
	^self subclassResponsibility.! !


!Numero methodsFor: 'comparing' stamp: 'jMS 5/3/2022 16:38:06'!
= anObject

	"Podria revisarse. Consultar."
	
	"^(anObject isKindOf: self class) and: [ type = anObject type and: 
		[ type = #Entero ifTrue: [ value = anObject integerValue] 
		ifFalse: [ type = #Fraccion ifTrue:
			[ (numerator * anObject denominator) = (denominator * anObject numerator) ]]]]"

	^self subclassResponsibility. ! !

!Numero methodsFor: 'comparing' stamp: 'jMS 5/3/2022 16:35:28'!
hash
	
	"type = #Entero ifTrue:
		[ ^value hash ].
	type = #Fraccion ifTrue:
		[ ^(numerator hash / denominator hash) hash ]."
		
	^self subclassResponsibility. ! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'jMS 5/3/2022 16:04:56'!
// aDivisor 
	
	"type = #Entero ifTrue:
		[ ^self class with: value // aDivisor integerValue ]."
		
	"self error: 'Tipo de número no soportado'"
	
	^self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'jMS 5/3/2022 16:01:31'!
greatestCommonDivisorWith: anEntero 
	
	"type = #Entero ifTrue:
		[^self class with: (value gcd: anEntero integerValue)]."
		
	"self error: 'Tipo de número no soportado'."
		
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'JMS 5/2/2022 21:40:41'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Entero new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'jMS 5/3/2022 16:54:15'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated ].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^Fraccion new initializeWith: numerator over: denominator! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 15:57:11'!
* aMultiplier 

	^self class with: value * aMultiplier integerValue.
		
	"self error: 'Tipo de número no soportado'"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'JMS 5/2/2022 21:59:02'!
+ anAdder
	
	^self class with: value + anAdder integerValue.
	
	"self error: 'Tipo de número no soportado'."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 16:20:11'!
negated
	
	^self * (self class with: -1).

	! !


!Entero methodsFor: 'testing' stamp: 'jMS 5/3/2022 16:12:58'!
isNegative
	
	^value < 0.! !

!Entero methodsFor: 'testing' stamp: 'JMS 5/2/2022 21:46:05'!
isOne
	
	^value = 1.! !

!Entero methodsFor: 'testing' stamp: 'JMS 5/2/2022 21:30:16'!
isZero
	
	^value = 0.! !


!Entero methodsFor: 'printing' stamp: 'jMS 5/3/2022 16:37:06'!
printOn: aStream
	
	aStream print: value.! !


!Entero methodsFor: 'comparing' stamp: 'jMS 5/3/2022 16:58:01'!
= anObject

	^(anObject isMemberOf: self class)
		ifTrue: [ value = anObject integerValue ].! !

!Entero methodsFor: 'comparing' stamp: 'jMS 5/3/2022 16:35:41'!
hash

	^value hash.! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'jMS 5/3/2022 16:06:48'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'jMS 5/3/2022 16:06:43'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue).! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 15:57:33'!
* aMultiplier 
		
	^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).
		
	"self error: 'Tipo de número no soportado'"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 15:41:08'!
+ anAdder

	| newNumerator newDenominator |
		
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
		
	^ self class with: newNumerator over: newDenominator.
	
	"self error: 'Tipo de número no soportado'"
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'jMS 5/3/2022 16:19:41'!
negated
	
	^self class with: numerator * (self class with: -1) over: denominator.
	! !


!Fraccion methodsFor: 'testing' stamp: 'jMS 5/3/2022 16:13:45'!
isNegative
	
	^denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'JMS 5/2/2022 21:46:26'!
isOne

	^false.! !

!Fraccion methodsFor: 'testing' stamp: 'JMS 5/2/2022 21:30:05'!
isZero

	^false.! !


!Fraccion methodsFor: 'printing' stamp: 'jMS 5/3/2022 16:37:46'!
printOn: aStream
	
	 aStream 
		print: numerator;
		nextPut: $/;
		print: denominator.
	
! !


!Fraccion methodsFor: 'comparing' stamp: 'jMS 5/3/2022 16:50:26'!
= anObject

	^(anObject isMemberOf: self class)		
		ifTrue: [ (numerator * anObject denominator) = (denominator * anObject numerator) ].! !

!Fraccion methodsFor: 'comparing' stamp: 'jMS 5/3/2022 16:35:59'!
hash

	^(numerator hash / denominator hash) hash.! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'jMS 5/3/2022 16:06:12'!
// aDivisor 
		
	^self error: 'Tipo de número no soportado'! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'jMS 5/3/2022 16:06:30'!
greatestCommonDivisorWith: anEntero 
	
	^self error: 'Tipo de número no soportado'.! !
