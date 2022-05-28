!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:15:55'!
test01CuandoSeCreaQueDevuelvaBienParametrosIniciales

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:15:41'!
test02N_Forward

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (0@1) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:15:27'!
test03N_Backwards

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (0@-1) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:15:17'!
test04S_Forward

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $S.
	
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (0@-1) and: [marsRover orientation = $S]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:15:07'!
test05S_Backwards

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $S.
	
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (0@1) and: [marsRover orientation = $S]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:14:01'!
test06E_Forward

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $E.
	
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (1@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:13:49'!
test07E_Backwards
	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $E.
	
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (-1@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:13:37'!
test08O_Forward
	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $O.
	
	marsRover command: 'f'.	
	
	self assert: (marsRover position = (-1@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:13:28'!
test09O_Backwards

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $O.
	
	marsRover command: 'b'.	
	
	self assert: (marsRover position = (1@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:13:16'!
test10SeveralCharacters

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover command: 'fb'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:13:02'!
test11RotationClockwise

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover command: 'r'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:12:48'!
test12RotationCounterClockwise

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover command: 'l'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 23:12:14'!
test13RotationAndAntiRotation
	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover command: 'flfflrbflbrllfff'.	
	
	self assert: (marsRover position = (1@2) and: [marsRover orientation = $E]).
	 ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 20:03:34'!
test14InitializationError

	self should: [MarsRover in: 2 facing: $N.]
		 raise: Error
	        withExceptionDo: [ :anError | 
						self assert: MarsRover invalidStartingPositionErrorDescription equals: anError messageText ].! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 20:04:29'!
test15InitializationError

	self should: [MarsRover in: 0@0 facing: $G.]
		 raise: Error
	        withExceptionDo: [ :anError | 
						self assert: MarsRover invalidStartingOrientationErrorDescription equals: anError messageText ].! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/27/2022 20:17:13'!
test16CommandsShouldReceiveOnlyStrings

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.

	self should: [marsRover command: 6.	]
		 raise: Error
	        withExceptionDo: [ :anError | 
						self assert: MarsRover invalidCommandArgumentErrorDescription equals: anError messageText ].
					! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 20:47:32'!
command: aRover WithCommands: aCharacter
	
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:30:28'!
symbol
	
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:28:30'!
createOrientationFrom: aDirection

	self subclasses 
		detect: [ :subclass | subclass canInstanciateADirection: aDirection ]
		ifFound: [ :subclass | ^subclass new ]
		ifNone:  [ ^MarsRover invalidStartingOrientation ].! !


!classDefinition: #Este category: 'MarsRover'!
CardinalDirection subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Este methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:37:35'!
command: aRover WithCommands: aCharacter
	
	aRover eastCommands: aCharacter.! !

!Este methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:44:14'!
symbol

	^$E! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Este class' category: 'MarsRover'!
Este class
	instanceVariableNames: ''!

!Este class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:28'!
canInstanciateADirection: aDirection

	^(aDirection = $E)! !


!classDefinition: #Norte category: 'MarsRover'!
CardinalDirection subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Norte methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:37:20'!
command: aRover WithCommands: aCharacter
	
	aRover northCommands: aCharacter.
	! !

!Norte methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:30:51'!
symbol

	^$N! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Norte class' category: 'MarsRover'!
Norte class
	instanceVariableNames: ''!

!Norte class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:39'!
canInstanciateADirection: aDirection

	^(aDirection = $N)! !


!classDefinition: #Oeste category: 'MarsRover'!
CardinalDirection subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:37:52'!
command: aRover WithCommands: aCharacter
	
	aRover westCommands: aCharacter.! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:44:22'!
symbol

	^$O! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Oeste class' category: 'MarsRover'!
Oeste class
	instanceVariableNames: ''!

!Oeste class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:48'!
canInstanciateADirection: aDirection

	^(aDirection = $O)! !


!classDefinition: #Sur category: 'MarsRover'!
CardinalDirection subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Sur methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:38:03'!
command: aRover WithCommands: aCharacter
	
	aRover southCommands: aCharacter.! !

!Sur methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:44:30'!
symbol

	^$S! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sur class' category: 'MarsRover'!
Sur class
	instanceVariableNames: ''!

!Sur class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:57'!
canInstanciateADirection: aDirection

	^(aDirection = $S)! !


!classDefinition: #Comando category: 'MarsRover'!
Object subclass: #Comando
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Comando class' category: 'MarsRover'!
Comando class
	instanceVariableNames: ''!

!Comando class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:48:59'!
createActionFrom: aCharacter

	self subclasses 
		detect: [ :subclass | subclass canInstanciateACommand: aCharacter ]
		ifFound: [ :subclass | ^subclass new ]
		ifNone:  [].! !


!classDefinition: #MoveBackwards category: 'MarsRover'!
Comando subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:10:57'!
executeEastCommandFor: aRover

	aRover moveBackwardsEast.! !

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:11:09'!
executeNorthCommandFor: aRover

	aRover moveBackwardsNorth.! !

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:11:28'!
executeSouthCommandFor: aRover

	aRover moveBackwardsSouth.! !

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:11:18'!
executeWestCommandFor: aRover

	aRover moveBackwardsWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:19'!
canInstanciateACommand: aCharacter

	^aCharacter = $b.! !


!classDefinition: #MoveForward category: 'MarsRover'!
Comando subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:59:12'!
executeEastCommandFor: aRover

	aRover moveForwardEast.! !

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:58:19'!
executeNorthCommandFor: aRover

	aRover moveForwardNorth.! !

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:58:37'!
executeSouthCommandFor: aRover

	aRover moveForwardSouth.! !

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:59:00'!
executeWestCommandFor: aRover

	aRover moveForwardWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'MarsRover'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:29'!
canInstanciateACommand: aCharacter

	^aCharacter = $f.! !


!classDefinition: #RotateLeft category: 'MarsRover'!
Comando subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:11:49'!
executeEastCommandFor: aRover

	aRover rotateLeftEast.! !

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:12:10'!
executeNorthCommandFor: aRover

	aRover rotateLeftNorth.! !

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:12:23'!
executeSouthCommandFor: aRover

	aRover rotateLeftSouth.! !

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:11:59'!
executeWestCommandFor: aRover

	aRover rotateLeftWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:38'!
canInstanciateACommand: aCharacter

	^aCharacter = $l.! !


!classDefinition: #RotateRight category: 'MarsRover'!
Comando subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:12:46'!
executeEastCommandFor: aRover

	aRover rotateRightEast.! !

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:13:12'!
executeNorthCommandFor: aRover

	aRover rotateRightNorth.! !

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:13:23'!
executeSouthCommandFor: aRover

	aRover rotateRightSouth.! !

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 22:13:38'!
executeWestCommandFor: aRover

	aRover rotateRightWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:44'!
canInstanciateACommand: aCharacter

	^aCharacter = $r.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'RB 5/27/2022 21:30:00'!
orientation
	
	^orientation symbol.! !

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/27/2022 17:33:19'!
position
	
	^position.! !


!MarsRover methodsFor: 'input' stamp: 'RB 5/27/2022 21:43:30'!
command: aString 
	| contador aCharacter |
	self assertCommandArgumentIsValid: aString.
	
	contador := 1.
	
	aString size timesRepeat: [
		
				aCharacter := aString at: contador.

				orientation command: self WithCommands: aCharacter.
								
				contador := contador + 1.
			].! !


!MarsRover methodsFor: 'initialization' stamp: 'jms 5/27/2022 18:28:54'!
initializeIn: aPoint facing: aDirection 
	
	position := aPoint.
	orientation := aDirection.! !


!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:08:12'!
moveBackwardsEast

	position := position + (-1@0).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:02:37'!
moveBackwardsNorth

	position := position + (0@-1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:06:42'!
moveBackwardsSouth
	
	position := position + (0@1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:09:24'!
moveBackwardsWest

	position := position + (1@0)..! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:07:57'!
moveForwardEast

	position := position + (1@0).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:01:25'!
moveForwardNorth

	position := position + (0@1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:06:13'!
moveForwardSouth
	
	position := position + (0@-1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:09:05'!
moveForwardWest

	position := position + (-1@0).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:08:42'!
rotateLeftEast

	orientation :=  CardinalDirection createOrientationFrom: $N.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:02:54'!
rotateLeftNorth

	orientation :=  CardinalDirection createOrientationFrom: $O.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:07:30'!
rotateLeftSouth
	
	orientation :=  CardinalDirection createOrientationFrom: $E.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:10:00'!
rotateLeftWest

	orientation :=  CardinalDirection createOrientationFrom: $S.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:08:29'!
rotateRightEast

	orientation :=  CardinalDirection createOrientationFrom: $S.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:02:44'!
rotateRightNorth

	orientation :=  CardinalDirection createOrientationFrom: $E.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:07:15'!
rotateRightSouth
	
	orientation :=  CardinalDirection createOrientationFrom: $O.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/27/2022 22:09:43'!
rotateRightWest

	orientation :=  CardinalDirection createOrientationFrom: $N.! !


!MarsRover methodsFor: 'private commands' stamp: 'RB 5/27/2022 23:11:12'!
eastCommands: aCharacter

	(Comando createActionFrom: aCharacter) executeEastCommandFor: self.
! !

!MarsRover methodsFor: 'private commands' stamp: 'RB 5/27/2022 23:11:19'!
northCommands: aCharacter

	(Comando createActionFrom: aCharacter) executeNorthCommandFor: self.
! !

!MarsRover methodsFor: 'private commands' stamp: 'RB 5/27/2022 23:11:25'!
southCommands: aCharacter

	(Comando createActionFrom: aCharacter) executeSouthCommandFor: self.
! !

!MarsRover methodsFor: 'private commands' stamp: 'RB 5/27/2022 23:11:29'!
westCommands: aCharacter

	(Comando createActionFrom: aCharacter) executeWestCommandFor: self.
	! !


!MarsRover methodsFor: 'error' stamp: 'RB 5/27/2022 21:17:10'!
invalidCommandArgument

	self error: self class invalidCommandArgumentErrorDescription! !


!MarsRover methodsFor: 'testing' stamp: 'RB 5/27/2022 20:24:44'!
assertCommandArgumentIsValid: aString

	^ aString isString ifFalse: [ self invalidCommandArgument ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'RB 5/27/2022 21:20:17'!
in: aPoint facing: aDirection 
	| orientation |
	
	(aPoint isPoint) ifFalse: [self invalidStartingPosition].
	
	orientation :=  CardinalDirection createOrientationFrom: aDirection.
		
	^self new initializeIn: aPoint facing: orientation.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'RB 5/27/2022 20:18:58'!
invalidCommandArgumentErrorDescription
	
	^'Command can only receive strings as arguments.'! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'RB 5/27/2022 20:07:16'!
invalidStartingOrientationErrorDescription

	^'Mars Rober can only be created facing a valid orientation.'! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'RB 5/27/2022 20:06:39'!
invalidStartingPositionErrorDescription

	^'Mars Rober can only be created in a valid coordinate.'! !


!MarsRover class methodsFor: 'error' stamp: 'RB 5/27/2022 21:16:41'!
invalidStartingOrientation

	self error: self invalidStartingOrientationErrorDescription! !

!MarsRover class methodsFor: 'error' stamp: 'RB 5/27/2022 21:18:51'!
invalidStartingPosition

	self error: self invalidStartingPositionErrorDescription! !
