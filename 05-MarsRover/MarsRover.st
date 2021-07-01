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

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:48'!
test08ExecutesSequenceEndingInInitialPosition

	rover executeCommandSequence: 'ffbbrrrr'.

	self assert: (rover isAt: 0@0 andFaces: #North).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:41:36'!
test09CannotExecuteInvalidCommand

	| executingInvalidCommand |
	
	executingInvalidCommand := [rover executeCommandSequence: 'a'].

	self testThat: executingInvalidCommand throwsErrorWithMessage: MarsRover invalidCommandErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:39:03'!
test10CommandSequenceStopsExecutingAfterInvalidCommand

	| executingInvalidCommandSequence assertRoverPositionAndDirection |
	
	executingInvalidCommandSequence := [rover executeCommandSequence: 'bblaffl'].
	assertRoverPositionAndDirection := [ self assert: (rover isAt: 0@-2 andFaces: #West)].

	self testThat: executingInvalidCommandSequence throwsErrorSignalAndInThatCaseDo: assertRoverPositionAndDirection.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:40:50'!
test11CannotExecuteANonStringCommand

	| commandCollection executingANonStringCommand |

	commandCollection :=	OrderedCollection with: 'b' with: 'r'.
	executingANonStringCommand := [rover executeCommandSequence: commandCollection].
	
	self testThat: executingANonStringCommand throwsErrorWithMessage: MarsRover commandSequenceIsNotAStringErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:28:38'!
test12RoverCannotHaveInvalidCompass

	self testThat: [MarsRover inPosition: 0@0 withCompass: #A] throwsErrorWithMessage: MarsRover invalidCompassErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:29:20'!
test13RoverCannotBeInInvalidPosition
	
	self testThat: [MarsRover inPosition: 0 withCompass: CompassPointingNorth new] throwsErrorWithMessage: MarsRover invalidPositionErrorMessage.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 7/1/2021 12:18:48'!
test14CanExecuteSeparateCommandSequencesInARow
 
	rover executeCommandSequence: 'bb'.
	rover executeCommandSequence: 'rr'.
	
	self assert: (rover isAt: 0@-2 andFaces: #South).! !


!MarsRoverTest methodsFor: 'setup' stamp: 'ML 7/1/2021 12:18:48'!
setUp
	
	rover := MarsRover inPosition: 0@0 withCompass: CompassPointingNorth new.! !


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


!MarsRover methodsFor: 'commands' stamp: 'ML 7/1/2021 12:44:26'!
executeCommandSequence: aCommandSequence 

	aCommandSequence class = String 
		ifFalse: [self error: self class commandSequenceIsNotAStringErrorMessage ]. 
	
	aCommandSequence do: [ :command | self executeCommand: command. ].
		! !


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


!MarsRover methodsFor: 'commands - private' stamp: 'ML 7/1/2021 12:43:47'!
executeCommand: aCommand

	(aCommand = $f or: aCommand = $b or: aCommand = $r or: aCommand = $l) 
		ifFalse: [self error: self class invalidCommandErrorMessage].
					
	(aCommand = $f) ifTrue: [ self moveForward ].
	(aCommand = $b) ifTrue: [ self moveBackwards ].
	(aCommand = $r) ifTrue: [ self rotateRight ].
	(aCommand = $l) ifTrue: [ self rotateLeft ].
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'ML 7/1/2021 12:13:47'!
inPosition: aPosition withCompass: aCompass

	(aCompass isKindOf: RoverCompass)
		ifFalse: [self error: self invalidCompassErrorMessage ].
		
	(aPosition isKindOf: Point)
		ifFalse: [self error: self invalidPositionErrorMessage ].	

	^ self new initializeInPosition: aPosition withCompass: aCompass.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:32:56'!
commandSequenceIsNotAStringErrorMessage

	^'Command sequence should be a string'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:13:43'!
invalidCommandErrorMessage

	^'Unkown command'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 7/1/2021 11:27:52'!
invalidCompassErrorMessage

	^'Rover must have a valid compass'! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 7/1/2021 12:12:36'!
invalidPositionErrorMessage

	^'Position must be a valid Point'! !


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
