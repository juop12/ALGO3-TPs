!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/26/2022 21:52:37'!
test01! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/26/2022 21:57:13'!
test02

	|marsRover|
	marsRover := MarsRover new.
	marsRover receiveCommand: 'f'.
	
	self deny: (marsRover position = (0@0)).! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'input' stamp: 'jms 5/26/2022 22:00:49'!
position
	
	^0@1.! !

!MarsRover methodsFor: 'input' stamp: 'jms 5/26/2022 22:00:29'!
receiveCommand: aString 
	
	^0@1.! !
