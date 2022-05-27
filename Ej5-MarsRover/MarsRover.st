!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 18:26:20'!
test01CuandoSeCreaQueDevuelvaBienParametrosIniciales

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:08:18'!
test02N_Forward

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (0@1) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:06:29'!
test03N_Backwards

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (0@-1) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:08:28'!
test04S_Forward

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $S.
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (0@-1) and: [marsRover orientation = $S]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:09:01'!
test05S_Backwards

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $S.
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (0@1) and: [marsRover orientation = $S]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:10:01'!
test06E_Forward

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $E.
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (1@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:10:08'!
test07E_Backwards

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $E.
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (-1@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:11:12'!
test08O_Forward

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $O.
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (-1@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:12:11'!
test09O_Backwards

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $O.
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (1@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:08:35'!
test10SeveralCharacters

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'fb'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:09:08'!
test11RotationClockwise

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'r'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:40:19'!
test12RotationCounterClockwise

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'l'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/27/2022 19:43:07'!
test13RotationAndAntiRotation

	|marsRover|
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'flfflrbflbrllfff'.	
	
	self assert: (marsRover position = (1@2) and: [marsRover orientation = $E]).
	
	"
	y + 1
	O
	x - 1
	x - 1
	S
	O
	x + 1
	x - 1
	S
	y + 1
	O
	S
	E
	x + 1
	x + 1
	x + 1
	"
	 ! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/27/2022 17:33:13'!
orientation
	
	^orientation.! !

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/27/2022 17:33:19'!
position
	
	^position.! !


!MarsRover methodsFor: 'input' stamp: 'jms 5/27/2022 19:39:25'!
command: aString 
	
	| contador unaOrientacion aCharacter |
	
	"aString isString ifFalse: [ ^Error. ]."
	
	unaOrientacion := orientation.
	contador := 1.
	
	aString size timesRepeat: [
				aCharacter := aString at: contador.
			
				orientation = $N ifTrue: [
						aCharacter = $f ifTrue: [ position := position + (0@1). ].
						aCharacter = $b ifTrue: [ position := position + (0@-1). ].
						aCharacter = $r ifTrue: [ unaOrientacion :=  $E].
						aCharacter = $l ifTrue: [ unaOrientacion :=  $O].
						].
				orientation = $S ifTrue: [
						aCharacter = $f ifTrue: [ position := position + (0@-1). ].
						aCharacter = $b ifTrue: [ position := position + (0@1). ].
						aCharacter = $r ifTrue: [ unaOrientacion :=  $O].
						aCharacter = $l ifTrue: [ unaOrientacion :=  $E].
						].
				orientation = $E ifTrue: [
						aCharacter = $f ifTrue: [ position := position + (1@0). ].
						aCharacter = $b ifTrue: [ position := position + (-1@0). ].
						aCharacter = $r ifTrue: [ unaOrientacion :=  $S].
						aCharacter = $l ifTrue: [ unaOrientacion :=  $N].
						].
				orientation = $O ifTrue: [
						aCharacter = $f ifTrue: [ position := position + (-1@0). ].
						aCharacter = $b ifTrue: [ position := position + (1@0). ].
						aCharacter = $r ifTrue: [ unaOrientacion :=  $N].
						aCharacter = $l ifTrue: [ unaOrientacion :=  $S].
						].			
				
				orientation := unaOrientacion.
				contador := contador + 1.
			].! !


!MarsRover methodsFor: 'initialization' stamp: 'jms 5/27/2022 18:28:54'!
initializeIn: aPoint facing: aDirection 
	
	position := aPoint.
	orientation := aDirection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'jms 5/27/2022 18:28:21'!
in: aPoint facing: aDirection 
	
	^self new initializeIn: aPoint facing: aDirection.! !
