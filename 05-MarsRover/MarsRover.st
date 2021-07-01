!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:49'!
test01CanMoveForward

	rover executeCommandSequence: 'f'.

	self assert: (rover isAt: 0@1).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:48'!
test02CanMoveBackwards

	rover executeCommandSequence: 'b'.

	self assert: (rover isAt: 0@-1).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:49'!
test03CanRotateRight

	rover executeCommandSequence: 'r'.

	self assert: (rover isFacing: #East).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:48'!
test04CanRotateLeft

	rover executeCommandSequence: 'l'.

	self assert: (rover isFacing: #West).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:49'!
test05CanMoveMultipleTimesInOneCommandSequence

	rover executeCommandSequence: 'bbbb'.

	self assert: (rover isAt: 0@-4).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:48'!
test06CanRotateMultipleTimesInOneCommandSequence

	rover executeCommandSequence: 'lll'.

	self assert: (rover isFacing: #East).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:48'!
test07CanMoveAndRotateInOneCommandSequence

	rover executeCommandSequence: 'frfr'.

	self assert: (rover isAt: 1@1 andFaces: #South).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:10:05'!
test08CanExecuteSeparateCommandSequencesInARow
 
	rover executeCommandSequence: 'bb'.
	rover executeCommandSequence: 'rr'.
	
	self assert: (rover isAt: 0@-2 andFaces: #South).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:10:22'!
test09RoverMovesCorrectlyWhenInitialPositionIsNotOrigin
 
	rover := MarsRover inPosition: -1@-1 facing: #South.
	
	rover executeCommandSequence: 'ffrb'.
	
	self assert: (rover isAt: 0@-3 andFaces: #West).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:10:49'!
test10ExecutesSequenceEndingInInitialPosition

	rover executeCommandSequence: 'ffbbrrrr'.

	self assert: (rover isAt: 0@0 andFaces: #North).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:11:57'!
test11CannotExecuteInvalidCommand

	| executingInvalidCommand |
	
	executingInvalidCommand := [rover executeCommandSequence: 'a'].

	self testThat: executingInvalidCommand throwsErrorWithMessage: MarsRover invalidCommandErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:13:25'!
test12CommandSequenceStopsExecutingAfterInvalidCommand

	| executingInvalidCommandSequence assertRoverPositionAndDirection |
	
	executingInvalidCommandSequence := [rover executeCommandSequence: 'bblaffl'].
	assertRoverPositionAndDirection := [ self assert: (rover isAt: 0@-2 andFaces: #West)].

	self testThat: executingInvalidCommandSequence throwsErrorSignalAndInThatCaseDo: assertRoverPositionAndDirection.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 15:54:59'!
test13RoverCannotBeInInvalidPosition
	
	self testThat: [MarsRover inPosition: 0 facing: CompassPointingNorth new] throwsErrorWithMessage: MarsRover invalidPositionErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:13:47'!
test14RoverFaceInvalidCardinalPoint

	self testThat: [MarsRover inPosition: 0@0 facing: #A] throwsErrorWithMessage: MarsRover invalidCardinalPointErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 16:13:54'!
test15CannotExecuteANonStringCommand

	| commandCollection executingANonStringCommand |

	commandCollection :=	OrderedCollection with: 'b' with: 'r'.
	executingANonStringCommand := [rover executeCommandSequence: commandCollection].
	
	self testThat: executingANonStringCommand throwsErrorWithMessage: MarsRover commandSequenceIsNotAStringErrorMessage.! !


!MarsRoverTest methodsFor: 'setup' stamp: 'ML 7/1/2021 15:55:12'!
setUp
	
	rover := MarsRover inPosition: 0@0 facing: #North.! !


!MarsRoverTest methodsFor: 'helpers' stamp: 'ML 7/1/2021 12:36:11'!
testThat: aClosure throwsErrorSignalAndInThatCaseDo: anotherClosure  

	[aClosure value. self fail.]
		on: Error
		do: anotherClosure.! !

!MarsRoverTest methodsFor: 'helpers' stamp: 'ML 7/1/2021 12:36:11'!
testThat: aClosure throwsErrorWithMessage: anErrorMessage 

	self testThat: aClosure throwsErrorSignalAndInThatCaseDo: [ :anError | self assert: (anError messageText = anErrorMessage) ].! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position compass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'ML 7/1/2021 12:07:20'!
initializeInPosition: aPosition withCompass: aCompass
	
	position := aPosition.
	compass := aCompass.! !


!MarsRover methodsFor: 'commands' stamp: 'ML 7/1/2021 15:59:36'!
executeCommandSequence: aCommandSequence 

	aCommandSequence class = String 
		ifFalse: [self error: self class commandSequenceIsNotAStringErrorMessage ]. 
		
	aCommandSequence do: [ :aCommandIdentifier | self executeCommand: aCommandIdentifier ].! !


!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:45:31'!
forwardMovementWhenPointingNorth

	^(0@1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:46:38'!
forwardPositionWhenPointingEast

	^(1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:46:44'!
forwardPositionWhenPointingSouth

	^(0@-1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:46:49'!
forwardPositionWhenPointingWest

	^(-1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:49:08'!
moveBackwards

	position := position + (compass backwardsDirectionOf: self).! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:46:04'!
moveForward

	position := position + (compass forwardDirectionOf: self).! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:51:23'!
rotateLeft

	compass := compass compassAfterRotatingLeft.! !

!MarsRover methodsFor: 'movement - private' stamp: 'ML 7/1/2021 11:51:36'!
rotateRight

	compass := compass compassAfterRotatingRight.! !


!MarsRover methodsFor: 'testing' stamp: 'ML 6/30/2021 12:18:48'!
isAt: aCoordinate

	^ (aCoordinate = position)! !

!MarsRover methodsFor: 'testing' stamp: 'ML 7/1/2021 11:54:16'!
isAt: aCoordinate andFaces: aCardinalPoint

	^ (self isAt: aCoordinate) and: [self isFacing: aCardinalPoint]! !

!MarsRover methodsFor: 'testing' stamp: 'ML 7/1/2021 11:53:33'!
isFacing: aCardinalPoint

	^ [aCardinalPoint = compass direction]! !


!MarsRover methodsFor: 'commands - private' stamp: 'ML 7/1/2021 15:59:04'!
executeCommand: aCommandIdentifier
					
	(RoverCommand for: aCommandIdentifier) beExecutedBy: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'ML 7/1/2021 15:54:59'!
inPosition: aPosition facing: aCardinalPoint
	
	| aCompass |
			
	(aPosition isKindOf: Point)
		ifFalse: [self error: self invalidPositionErrorMessage ].
			
 	aCompass := RoverCompass pointing: aCardinalPoint.

	^ self new initializeInPosition: aPosition withCompass: aCompass.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:32:56'!
commandSequenceIsNotAStringErrorMessage

	^'Command sequence should be a string'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 7/1/2021 15:48:39'!
invalidCardinalPointErrorMessage

	^'Rover must face a valid cardinal point'! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:13:43'!
invalidCommandErrorMessage

	^'Unkown command'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 7/1/2021 12:12:36'!
invalidPositionErrorMessage

	^'Position must be a valid Point'! !


!classDefinition: #RoverCommand category: 'MarsRover'!
Object subclass: #RoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCommand methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:10:49'!
beExecutedBy: aRover

	self subclassResponsibility! !

!RoverCommand methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:02:07'!
commandIdentifier

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCommand class' category: 'MarsRover'!
RoverCommand class
	instanceVariableNames: ''!

!RoverCommand class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:43:04'!
for: aCommandIdentifier
	
	| command |

	command := (self subclasses detect: [ :subclass | subclass isActivatedBy: aCommandIdentifier ] 
				   ifNone: [ self error: MarsRover invalidCommandErrorMessage ]). 
				
	^command new.! !


!classDefinition: #MoveBackwardsCommand category: 'MarsRover'!
RoverCommand subclass: #MoveBackwardsCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveBackwardsCommand methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:10:49'!
beExecutedBy: aRover

	aRover moveBackwards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveBackwardsCommand class' category: 'MarsRover'!
MoveBackwardsCommand class
	instanceVariableNames: ''!

!MoveBackwardsCommand class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:43:43'!
isActivatedBy: aCommandIdentifier

	^$b = aCommandIdentifier! !


!classDefinition: #MoveForwardCommand category: 'MarsRover'!
RoverCommand subclass: #MoveForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MoveForwardCommand methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:10:49'!
beExecutedBy: aRover

	aRover moveForward.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveForwardCommand class' category: 'MarsRover'!
MoveForwardCommand class
	instanceVariableNames: ''!

!MoveForwardCommand class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:44:04'!
isActivatedBy: aCommandIdentifier

	^$f = aCommandIdentifier! !


!classDefinition: #RotateLeftCommand category: 'MarsRover'!
RoverCommand subclass: #RotateLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateLeftCommand methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:10:49'!
beExecutedBy: aRover

	aRover rotateLeft.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateLeftCommand class' category: 'MarsRover'!
RotateLeftCommand class
	instanceVariableNames: ''!

!RotateLeftCommand class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:44:17'!
isActivatedBy: aCommandIdentifier

	^$l = aCommandIdentifier! !


!classDefinition: #RotateRightCommand category: 'MarsRover'!
RoverCommand subclass: #RotateRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RotateRightCommand methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:10:49'!
beExecutedBy: aRover

	aRover rotateRight.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RotateRightCommand class' category: 'MarsRover'!
RotateRightCommand class
	instanceVariableNames: ''!

!RotateRightCommand class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:44:36'!
isActivatedBy: aCommandIdentifier

	^$r = aCommandIdentifier! !


!classDefinition: #RoverCompass category: 'MarsRover'!
Object subclass: #RoverCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCompass methodsFor: 'compass' stamp: 'ML 7/1/2021 11:48:13'!
backwardsDirectionOf: aRover

	^(self forwardDirectionOf: aRover) negated.! !

!RoverCompass methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:23'!
compassAfterRotatingLeft

	^self subclassResponsibility.! !

!RoverCompass methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:36'!
compassAfterRotatingRight

	^self subclassResponsibility.! !

!RoverCompass methodsFor: 'compass' stamp: 'ML 7/1/2021 11:49:38'!
direction

	self subclassResponsibility ! !

!RoverCompass methodsFor: 'compass' stamp: 'ML 7/1/2021 11:42:53'!
forwardDirectionOf: aRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCompass class' category: 'MarsRover'!
RoverCompass class
	instanceVariableNames: ''!

!RoverCompass class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:56:33'!
pointing: aCardinalPoint

	| aCompass |
	
	aCompass := self subclasses detect: [ :subclass |  subclass isPointing: aCardinalPoint ] 
				ifNone: [ self error: MarsRover invalidCardinalPointErrorMessage ].
				
	^aCompass new! !


!classDefinition: #CompassPointingEast category: 'MarsRover'!
RoverCompass subclass: #CompassPointingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CompassPointingEast methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:22'!
compassAfterRotatingLeft

	^CompassPointingNorth new.! !

!CompassPointingEast methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:36'!
compassAfterRotatingRight

	^CompassPointingSouth new.! !

!CompassPointingEast methodsFor: 'compass' stamp: 'ML 7/1/2021 11:49:50'!
direction

	^#East! !

!CompassPointingEast methodsFor: 'compass' stamp: 'ML 7/1/2021 11:42:53'!
forwardDirectionOf: aRover

	^aRover forwardPositionWhenPointingEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompassPointingEast class' category: 'MarsRover'!
CompassPointingEast class
	instanceVariableNames: ''!

!CompassPointingEast class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:45:54'!
isPointing: aCardinalPoint

	^#East = aCardinalPoint ! !


!classDefinition: #CompassPointingNorth category: 'MarsRover'!
RoverCompass subclass: #CompassPointingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CompassPointingNorth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:22'!
compassAfterRotatingLeft

	^CompassPointingWest new.! !

!CompassPointingNorth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:36'!
compassAfterRotatingRight

	^CompassPointingEast new.! !

!CompassPointingNorth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:50:05'!
direction
	
	^#North	! !

!CompassPointingNorth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:42:53'!
forwardDirectionOf: aRover

	^aRover forwardMovementWhenPointingNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompassPointingNorth class' category: 'MarsRover'!
CompassPointingNorth class
	instanceVariableNames: ''!

!CompassPointingNorth class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:46:08'!
isPointing: aCardinalPoint

	^#North = aCardinalPoint ! !


!classDefinition: #CompassPointingSouth category: 'MarsRover'!
RoverCompass subclass: #CompassPointingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CompassPointingSouth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:23'!
compassAfterRotatingLeft

	^CompassPointingEast new.
	! !

!CompassPointingSouth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:36'!
compassAfterRotatingRight

	^CompassPointingWest new.
	! !

!CompassPointingSouth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:50:19'!
direction

	^#South! !

!CompassPointingSouth methodsFor: 'compass' stamp: 'ML 7/1/2021 11:42:53'!
forwardDirectionOf: aRover

	^aRover forwardPositionWhenPointingSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompassPointingSouth class' category: 'MarsRover'!
CompassPointingSouth class
	instanceVariableNames: ''!

!CompassPointingSouth class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:46:15'!
isPointing: aCardinalPoint

	^#South = aCardinalPoint ! !


!classDefinition: #CompassPointingWest category: 'MarsRover'!
RoverCompass subclass: #CompassPointingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CompassPointingWest methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:22'!
compassAfterRotatingLeft

	^CompassPointingSouth new.! !

!CompassPointingWest methodsFor: 'compass' stamp: 'ML 7/1/2021 11:51:36'!
compassAfterRotatingRight

	^CompassPointingNorth new.! !

!CompassPointingWest methodsFor: 'compass' stamp: 'ML 7/1/2021 11:50:31'!
direction

	^#West! !

!CompassPointingWest methodsFor: 'compass' stamp: 'ML 7/1/2021 11:42:53'!
forwardDirectionOf: aRover

	^aRover forwardPositionWhenPointingWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompassPointingWest class' category: 'MarsRover'!
CompassPointingWest class
	instanceVariableNames: ''!

!CompassPointingWest class methodsFor: 'as yet unclassified' stamp: 'ML 7/1/2021 15:46:24'!
isPointing: aCardinalPoint

	^#West = aCardinalPoint ! !
