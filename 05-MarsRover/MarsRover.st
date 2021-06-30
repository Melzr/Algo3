!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:26:33'!
test01CanMoveForward

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'f'.

	self assert: (0@1) equals: (rover position).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:28:40'!
test02CanMoveBackwards

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'b'.

	self assert: (0@-1) equals: (rover position).! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:26:45'!
test03CanRotateRight

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'r'.

	self assert: PointingEast equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:28:27'!
test04CanRotateLeft

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'l'.

	self assert: PointingWest equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:26:54'!
test05CanMoveMultipleTimesInOneCommandSequence

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'bbbb'.

	self assert: (0@-4) equals: rover position.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:26:59'!
test06CanRotateMultipleTimesInOneCommandSequence

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'lll'.

	self assert: PointingEast equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:03'!
test07CanMoveAndRotateInOneCommandSequence

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'frfr'.

	self assert: (1@1) equals: rover position.
	self assert: PointingSouth equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:10'!
test08ExecutesSequenceEndingInInitialPosition

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'ffbbrrrr'.

	self assert: (0@0) equals: rover position.
	self assert: PointingNorth equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:14'!
test09CannotExecuteInvalidCommand

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.

	[rover executeCommandSequence: 'a'. self fail]
			on: Error
			do: [:anError | 
				self assert: anError messageText = MarsRover invalidCommandErrorMessage. ].! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:19'!
test10CommandSequenceStopsExecutingAfterInvalidCommand

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.

	[rover executeCommandSequence: 'bblaffl'. self fail]
			on: Error
			do: [
				self assert: (0@-2) equals: rover position.
				self assert: PointingWest equals: rover direction.
				 ].! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:23'!
test11CannotExecuteANonStringCommand

	| rover commandCollection |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.

	commandCollection :=	OrderedCollection with: 'b' with: 'r'.
	
	[rover executeCommandSequence: commandCollection. self fail]
			on: Error
			do: [:anError | 
				self assert: anError messageText = MarsRover commandSequenceIsNotAStringErrorMessage. ].! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:40'!
