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

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test02N_Forward

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover execute: 'f'.	
	
	self assert: (marsRover position = (0@1) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test03N_Backwards

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover execute: 'b'.	
	
	self assert: (marsRover position = (0@-1) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test04S_Forward

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $S.
	
	marsRover execute: 'f'.	
	
	self assert: (marsRover position = (0@-1) and: [marsRover orientation = $S]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:54'!
test05S_Backwards

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $S.
	
	marsRover execute: 'b'.	
	
	self assert: (marsRover position = (0@1) and: [marsRover orientation = $S]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test06E_Forward

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $E.
	
	marsRover execute: 'f'.	
	
	self assert: (marsRover position = (1@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:54'!
test07E_Backwards
	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $E.
	
	marsRover execute: 'b'.	
	
	self assert: (marsRover position = (-1@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test08O_Forward
	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $O.
	
	marsRover execute: 'f'.	
	
	self assert: (marsRover position = (-1@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test09O_Backwards

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $O.
	
	marsRover execute: 'b'.	
	
	self assert: (marsRover position = (1@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:54'!
test10SeveralCharacters

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover execute: 'fb'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $N]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:54'!
test11RotationClockwise

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover execute: 'r'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $E]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test12RotationCounterClockwise

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	
	marsRover execute: 'l'.	
	
	self assert: (marsRover position = (0@0) and: [marsRover orientation = $O]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test13RotationAndAntiRotation
	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.
	marsRover execute: 'flfflrbflbrllfff'.	
	
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

!MarsRoverTests methodsFor: 'testing' stamp: 'RB 5/28/2022 01:06:53'!
test16CommandsShouldReceiveOnlyStrings

	|marsRover|
	
	marsRover := MarsRover in: (0@0) facing: $N.

	self should: [marsRover execute: 6.	]
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

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:30:28'!
symbol
	
	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:47:18'!
withThisOrientation: aRover executeACommand: aCommand
	
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


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:44:14'!
symbol

	^$E! !

!East methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:47:19'!
withThisOrientation: aRover executeACommand: aCommand
	
	aRover executeFacingEast: aCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'East class' category: 'MarsRover'!
East class
	instanceVariableNames: ''!

!East class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:28'!
canInstanciateADirection: aDirection

	^(aDirection = $E)! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:30:51'!
symbol

	^$N! !

!North methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:47:19'!
withThisOrientation: aRover executeACommand: aCommand
	
	aRover executeFacingNorth: aCommand.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'North class' category: 'MarsRover'!
North class
	instanceVariableNames: ''!

!North class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:39'!
canInstanciateADirection: aDirection

	^(aDirection = $N)! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:44:30'!
symbol

	^$S! !

!South methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:47:19'!
withThisOrientation: aRover executeACommand: aCommand
	
	aRover executeFacingSouth: aCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'South class' category: 'MarsRover'!
South class
	instanceVariableNames: ''!

!South class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:57'!
canInstanciateADirection: aDirection

	^(aDirection = $S)! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:44:22'!
symbol

	^$O! !

!West methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:47:19'!
withThisOrientation: aRover executeACommand: aCommand
	
	aRover executeFacingWest: aCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'West class' category: 'MarsRover'!
West class
	instanceVariableNames: ''!

!West class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:09:48'!
canInstanciateADirection: aDirection

	^(aDirection = $O)! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:21:33'!
beExecutedWhileFacingEastBy: aRover

	self subclassResponsibility.! !

!Command methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:22:14'!
beExecutedWhileFacingNorthBy: aRover

	self subclassResponsibility.! !

!Command methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:22:44'!
beExecutedWhileFacingSouthBy: aRover

	self subclassResponsibility.! !

!Command methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:23:10'!
beExecutedWhileFacingWestBy: aRover

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:32:50'!
createAnInstanceOf: aCommand

	self subclasses 
		detect: [ :subclass | subclass canInstanciateACommand: aCommand ]
		ifFound: [ :subclass | ^subclass new ]
		ifNone:  [].! !


!classDefinition: #MoveBackwards category: 'MarsRover'!
Command subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:37:34'!
beExecutedWhileFacingEastBy: aRover

	aRover moveBackwardsWhileFacingEast.! !

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:37:47'!
beExecutedWhileFacingNorthBy: aRover

	aRover moveBackwardsWhileFacingNorth.! !

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:38:04'!
beExecutedWhileFacingSouthBy: aRover

	aRover moveBackwardsWhileFacingSouth.! !

!MoveBackwards methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:38:23'!
beExecutedWhileFacingWestBy: aRover

	aRover moveBackwardsWhileFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:19'!
canInstanciateACommand: aCharacter

	^aCharacter = $b.! !


!classDefinition: #MoveForward category: 'MarsRover'!
Command subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:38:36'!
beExecutedWhileFacingEastBy: aRover

	aRover moveForwardWhileFacingEast.! !

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:38:52'!
beExecutedWhileFacingNorthBy: aRover

	aRover moveForwardWhileFacingNorth.! !

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:39:09'!
beExecutedWhileFacingSouthBy: aRover

	aRover moveForwardWhileFacingSouth.! !

!MoveForward methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:39:24'!
beExecutedWhileFacingWestBy: aRover

	aRover moveForwardWhileFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'MarsRover'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:29'!
canInstanciateACommand: aCharacter

	^aCharacter = $f.! !


!classDefinition: #RotateLeft category: 'MarsRover'!
Command subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:41:19'!
beExecutedWhileFacingEastBy: aRover

	aRover rotateLeftWhenFacingEast.! !

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:41:38'!
beExecutedWhileFacingNorthBy: aRover

	aRover rotateLeftWhenFacingNorth.! !

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:42:21'!
beExecutedWhileFacingSouthBy: aRover

	aRover rotateLeftWhenFacingSouth.! !

!RotateLeft methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:42:34'!
beExecutedWhileFacingWestBy: aRover

	aRover rotateLeftWhenFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'as yet unclassified' stamp: 'RB 5/27/2022 21:50:38'!
canInstanciateACommand: aCharacter

	^aCharacter = $l.! !


!classDefinition: #RotateRight category: 'MarsRover'!
Command subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:43:09'!
beExecutedWhileFacingEastBy: aRover

	aRover rotateRightWhenFacingEast.! !

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:43:21'!
beExecutedWhileFacingNorthBy: aRover

	aRover rotateRightWhenFacingNorth.! !

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:43:35'!
beExecutedWhileFacingSouthBy: aRover

	aRover rotateRightWhenFacingSouth.! !

!RotateRight methodsFor: 'as yet unclassified' stamp: 'RB 5/28/2022 01:43:56'!
beExecutedWhileFacingWestBy: aRover

	aRover rotateRightWhenFacingWest.! !

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


!MarsRover methodsFor: 'input' stamp: 'RB 5/28/2022 01:47:19'!
execute: aStringOfCommands

	| counter aCommand |
	
	self assertCommandArgumentIsValid: aStringOfCommands.
	
	counter := 1.
	
	aStringOfCommands size timesRepeat: [
		
				aCommand := aStringOfCommands at: counter.

				orientation withThisOrientation: self executeACommand: aCommand.
								
				counter := counter + 1.
			].! !


!MarsRover methodsFor: 'initialization' stamp: 'RB 5/28/2022 01:46:00'!
initializeLocatedIn: aCoordinate facing: aDirection 

	position := aCoordinate.
	
	orientation := aDirection.! !


!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:37:34'!
moveBackwardsWhileFacingEast

	position := position + (-1@0).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:37:47'!
moveBackwardsWhileFacingNorth

	position := position + (0@-1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:38:04'!
moveBackwardsWhileFacingSouth
	
	position := position + (0@1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:38:23'!
moveBackwardsWhileFacingWest

	position := position + (1@0)..! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:38:36'!
moveForwardWhileFacingEast

	position := position + (1@0).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:38:52'!
moveForwardWhileFacingNorth

	position := position + (0@1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:39:09'!
moveForwardWhileFacingSouth
	
	position := position + (0@-1).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:39:24'!
moveForwardWhileFacingWest

	position := position + (-1@0).! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:41:19'!
rotateLeftWhenFacingEast

	orientation :=  CardinalDirection createOrientationFrom: $N.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:41:38'!
rotateLeftWhenFacingNorth

	orientation :=  CardinalDirection createOrientationFrom: $O.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:42:21'!
rotateLeftWhenFacingSouth
	
	orientation :=  CardinalDirection createOrientationFrom: $E.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:42:34'!
rotateLeftWhenFacingWest

	orientation :=  CardinalDirection createOrientationFrom: $S.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:43:09'!
rotateRightWhenFacingEast

	orientation :=  CardinalDirection createOrientationFrom: $S.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:43:21'!
rotateRightWhenFacingNorth

	orientation :=  CardinalDirection createOrientationFrom: $E.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:43:35'!
rotateRightWhenFacingSouth
	
	orientation :=  CardinalDirection createOrientationFrom: $O.! !

!MarsRover methodsFor: 'comanditos' stamp: 'RB 5/28/2022 01:43:56'!
rotateRightWhenFacingWest

	orientation :=  CardinalDirection createOrientationFrom: $N.! !


!MarsRover methodsFor: 'private commands' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingEast: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingEastBy: self.
! !

!MarsRover methodsFor: 'private commands' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingNorth: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingNorthBy: self.
! !

!MarsRover methodsFor: 'private commands' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingSouth: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingSouthBy: self.
! !

!MarsRover methodsFor: 'private commands' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingWest: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingWestBy: self.
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

!MarsRover class methodsFor: 'initialization' stamp: 'RB 5/28/2022 01:46:00'!
in: aCoordinate facing: aDirection 
	| orientation |
	
	(aCoordinate isPoint) ifFalse: [self invalidStartingPosition].
	
	orientation :=  CardinalDirection createOrientationFrom: aDirection.
		
	^self new initializeLocatedIn: aCoordinate facing: orientation.! !


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
