!classDefinition: #MarsRoverTests category: 'MarsRover'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'marsRoverFacingNorth marsRoverFacingSouth marsRoverFacingEast marsRoverFacingWest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTests methodsFor: 'setup' stamp: 'jms 5/31/2022 17:18:47'!
setUp

	| northDirection southDirection eastDirection westDirection |
	
	northDirection := North new.
	southDirection := South new.
	eastDirection   := East new.
	westDirection   := West new.
	
	marsRoverFacingNorth := MarsRover at: (0@0) facing: northDirection.
	marsRoverFacingSouth:= MarsRover at: (0@0) facing: southDirection.
	marsRoverFacingEast := MarsRover at: (0@0) facing: eastDirection.
	marsRoverFacingWest := MarsRover at: (0@0) facing: westDirection.! !


!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 17:14:37'!
test01marsRoverShouldBeCreatedWithTheCorrectDirectionAndPosition
	
	marsRoverFacingNorth execute: ''.
	
	self assertMarsRoverIsPositionedAtOriginFacingNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:03:50'!
test02givenAMarsRoverAt0FacingNorth_whenMovedForward_YCoordinateShouldBe1FacingNorth

	marsRoverFacingNorth execute: 'f'.	
	
	self assert: ((marsRoverFacingNorth isPositionedAt: 0@1) and: [ marsRoverFacingNorth isNorth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:03:50'!
test03givenAMarsRoverAt0FacingNorth_whenMovedBackwards_YCoordinateShouldBeMinus1FacingNorth

	marsRoverFacingNorth execute: 'b'.	
	
	self assert: ((marsRoverFacingNorth isPositionedAt: 0@-1) and: [ marsRoverFacingNorth isNorth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:07'!
test04givenAMarsRoverAt0FacingSouth_whenMovedForward_YCoordinateShouldBeMinus1FacingSouth
	
	marsRoverFacingSouth execute: 'f'.	
	
	self assert: ((marsRoverFacingSouth isPositionedAt: 0@-1) and: [ marsRoverFacingSouth isSouth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:07'!
test05givenAMarsRoverAt0FacingSouth_whenMovedBackwards_YCoordinateShouldBe1FacingSouth
	
	marsRoverFacingSouth execute: 'b'.	
	
	self assert: ((marsRoverFacingSouth isPositionedAt: 0@1) and: [ marsRoverFacingSouth isSouth ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:16'!
test06givenAMarsRoverAt0FacingEast_whenMovedForward_XCoordinateShouldBe1FacingEast

	marsRoverFacingEast execute: 'f'.	
	
	self assert: ((marsRoverFacingEast isPositionedAt: 1@0) and: [ marsRoverFacingEast isEast ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:16'!
test07givenAMarsRoverAt0FacingEast_whenMovedBackwards_XCoordinateShouldBeMinus1FacingEast
	
	marsRoverFacingEast execute: 'b'.	
	
	self assert: ((marsRoverFacingEast isPositionedAt: -1@0) and: [ marsRoverFacingEast isEast ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:00'!
test08givenAMarsRoverAt0FacingWest_whenMovedForward_XCoordinateShouldBeMinus1FacingWest

	marsRoverFacingWest execute: 'f'.	
	
	self assert: ((marsRoverFacingWest isPositionedAt: -1@0) and: [ marsRoverFacingWest isWest ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:00'!
test09givenAMarsRoverAt0FacingWest_whenMovedBackwards_XCoordinateShouldBe1FacingWest
	
	marsRoverFacingWest execute: 'b'.	
	
	self assert: ((marsRoverFacingWest isPositionedAt: 1@0) and: [ marsRoverFacingWest isWest ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/29/2022 14:26:46'!
test10givenAMarsRoverAt0FacingNorth_whenMovedForwardAndBackwards_PositionShouldRemainTheSameFacingNorth
	
	marsRoverFacingNorth execute: 'fb'.	
	
	self assertMarsRoverIsPositionedAtOriginFacingNorth.! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:16'!
test11givenAMarsRoverAt0FacingNorth_whenRotatedRight_PositionShouldRemainTheSameFacingEast
	
	marsRoverFacingNorth execute: 'r'.	
	
	self assert: (self assertMarsRoverIsPositionedAtOrigin and: [ marsRoverFacingNorth isEast ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:04:00'!
test12givenAMarsRoverAt0FacingNorth_whenRotatedLeft_PositionShouldRemainTheSameFacingWest
	
	marsRoverFacingNorth execute: 'l'.	
	
	self assert: (self assertMarsRoverIsPositionedAtOrigin and: [ marsRoverFacingNorth isWest ]).! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/29/2022 14:27:03'!
test13givenAMarsRoverAt0FacingNorth_whenRotatedRightAndLeft_PositionAndDirectionShouldRemainTheSame
	
	marsRoverFacingNorth execute: 'rl'.	
	
	self assertMarsRoverIsPositionedAtOriginFacingNorth.
	 ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/29/2022 14:27:56'!
test14initializingMarsRoverWithInvalidPositionShouldRaiseAnException
	
	self should: [MarsRover at: 2 facing: North new.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: MarsRover aCoordinateMustBeAPointErrorDescription equals: anError messageText ].! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:06:54'!
test15initializingMarsRoverWithInvalidDirectionShouldRaiseAnException
	
	self should: [ MarsRover at: 0@0 facing: $G. ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: MarsRover aDirectionMustBeAFacingDirectionOfARoverErrorDescription equals: anError messageText ].! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:16:13'!
test16givenAValidMarsRover_whenSendingSthgOtherThanAString_marsRoverShouldRaiseAnException

	self should: [marsRoverFacingNorth execute: 6.	]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: MarsRover aCommandSequenceMustBeAStringErrorDescription equals: anError messageText ].
					! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:03:50'!
test17givenAMarsRoverAt0FacingNorth_whenSendingSeveralCommands_marsRoversActsAccordingly
	
	marsRoverFacingNorth execute: 'frlbfffrrrrbb'.	
	
	self assert: ((marsRoverFacingNorth isPositionedAt: 0@1) and: [ marsRoverFacingNorth isNorth ]).
	 ! !

!MarsRoverTests methodsFor: 'testing' stamp: 'jms 5/31/2022 18:03:50'!
test18givenAMarsRoverAt0FacingNorth_whenSendingWrongCommands_marsRoverShouldMoveAndThenRaiseAnException
	
	self should: [ marsRoverFacingNorth execute: 'ffxr'. ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: MarsRover aCommandMustBeAValidCommandErrorDescription equals: anError messageText ].
	
	self assert: ((marsRoverFacingNorth isPositionedAt: 0@2) and: [ marsRoverFacingNorth isNorth ]).
	 ! !


!MarsRoverTests methodsFor: 'private' stamp: 'RB 5/29/2022 00:02:12'!
assertMarsRoverIsPositionedAtOrigin

	^marsRoverFacingNorth isPositionedAt: 0@0.! !

!MarsRoverTests methodsFor: 'private' stamp: 'jms 5/31/2022 18:03:50'!
assertMarsRoverIsPositionedAtOriginFacingNorth

	self assert: (self assertMarsRoverIsPositionedAtOrigin and: [ marsRoverFacingNorth isNorth ])! !


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


!classDefinition: #FacingDirectionOfARover category: 'MarsRover'!
Object subclass: #FacingDirectionOfARover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!FacingDirectionOfARover methodsFor: 'information' stamp: 'jms 5/31/2022 18:05:41'!
isAPosibleFacingDirectionOfARover
	
	^true.! !

!FacingDirectionOfARover methodsFor: 'information' stamp: 'jms 5/31/2022 18:04:16'!
isEast

	^false.! !

!FacingDirectionOfARover methodsFor: 'information' stamp: 'jms 5/31/2022 18:03:50'!
isNorth

	^false.! !

!FacingDirectionOfARover methodsFor: 'information' stamp: 'jms 5/31/2022 18:04:07'!
isSouth

	^false.! !

!FacingDirectionOfARover methodsFor: 'information' stamp: 'jms 5/31/2022 18:03:59'!
isWest

	^false.! !


!FacingDirectionOfARover methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	self subclassResponsibility.! !


!classDefinition: #East category: 'MarsRover'!
FacingDirectionOfARover subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!East methodsFor: 'information' stamp: 'jms 5/31/2022 18:04:16'!
isEast

	^true.! !


!East methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingEast: aCommand.! !


!classDefinition: #North category: 'MarsRover'!
FacingDirectionOfARover subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!North methodsFor: 'information' stamp: 'jms 5/31/2022 18:03:50'!
isNorth

	^true.! !


!North methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingNorth: aCommand.
	! !


!classDefinition: #South category: 'MarsRover'!
FacingDirectionOfARover subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!South methodsFor: 'information' stamp: 'jms 5/31/2022 18:04:07'!
isSouth

	^true.! !


!South methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingSouth: aCommand.! !


!classDefinition: #West category: 'MarsRover'!
FacingDirectionOfARover subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!West methodsFor: 'information' stamp: 'jms 5/31/2022 18:04:00'!
isWest

	^true.! !


!West methodsFor: 'private - execute dispatch' stamp: 'JMS 5/28/2022 19:05:31'!
send: aRover toExecute: aCommand
	
	aRover executeFacingWest: aCommand.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position facingDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/31/2022 18:04:16'!
isEast

	^facingDirection isEast.! !

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/31/2022 18:03:50'!
isNorth

	^facingDirection isNorth.! !

!MarsRover methodsFor: 'accessing' stamp: 'JMS 5/28/2022 23:18:34'!
isPositionedAt: aCoordinate
	
	^position = aCoordinate.! !

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/31/2022 18:04:07'!
isSouth

	^facingDirection isSouth.! !

!MarsRover methodsFor: 'accessing' stamp: 'jms 5/31/2022 18:04:00'!
isWest

	^facingDirection isWest.! !


!MarsRover methodsFor: 'error' stamp: 'jms 5/31/2022 18:16:13'!
aCommandSequenceMustBeAString

	self error: self class aCommandSequenceMustBeAStringErrorDescription.! !


!MarsRover methodsFor: 'initialization' stamp: 'JMS 5/28/2022 19:08:00'!
initializePositionedAt: aCoordinate facing: aDirection 

	position := aCoordinate.
	facingDirection := aDirection.! !


!MarsRover methodsFor: 'operations' stamp: 'jms 5/31/2022 18:14:44'!
execute: commandSequence

	self assertCommandSequenceIsString: commandSequence.
	
	self executeEachCommandIn: commandSequence.! !


!MarsRover methodsFor: 'testing' stamp: 'jms 5/31/2022 18:15:40'!
assertCommandSequenceIsString: commandSequence

	commandSequence isString ifFalse: [ self aCommandSequenceMustBeAString. ].! !


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


!MarsRover methodsFor: 'private - operations' stamp: 'jms 5/31/2022 17:24:43'!
executeEachCommandIn: commandSequence
		
	commandSequence do: [ :aCommand |
				facingDirection send: self toExecute: aCommand.				
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

!MarsRover class methodsFor: 'error' stamp: 'jms 5/31/2022 18:07:40'!
aDirectionMustBeAFacingDirectionOfARover

	self error: self aDirectionMustBeAFacingDirectionOfARoverErrorDescription.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'JMS 5/28/2022 20:56:56'!
aCommandMustBeAValidCommandErrorDescription

	^'A Mars Rover can only receive valid commands, forward (f), backwards (b), turn right (r), turn left (l).'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'jms 5/31/2022 18:16:13'!
aCommandSequenceMustBeAStringErrorDescription
	
	^'#execute can only receive a string as collaborator.'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'JMS 5/28/2022 18:22:37'!
aCoordinateMustBeAPointErrorDescription

	^'A Mars Rover can only receive valid coordinates (Point class instances).'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'jms 5/31/2022 18:07:17'!
aDirectionMustBeAFacingDirectionOfARoverErrorDescription

	^'A Mars Rover can only receive valid directions (instances of FacingDirectionOfARover subclasses).'.! !


!MarsRover class methodsFor: 'instance creation' stamp: 'jms 5/31/2022 18:08:09'!
at: aCoordinate facing: aDirection 
	
	self assertACoordinateIsPoint: aCoordinate.
	self assertADirectionIsAFacingDirectionOfARover: aDirection.
		
	^self new initializePositionedAt: aCoordinate facing: aDirection.
	! !


!MarsRover class methodsFor: 'testing' stamp: 'JMS 5/28/2022 18:18:04'!
assertACoordinateIsPoint: aCoordinate

	aCoordinate isPoint ifFalse: [ self aCoordinateMustBeAPoint. ].! !

!MarsRover class methodsFor: 'testing' stamp: 'jms 5/31/2022 18:08:09'!
assertADirectionIsAFacingDirectionOfARover: aDirection

	[ aDirection isAPosibleFacingDirectionOfARover ]
		on: Error
		do: [ self aDirectionMustBeAFacingDirectionOfARover. ].! !