test12RoverCannotFaceInvalidDirection
	
	[MarsRover inPosition: 0 and: 0 withCompass: #A. self fail]
			on: Error
			do: [:anError | 
				self assert: anError messageText = MarsRover invalidCardinalPointErrorMessage. ].! !

!MarsRoverTest methodsFor: 'test' stamp: 'ML 6/30/2021 13:27:31'!
test13CanExecuteSeparateCommandSequencesInARow
 
	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 withCompass: PointingNorth new.
	rover executeCommandSequence: 'bb'.
	rover executeCommandSequence: 'rr'.

	self assert: (0@-2) equals: rover position.
	self assert: PointingSouth equals: rover direction.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position compass'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'ML 6/30/2021 12:11:07'!
initializeInPosition: x and: y withCompass: aCompass
	
	position := x@y.
	compass := aCompass.! !


!MarsRover methodsFor: 'commands' stamp: 'ML 6/30/2021 12:51:28'!
executeCommandSequence: aCommandSequence 

	aCommandSequence class = String 
		ifFalse: [self error: self class commandSequenceIsNotAStringErrorMessage ]. 
	
	aCommandSequence do: [ :command |
				(command = $f or: command = $b or: command = $r or: command = $l) 
					ifFalse: [self error: self class invalidCommandErrorMessage].
					
				(command = $f) ifTrue: [ self moveForward ].
				(command = $b) ifTrue: [ self moveBackwards ].
				(command = $r) ifTrue: [ self rotateRight ].
				(command = $l) ifTrue: [ self rotateLeft ].
			].
		! !


!MarsRover methodsFor: 'accessing' stamp: 'ML 6/30/2021 12:17:03'!
direction
	
	^ compass class.! !

!MarsRover methodsFor: 'accessing' stamp: 'ML 6/30/2021 12:17:37'!
position
	
	^ position.! !


!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 13:13:34'!
backwardsPositionWhenPointingEast

	^position + (-1@0).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 13:13:43'!
backwardsPositionWhenPointingNorth

	^position + (0@-1).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 13:13:53'!
backwardsPositionWhenPointingSouth

	^position + (0@1).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 13:14:03'!
backwardsPositionWhenPointingWest

	^position + (1@0).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:44:57'!
forwardPositionWhenPointingEast

	^position + (1@0).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:45:58'!
forwardPositionWhenPointingNorth

	^position + (0@1).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:45:51'!
forwardPositionWhenPointingSouth

	^position + (0@-1).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:44:47'!
forwardPositionWhenPointingWest

	^position + (-1@0).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 13:03:03'!
moveBackwards

	position := (compass backwardsPositionOf: self).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:46:10'!
moveForward

	position := (compass forwardPositionOf: self).! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:07:09'!
rotateLeft

	compass := compass directionAfterRotatingLeft.! !

!MarsRover methodsFor: 'movement' stamp: 'ML 6/30/2021 12:07:25'!
rotateRight

	compass := compass directionAfterRotatingRight.! !


!MarsRover methodsFor: 'testing' stamp: 'ML 6/30/2021 12:20:22'!
compassIs: aCompass

	^ [aCompass = compass class]! !

!MarsRover methodsFor: 'testing' stamp: 'ML 6/30/2021 12:18:48'!
isAt: aCoordinate

	^ (aCoordinate = position)! !

!MarsRover methodsFor: 'testing' stamp: 'ML 6/30/2021 12:21:19'!
isAt: aCoordinate andCompassIs: aCompass

	^ (self isAt: aCoordinate) and: [self compassIs: aCompass]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'ML 6/30/2021 13:26:18'!
inPosition: x and: y withCompass: aCompass

	(aCompass class superclass = RoverCompass)
		ifFalse: [self error: self invalidCardinalPointErrorMessage ].

	^ self new initializeInPosition: x and: y withCompass: aCompass.! !


!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:32:56'!
commandSequenceIsNotAStringErrorMessage

	^'Command sequence should be a string'.! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:43:11'!
invalidCardinalPointErrorMessage

	^'Rover must face a valid cardinal point'! !

!MarsRover class methodsFor: 'error descriptions' stamp: 'ML 6/30/2021 11:13:43'!
invalidCommandErrorMessage

	^'Unkown command'.! !


!classDefinition: #RoverCompass category: 'MarsRover'!
Object subclass: #RoverCompass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!RoverCompass methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 13:14:20'!
backwardsPositionOf: aRover

	self subclassResponsibility! !

!RoverCompass methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:00:52'!
directionAfterRotatingLeft

	^self subclassResponsibility.! !

!RoverCompass methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:01:27'!
directionAfterRotatingRight

	^self subclassResponsibility.! !

!RoverCompass methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:46:40'!
forwardPositionOf: aRover

	self subclassResponsibility ! !


!classDefinition: #PointingEast category: 'MarsRover'!
RoverCompass subclass: #PointingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingEast methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 13:14:40'!
backwardsPositionOf: aRover

	^aRover backwardsPositionWhenPointingEast! !

!PointingEast methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:02:26'!
directionAfterRotatingLeft

	^PointingNorth new.! !

!PointingEast methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:02:12'!
directionAfterRotatingRight

	^PointingSouth new.! !

!PointingEast methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:48:14'!
forwardPositionOf: aRover

	^aRover forwardPositionWhenPointingEast! !


!classDefinition: #PointingNorth category: 'MarsRover'!
RoverCompass subclass: #PointingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingNorth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 13:14:50'!
backwardsPositionOf: aRover

	^aRover backwardsPositionWhenPointingNorth! !

!PointingNorth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:02:44'!
directionAfterRotatingLeft

	^PointingWest new.! !

!PointingNorth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:02:53'!
directionAfterRotatingRight

	^PointingEast new.! !

!PointingNorth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:48:25'!
forwardPositionOf: aRover

	^aRover forwardPositionWhenPointingNorth! !


!classDefinition: #PointingSouth category: 'MarsRover'!
RoverCompass subclass: #PointingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingSouth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 13:14:59'!
backwardsPositionOf: aRover

	^aRover backwardsPositionWhenPointingSouth! !

!PointingSouth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:03:26'!
directionAfterRotatingLeft

	^PointingEast new.
	! !

!PointingSouth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:03:42'!
directionAfterRotatingRight

	^PointingWest new.
	! !

!PointingSouth methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:48:36'!
forwardPositionOf: aRover

	^aRover forwardPositionWhenPointingSouth! !


!classDefinition: #PointingWest category: 'MarsRover'!
RoverCompass subclass: #PointingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!PointingWest methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 13:15:06'!
backwardsPositionOf: aRover

	^aRover backwardsPositionWhenPointingWest! !

!PointingWest methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:04:32'!
directionAfterRotatingLeft

	^PointingSouth new.! !

!PointingWest methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:04:26'!
directionAfterRotatingRight

	^PointingNorth new.! !

!PointingWest methodsFor: 'as yet unclassified' stamp: 'ML 6/30/2021 12:48:47'!
forwardPositionOf: aRover

	^aRover forwardPositionWhenPointingWest! !
