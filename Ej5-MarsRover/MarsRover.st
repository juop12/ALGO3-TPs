!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'setup' stamp: 'JMS 5/28/2022 23:16:19'!
setUp

	| northDirection |
	
	northDirection := North new.
	
	marsRover := MarsRover at: (0@0) facing: northDirection.! !


!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:21:42'!
test01marsRoverShouldBeCreatedWithTheCorrectDirectionAndPosition
	
	self assertMarsRoverIsPositionedAtOriginFacingNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:24:19'!
test02givenAMarsRoverAt0FacingNorth_whenMovedForward_YCoordinateShouldBe1FacingNorth

	marsRover execute: 'f'.	
	
	self assert: ((marsRover isPositionedAt: 0@1) and: [ marsRover isFacingNorth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:24:40'!
test03givenAMarsRoverAt0FacingNorth_whenMovedBackwards_YCoordinateShouldBeMinus1FacingNorth

	marsRover execute: 'b'.	
	
	self assert: ((marsRover isPositionedAt: 0@-1) and: [ marsRover isFacingNorth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:24:56'!
test04givenAMarsRoverAt0FacingSouth_whenMovedForward_YCoordinateShouldBeMinus1FacingSouth

	|marsRover10|
	
	marsRover10 := MarsRover at: (0@0) facing: South new.
	marsRover10 execute: 'f'.	
	
	self assert: ((marsRover10 isPositionedAt: 0@-1) and: [ marsRover10 isFacingSouth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:25:13'!
test05givenAMarsRoverAt0FacingSouth_whenMovedBackwards_YCoordinateShouldBe1FacingSouth

	|marsRover10|
	
	marsRover10 := MarsRover at: (0@0) facing: South new.
	marsRover10 execute: 'b'.	
	
	self assert: ((marsRover10 isPositionedAt: 0@1) and: [ marsRover10 isFacingSouth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:25:22'!
test06givenAMarsRoverAt0FacingEast_whenMovedForward_XCoordinateShouldBe1FacingEast

	|marsRover10|
	
	marsRover10 := MarsRover at: (0@0) facing: East new.
	marsRover10 execute: 'f'.	
	
	self assert: ((marsRover10 isPositionedAt: 1@0) and: [ marsRover10 isFacingEast ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:25:30'!
test07givenAMarsRoverAt0FacingEast_whenMovedBackwards_XCoordinateShouldBeMinus1FacingEast
	
	|marsRover10|
	
	marsRover10 := MarsRover at: (0@0) facing: East new.
	marsRover10 execute: 'b'.	
	
	self assert: ((marsRover10 isPositionedAt: -1@0) and: [ marsRover10 isFacingEast ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:25:37'!
test08givenAMarsRoverAt0FacingWest_whenMovedForward_XCoordinateShouldBeMinus1FacingWest

	|marsRover10|
	
	marsRover10 := MarsRover at: (0@0) facing: West new.
	marsRover10 execute: 'f'.	
	
	self assert: ((marsRover10 isPositionedAt: -1@0) and: [ marsRover10 isFacingWest ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:25:46'!
test09givenAMarsRoverAt0FacingWest_whenMovedBackwards_XCoordinateShouldBe1FacingWest

	|marsRover10|
	
	marsRover10 := MarsRover at: (0@0) facing: West new.
	marsRover10 execute: 'b'.	
	
	self assert: ((marsRover10 isPositionedAt: 1@0) and: [ marsRover10 isFacingWest ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:26:04'!
test10givenAMarsRoverAt0FacingNorth_whenMovedForwardAndBackwards_PositionShouldRemainTheSameFacingNorth

	marsRover execute: 'fb'.	
	
	self assertMarsRoverIsPositionedAtOriginFacingNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:26:39'!
test11givenAMarsRoverAt0FacingNorth_whenRotatedRight_PositionShouldRemainTheSameFacingEast

	marsRover execute: 'r'.	
	
	self assert: (self assertMarsRoverIsPositionedAtOrigin and: [ marsRover isFacingEast ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:26:54'!
test12givenAMarsRoverAt0FacingNorth_whenRotatedLeft_PositionShouldRemainTheSameFacingWest

	marsRover execute: 'l'.	
	
	self assert: (self assertMarsRoverIsPositionedAtOrigin and: [ marsRover isFacingWest ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:27:06'!
test13givenAMarsRoverAt0FacingNorth_whenRotatedRightAndLeft_PositionAndDirectionShouldRemainTheSame

	marsRover execute: 'rl'.	
	
	self assertMarsRoverIsPositionedAtOriginFacingNorth.
	 ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:05:04'!
test14initializingMarsRoverWithInvalidPositionShouldRaiseAnException

	self should: [MarsRover at: 2 facing: North new.]
		 raise: Error
	        withExceptionDo: [ :anError | 
				self assert: MarsRover aCoordinateMustBeAPointErrorDescription equals: anError messageText ].! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:05:01'!
test15initializingMarsRoverWithInvalidDirectionShouldRaiseAnException

	self should: [ MarsRover at: 0@0 facing: $G. ]
		 raise: Error
	        withExceptionDo: [ :anError | 
				self assert: MarsRover aDirectionMustBeACardinalDirectionErrorDescription equals: anError messageText ].! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:16:19'!
test16givenAValidMarsRover_whenSendingSthgOtherThanAString_marsRoverShouldRaiseAnException

	self should: [marsRover execute: 6.	]
		 raise: Error
	        withExceptionDo: [ :anError | 
				self assert: MarsRover aStringOfCommandsMustBeAStringErrorDescription equals: anError messageText ].
					! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:27:54'!
test17givenAMarsRoverAt0FacingNorth_whenSendingSeveralCommands_marsRoversActsAccordingly

	marsRover execute: 'frlbfffrrrrbb'.	
	
	self assert: ((marsRover isPositionedAt: 0@1) and: [ marsRover isFacingNorth ]).
	 ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'JMS 5/28/2022 23:28:11'!
test18givenAMarsRoverAt0FacingNorth_whenSendingWrongCommands_marsRoverShouldMoveAndThenRaiseAnException
	
	self should: [ marsRover execute: 'ffxr'. ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: MarsRover aCommandMustBeAValidCommandErrorDescription equals: anError messageText ].
	
	self assert: ((marsRover isPositionedAt: 0@2) and: [ marsRover isFacingNorth ]).
	 ! !


!MarsRoverTests methodsFor: 'private' stamp: 'JMS 5/28/2022 23:23:20'!
assertMarsRoverIsPositionedAtOrigin

	^marsRover isPositionedAt: 0@0.! !

!MarsRoverTests methodsFor: 'private' stamp: 'JMS 5/28/2022 23:23:09'!
assertMarsRoverIsPositionedAtOriginFacingNorth

	self assert: (self assertMarsRoverIsPositionedAtOrigin and: [ marsRover isFacingNorth ])! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'information' stamp: 'JMS 5/28/2022 20:38:43'!
isCardinalDirection
	
	^true.! !

!CardinalDirection methodsFor: 'information' stamp: 'JMS 5/28/2022 20:39:08'!
isFacingEast

	^false.! !

!CardinalDirection methodsFor: 'information' stamp: 'JMS 5/28/2022 20:39:13'!
isFacingNorth

	^false.! !

!CardinalDirection methodsFor: 'information' stamp: 'JMS 5/28/2022 20:39:18'!
isFacingSouth

	^false.! !

!CardinalDirection methodsFor: 'information' stamp: 'JMS 5/28/2022 20:39:21'!
isFacingWest

	^false.! !


!CardinalDirection methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'information' stamp: 'JMS 5/28/2022 20:36:43'!
isFacingEast

	^true.! !


!East methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingEast: aCommand.! !


!classDefinition: #North category: 'MarsRover'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'information' stamp: 'JMS 5/28/2022 20:37:00'!
isFacingNorth

	^true.! !


!North methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingNorth: aCommand.
	! !


!classDefinition: #South category: 'MarsRover'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'information' stamp: 'JMS 5/28/2022 20:37:22'!
isFacingSouth

	^true.! !


!South methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingSouth: aCommand.! !


!classDefinition: #West category: 'MarsRover'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'information' stamp: 'JMS 5/28/2022 20:37:40'!
isFacingWest

	^true.! !


!West methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingWest: aCommand.! !


!classDefinition: #Command category: 'MarsRover'!
Object subclass: #Command
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Command methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:21:33'!
beExecutedWhileFacingEastBy: aRover

	self subclassResponsibility.! !

!Command methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:22:14'!
beExecutedWhileFacingNorthBy: aRover

	self subclassResponsibility.! !

!Command methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:22:44'!
beExecutedWhileFacingSouthBy: aRover

	self subclassResponsibility.! !

!Command methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:23:10'!
beExecutedWhileFacingWestBy: aRover

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Command class' category: 'MarsRover'!
Command class
	instanceVariableNames: ''!

!Command class methodsFor: 'instance creation' stamp: 'JMS 5/28/2022 20:54:51'!
createAnInstanceOf: aCommand

	self subclasses 
		detect: [ :subclass | subclass canInstanciateACommandFrom: aCommand ]
		ifFound: [ :subclass | ^subclass new ]
		ifNone:  [ MarsRover aCommandMustBeAValidCommand ].! !


!classDefinition: #MoveBackwards category: 'MarsRover'!
Command subclass: #MoveBackwards
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwards methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:37:34'!
beExecutedWhileFacingEastBy: aRover

	aRover moveBackwardsWhileFacingEast.! !

!MoveBackwards methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:37:47'!
beExecutedWhileFacingNorthBy: aRover

	aRover moveBackwardsWhileFacingNorth.! !

!MoveBackwards methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:38:04'!
beExecutedWhileFacingSouthBy: aRover

	aRover moveBackwardsWhileFacingSouth.! !

!MoveBackwards methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:38:23'!
beExecutedWhileFacingWestBy: aRover

	aRover moveBackwardsWhileFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwards class' category: 'MarsRover'!
MoveBackwards class
	instanceVariableNames: ''!

!MoveBackwards class methodsFor: 'verification - private' stamp: 'JMS 5/28/2022 18:37:18'!
canInstanciateACommandFrom: aCommand

	^aCommand = $b.! !


!classDefinition: #MoveForward category: 'MarsRover'!
Command subclass: #MoveForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForward methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:38:36'!
beExecutedWhileFacingEastBy: aRover

	aRover moveForwardWhileFacingEast.! !

!MoveForward methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:38:52'!
beExecutedWhileFacingNorthBy: aRover

	aRover moveForwardWhileFacingNorth.! !

!MoveForward methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:39:09'!
beExecutedWhileFacingSouthBy: aRover

	aRover moveForwardWhileFacingSouth.! !

!MoveForward methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:39:24'!
beExecutedWhileFacingWestBy: aRover

	aRover moveForwardWhileFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForward class' category: 'MarsRover'!
MoveForward class
	instanceVariableNames: ''!

!MoveForward class methodsFor: 'verification - private' stamp: 'JMS 5/28/2022 18:37:18'!
canInstanciateACommandFrom: aCommand

	^aCommand = $f.! !


!classDefinition: #RotateLeft category: 'MarsRover'!
Command subclass: #RotateLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeft methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:41:19'!
beExecutedWhileFacingEastBy: aRover

	aRover rotateLeftWhenFacingEast.! !

!RotateLeft methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:41:38'!
beExecutedWhileFacingNorthBy: aRover

	aRover rotateLeftWhenFacingNorth.! !

!RotateLeft methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:42:21'!
beExecutedWhileFacingSouthBy: aRover

	aRover rotateLeftWhenFacingSouth.! !

!RotateLeft methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:42:34'!
beExecutedWhileFacingWestBy: aRover

	aRover rotateLeftWhenFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeft class' category: 'MarsRover'!
RotateLeft class
	instanceVariableNames: ''!

!RotateLeft class methodsFor: 'verification - private' stamp: 'JMS 5/28/2022 18:37:18'!
canInstanciateACommandFrom: aCommand

	^aCommand = $l.! !


!classDefinition: #RotateRight category: 'MarsRover'!
Command subclass: #RotateRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRight methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:43:09'!
beExecutedWhileFacingEastBy: aRover

	aRover rotateRightWhenFacingEast.! !

!RotateRight methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:43:21'!
beExecutedWhileFacingNorthBy: aRover

	aRover rotateRightWhenFacingNorth.! !

!RotateRight methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:43:35'!
beExecutedWhileFacingSouthBy: aRover

	aRover rotateRightWhenFacingSouth.! !

!RotateRight methodsFor: 'private - execute dispatch' stamp: 'RB 5/28/2022 01:43:56'!
beExecutedWhileFacingWestBy: aRover

	aRover rotateRightWhenFacingWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRight class' category: 'MarsRover'!
RotateRight class
	instanceVariableNames: ''!

!RotateRight class methodsFor: 'verification - private' stamp: 'JMS 5/28/2022 18:37:18'!
canInstanciateACommandFrom: aCommand

	^aCommand = $r.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position facingDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 20:43:33'!
facingDirection
	
	^facingDirection.! !

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 20:42:44'!
isFacingEast

	^facingDirection isFacingEast.! !

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 20:42:23'!
isFacingNorth

	^facingDirection isFacingNorth.! !

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 20:42:52'!
isFacingSouth

	^facingDirection isFacingSouth.! !

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 20:42:59'!
isFacingWest

	^facingDirection isFacingWest.! !

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 23:18:34'!
isPositionedAt: aCoordinate
	
	^position = aCoordinate.! !

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/27/2022 17:33:19'!
position
	
	^position.! !


!MarsRover methodsFor: 'error' stamp: 'JMS 5/28/2022 18:02:11'!
aStringOfCommandsMustBeAString

	self error: self class aStringOfCommandsMustBeAStringErrorDescription.! !


!MarsRover methodsFor: 'initialization' stamp: 'JMS 5/28/2022 19:08:00'!
initializePositionedAt: aCoordinate facing: aDirection 

	position := aCoordinate.
	facingDirection := aDirection.! !


!MarsRover methodsFor: 'operations' stamp: 'JMS 5/28/2022 19:17:01'!
execute: aStringOfCommands

	self assertStringOfCommandsIsString: aStringOfCommands.
	
	self executeEachCommandIn: aStringOfCommands.! !


!MarsRover methodsFor: 'testing' stamp: 'JMS 5/28/2022 18:16:42'!
assertStringOfCommandsIsString: aStringOfCommands

	aStringOfCommands isString ifFalse: [ self aStringOfCommandsMustBeAString. ].! !


!MarsRover methodsFor: 'private - commands by direction' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingEast: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingEastBy: self.
! !

!MarsRover methodsFor: 'private - commands by direction' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingNorth: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingNorthBy: self.
! !

!MarsRover methodsFor: 'private - commands by direction' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingSouth: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingSouthBy: self.
! !

!MarsRover methodsFor: 'private - commands by direction' stamp: 'RB 5/28/2022 01:32:27'!
executeFacingWest: aCommand

	(Command createAnInstanceOf: aCommand) beExecutedWhileFacingWestBy: self.
	! !


!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 19:49:34'!
executeEachCommandIn: aStringOfCommands
		
	aStringOfCommands do: [ :aCharacter |
				facingDirection send: self toExecute: aCharacter.				
				].! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:14:17'!
moveBackwardsWhileFacingEast

	self moveForwardWhileFacingWest.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:14:35'!
moveBackwardsWhileFacingNorth

	self moveForwardWhileFacingSouth.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:14:58'!
moveBackwardsWhileFacingSouth
	
	self moveForwardWhileFacingNorth.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:15:06'!
moveBackwardsWhileFacingWest

	self moveForwardWhileFacingEast.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:13:12'!
moveForwardWhileFacingEast

	self updatePositionByAdding: 1@0.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:13:26'!
moveForwardWhileFacingNorth

	self updatePositionByAdding: 0@1.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:13:39'!
moveForwardWhileFacingSouth
	
	self updatePositionByAdding: 0@-1.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:13:48'!
moveForwardWhileFacingWest

	self updatePositionByAdding: -1@0.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:22:17'!
rotateLeftWhenFacingEast

	self rotateRightWhenFacingWest.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:22:06'!
rotateLeftWhenFacingNorth

	self rotateRightWhenFacingSouth.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:21:46'!
rotateLeftWhenFacingSouth
	
	self rotateRightWhenFacingNorth.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:21:27'!
rotateLeftWhenFacingWest

	self rotateRightWhenFacingEast.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:24:23'!
rotateRightWhenFacingEast

	self updateFacingDirection: South new.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:24:27'!
rotateRightWhenFacingNorth

	self updateFacingDirection: East new.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:24:31'!
rotateRightWhenFacingSouth
	
	self updateFacingDirection: West new.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:24:35'!
rotateRightWhenFacingWest

	self updateFacingDirection: North new.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 21:23:25'!
updateFacingDirection: aDirection

	facingDirection := aDirection.! !

!MarsRover methodsFor: 'private - operations' stamp: 'JMS 5/28/2022 20:01:32'!
updatePositionByAdding: aCoordinate

	position := position + aCoordinate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error' stamp: 'JMS 5/28/2022 20:55:14'!
aCommandMustBeAValidCommand

	self error: self aCommandMustBeAValidCommandErrorDescription.! !

!MarsRover class methodsFor: 'error' stamp: 'JMS 5/28/2022 18:19:09'!
aCoordinateMustBeAPoint

	self error: self aCoordinateMustBeAPointErrorDescription.! !

!MarsRover class methodsFor: 'error' stamp: 'JMS 5/28/2022 20:33:41'!
aDirectionMustBeACardinalDirection

	self error: self aDirectionMustBeACardinalDirectionErrorDescription.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'JMS 5/28/2022 20:56:56'!
aCommandMustBeAValidCommandErrorDescription

	^'A Mars Rover can only receive valid commands, forward (f), backwards (b), turn right (r), turn left (l).'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'JMS 5/28/2022 18:22:37'!
aCoordinateMustBeAPointErrorDescription

	^'A Mars Rover can only receive valid coordinates (Point class instances).'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'JMS 5/28/2022 20:57:09'!
aDirectionMustBeACardinalDirectionErrorDescription

	^'A Mars Rover can only receive valid directions (instances of CardinalDirection subclasses).'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'JMS 5/28/2022 18:13:58'!
aStringOfCommandsMustBeAStringErrorDescription
	
	^'#execute can only receive a string as collaborator.'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'JMS 5/28/2022 20:59:17'!
at: aCoordinate facing: aDirection 
	
	self assertACoordinateIsPoint: aCoordinate.
	self assertADirectionIsACardinalDirection: aDirection.
		
	^self new initializePositionedAt: aCoordinate facing: aDirection.
	! !


!MarsRover class methodsFor: 'testing' stamp: 'JMS 5/28/2022 18:18:04'!
assertACoordinateIsPoint: aCoordinate

	aCoordinate isPoint ifFalse: [ self aCoordinateMustBeAPoint. ].! !

!MarsRover class methodsFor: 'testing' stamp: 'JMS 5/28/2022 21:08:54'!
assertADirectionIsACardinalDirection: aDirection

	[ aDirection isCardinalDirection ]
		on: Error
		do: [ self aDirectionMustBeACardinalDirection. ].! !
