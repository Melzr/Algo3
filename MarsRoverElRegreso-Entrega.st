!classDefinition: #TestLog category: 'MarsRover-Solucion'!
TestCase subclass: #TestLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestLog methodsFor: 'helpers' stamp: 'ML 7/21/2021 20:14:18'!
assertThatOnlyEntryInLog: aLog is: aLogEntry

	self assert: 1 equals: aLog size.
	self assert: aLogEntry equals: aLog first. ! !

!TestLog methodsFor: 'helpers' stamp: 'ML 7/21/2021 20:10:28'!
headingLogForMarsRoverInPosition: aPosition heading: aCardinalPoint andProcessedCommandSequence: aCommandSequence

	| marsRover log |
	
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	log := MarsRoverLog new.
	marsRover addHeadingObserver: log.
	marsRover processCommands: aCommandSequence .
	
	^log! !

!TestLog methodsFor: 'helpers' stamp: 'ML 7/21/2021 20:06:41'!
positionLogForMarsRoverInPosition: aPosition heading: aCardinalPoint andProcessedCommandSequence: aCommandSequence

	| marsRover log |
	
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	log := MarsRoverLog new.
	marsRover addPositionObserver: log.
	marsRover processCommands: aCommandSequence .
	
	^log! !


!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:13:01'!
test01LogIsEmptyWhenThereAreNoChangesInPositionOrDirection

	| log |
	
	log := self positionLogForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: ''.
	
	self assert: log isEmpty.! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:14:47'!
test02LogRegistersChangeInPositionWhenMarsRoverMovesUp

	| log |
	
	log := self positionLogForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'f'.
	
	self deny: log isEmpty.
	self assertThatOnlyEntryInLog: log is: '0@1'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:15:05'!
test03LogRegistersChangeInPositionWhenMarsRoverMovesDown

	| log |
	
	log := self positionLogForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'b'.

	self assertThatOnlyEntryInLog: log is: '0@-1'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:15:16'!
test04LogRegistersChangeInPositionWhenMarsRoverMovesRight

	| log |
	
	log := self positionLogForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'f'.
	
	self assertThatOnlyEntryInLog: log is: '1@0'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:15:30'!
test05LogRegistersChangeInPositionWhenMarsRoverMovesLeft

	| log |
	
	log := self positionLogForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'b'.

	self assertThatOnlyEntryInLog: log is: '-1@0'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:15:42'!
test06LogRegistersChangeInHeadingWhenMarsRoverRotatesEast

	| log |
	
	log := self headingLogForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'r'.
	
	self assertThatOnlyEntryInLog: log is: 'East'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:15:55'!
test07LogRegistersChangeInHeadingWhenMarsRoverRotatesWest

	| log |
	
	log := self headingLogForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'l'.
	
	self assertThatOnlyEntryInLog: log is: 'West'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:16:09'!
test08LogRegistersChangeInHeadingWhenMarsRoverRotatesSouth

	| log |
	
	log := self headingLogForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'r'.
	
	self assertThatOnlyEntryInLog: log is: 'South'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:16:20'!
test09LogRegistersChangeInHeadingWhenMarsRoverRotatesNorth

	| log |
	
	log := self headingLogForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'l'.
	
	self assertThatOnlyEntryInLog: log is: 'North'! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:23:40'!
test10PositionLogRegistersMultipleChangesInPosition

	| log |
	
	log := self positionLogForMarsRoverInPosition: 0@0 heading: #South andProcessedCommandSequence: 'ff'.
	
	self assert: 2 equals: log size.
	self assert: '0@-1' equals: log first.
	self assert: '0@-2' equals: log second.! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:24:31'!
test11HeadingLogRegistersMultipleChangesInPosition

	| log |
	
	log := self headingLogForMarsRoverInPosition: 0@0 heading: #West andProcessedCommandSequence: 'rr'.
	
	self assert: 2 equals: log size.
	self assert: 'North' equals: log first.
	self assert: 'East' equals: log second.! !

!TestLog methodsFor: 'tests' stamp: 'ML 7/21/2021 20:24:42'!
test12PositionAndHeadingLogRegistersWhenRoverMovesAndRotates

	| marsRover log |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	log := MarsRoverLog new.
	marsRover addPositionObserver: log.
	marsRover addHeadingObserver: log.
	marsRover processCommands: 'fl'.
	
	self assert: 2 equals: log size.
	self assert: '0@1' equals: log first.
	self assert: 'West' equals: log second.! !


!classDefinition: #TestMarsRover category: 'MarsRover-Solucion'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:42:57'!
test01MarsRoverDoestNotMoveWhenNoCommandsAreSent

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: '' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:05'!
test02RoverFacingNorthCanMoveForward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'f' endsAt: 0@1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:13'!
test03RoverFacingNorthCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'b' endsAt: 0@-1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:24'!
test04RoverFacingNorthHeadsEastAfterTurningRight

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'r' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:55'!
test05RoverFacingNorthHeadsWestAfterTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'l' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:26'!
test06RoverFacingEastHeadsSouthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'r' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:43'!
test07RoverFacingSouthHeadsWestWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'r' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:00'!
test08RoverFacingWestHeadsNorthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'r' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:20'!
test09RoverFacingEastHeadsNorthWhenTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'l' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:52'!
test10RoverFacingSouthHeadsEastWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'l' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:46:17'!
test11RoverFacingWestHeadsSouthWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'l' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:36'!
test12RoverFacingEastCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'f' endsAt: 1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:55'!
test13RoverFacingEastCanMoveBackwards

	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'b' endsAt: -1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:20'!
test14RoverFacingSouthCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'f' endsAt: 0@-1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:38'!
test15RoverFacingSouthCanMoveBackward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'b' endsAt: 0@1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:10'!
test16RoverFacingWestCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'f' endsAt: -1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:46'!
test17RoverFacingWestCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'b' endsAt: 1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:50:56'!
test18RoverCanProcessMultipleCommands

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'ff' endsAt: 0@2 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 6/30/2021 16:05:43'!
test19RoverStopsWhenProcessingAnInvalidCommand

	| marsRover |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	
	self should: [ marsRover processCommands: 'fxf' ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: marsRover invalidCommandErrorMessage.
			self assert: (marsRover isAt: 0@1 heading: #North).
		].
	
	! !


!TestMarsRover methodsFor: 'assertions' stamp: 'LL 7/1/2021 00:42:36'!
assertRoverStartingAt: aPosition heading: aCardinalPoint afterProcessing: aStringOfCommands endsAt: aFinalPosition heading: aFinalCardinalPoint

	| marsRover |
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	
	marsRover processCommands: aStringOfCommands.
	
	self assert: (marsRover isAt: aFinalPosition heading: aFinalCardinalPoint)! !


!classDefinition: #TestWindow category: 'MarsRover-Solucion'!
TestCase subclass: #TestWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:28:10'!
test01PositionWindowShowsNothingWhenNoCommandsAreProcessed

	| window |
	
	window := self positionWindowForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: ''.
	
	self assert: '' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:28:39'!
test02PositionWindowUpdatesPositionWhenMarsRoverMovesUp

	| window |
	
	window := self positionWindowForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'f'.
	
	self assert: '0@1' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:28:54'!
test03PositionWindowUpdatesPositionWhenMarsRoverMovesDown

	| window |
	
	window := self positionWindowForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'b'.

	self assert: '0@-1' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:29:11'!
test04PositionWindowUpdatesPositionWhenMarsRoverMovesRight

	| window |
	
	window := self positionWindowForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'f'.
	
	self assert: '1@0' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:29:26'!
test05PositionWindowUpdatesPositionWhenMarsRoverMovesLeft

	| window |
	
	window := self positionWindowForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'b'.
	
	self assert: '-1@0' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:30:46'!
test06HeadingWindowUpdatesDirectionWhenMarsRoverRotatesEast

	| window |
	
	window := self headingWindowForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'r'.
	
	self assert: 'East' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:30:36'!
test07HeadingWindowUpdatesDirectionWhenMarsRoverRotatesWest

	| window |
	
	window := self headingWindowForMarsRoverInPosition: 0@0 heading: #North andProcessedCommandSequence: 'l'.
	
	self assert: 'West' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:30:26'!
test08HeadingWindowUpdatesDirectionWhenMarsRoverRotatesSouth

	| window |
	
	window := self headingWindowForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'r'.
	
	self assert: 'South' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 20:31:05'!
test09HeadingWindowUpdatesDirectionWhenMarsRoverRotatesNorth

	| window |
	
	window := self headingWindowForMarsRoverInPosition: 0@0 heading: #East andProcessedCommandSequence: 'l'.
	
	self assert: 'North' equals: window status.! !

!TestWindow methodsFor: 'tests' stamp: 'ML 7/21/2021 19:49:08'!
test10PositionAndHeadingWindowUpdatesWhenRoverMovesAndRotates

	| marsRover window |
	
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addPositionObserver: window.
	marsRover addHeadingObserver: window.
	marsRover processCommands: 'fr'.
	
	self assert: '0@1East' equals: window status.! !


!TestWindow methodsFor: 'helpers' stamp: 'ML 7/21/2021 20:27:22'!
headingWindowForMarsRoverInPosition: aPosition heading: aCardinalPoint andProcessedCommandSequence: aCommandSequence

	| marsRover aWindow |

	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	aWindow := MarsRoverWindow new.
	marsRover addHeadingObserver: aWindow .
	marsRover processCommands: aCommandSequence.
	
	^aWindow! !

!TestWindow methodsFor: 'helpers' stamp: 'ML 7/21/2021 20:27:11'!
positionWindowForMarsRoverInPosition: aPosition heading: aCardinalPoint andProcessedCommandSequence: aCommandSequence

	| marsRover aWindow |

	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	aWindow := MarsRoverWindow new.
	marsRover addPositionObserver: aWindow .
	marsRover processCommands: aCommandSequence.
	
	^aWindow! !


!classDefinition: #MarsRover category: 'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'ML 7/22/2021 18:02:49'!
initializeStartingAt: aCoordinate heading: aCardinalPoint 
	
	| aHead |
	
	position := ObservablePosition for: aCoordinate.
	
	aHead := MarsRoverHead of: self facing: aCardinalPoint.
	head := ObservableHead for: aHead.
	! !


!MarsRover methodsFor: 'testing' stamp: 'ML 7/22/2021 18:04:01'!
isAt: aPosition heading: aCardinalPoint

	^ (position value = aPosition) and: [ head isHeading: aCardinalPoint ]! !


!MarsRover methodsFor: 'process commands' stamp: 'LL 6/30/2021 15:54:14'!
processCommands: aStringWithCommands

	aStringWithCommands do: [ :aCommand | 
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand.
	].
	
! !


!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:54:11'!
assertCommandIsValid: aCommand

	^ (self isInvalidCommand: aCommand) ifTrue: [ self error: self invalidCommandErrorMessage ]! !

!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:48:06'!
invalidCommandErrorMessage

	^'Invalid command'! !

!MarsRover methodsFor: 'private - process commands' stamp: 'ML 7/22/2021 18:04:29'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ head movingForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ head movingBackwards ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ head rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ head rotateLeft ].
! !


!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:42'!
isBackwardCommand: command

	^ command = $b! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:27'!
isForwardCommand: command

	^ command = $f! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:51:21'!
isInvalidCommand: aCommand
	^(self isForwardCommand: aCommand) not and: 
		[ (self isBackwardCommand: aCommand) not and: 
			[ (self isRotateRightCommand: aCommand) not and: 
				[ (self isRotateLeftCommand: aCommand) not ] ] ]! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:50:53'!
isRotateLeftCommand: command

	^ command = $l! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:27:33'!
isRotateRightCommand: command

	^ command = $r! !


!MarsRover methodsFor: 'dd - moving' stamp: 'ML 7/21/2021 13:17:25'!
moveDown

	self step: (0@-1).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'ML 7/21/2021 13:17:41'!
moveLeft

	self step: (-1@0).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'ML 7/21/2021 13:17:51'!
moveRight

	self step: (1@0).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'ML 7/21/2021 13:18:04'!
moveUp

	self step: (0@1).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'ML 7/22/2021 18:02:36'!
step: aCoordinateToAdd

	position updateValue: (position value + aCoordinateToAdd).! !


!MarsRover methodsFor: 'dd - heading' stamp: 'ML 7/22/2021 18:02:25'!
head: newHead

	head updateValue: newHead.! !

!MarsRover methodsFor: 'dd - heading' stamp: 'ML 7/21/2021 19:34:08'!
headEast

	self head: (MarsRoverHeadFacingEast of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'ML 7/21/2021 19:34:08'!
headNorth

	self head: (MarsRoverHeadFacingNorth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'ML 7/21/2021 19:34:08'!
headSouth

	self head: (MarsRoverHeadFacingSouth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'ML 7/21/2021 19:34:08'!
headWest

	self head: (MarsRoverHeadFacingWest of: self).! !


!MarsRover methodsFor: 'observers' stamp: 'ML 7/22/2021 18:02:25'!
addHeadingObserver: aMarsRoverObserver

	head addObserver: aMarsRoverObserver.! !

!MarsRover methodsFor: 'observers' stamp: 'ML 7/22/2021 18:02:36'!
addPositionObserver: aMarsRoverObserver

	position addObserver: aMarsRoverObserver.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Solucion'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 13:30:13'!
startingAt: aPoint heading: aCardinalPoint 
	
	^self new initializeStartingAt: aPoint heading: aCardinalPoint ! !


!classDefinition: #MarsRoverHead category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverHead
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:17:57'!
initializeOf: aMarsRover

	marsRover := aMarsRover! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
isHeading: aCardinalPoint

	^self class whenFacing: aCardinalPoint

	! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:46'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:43'!
rotateRight

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHead class' category: 'MarsRover-Solucion'!
MarsRoverHead class
	instanceVariableNames: ''!

!MarsRoverHead class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	self subclassResponsibility.! !


!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 16:16:27'!
of: aMarsRover

	^self new initializeOf: aMarsRover! !

!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 19:46:37'!
of: aMarsRover facing: aCardinalPoint
	
	| headingSubclass |
	headingSubclass := self subclasses detect: [ :aHeadingSubclass | aHeadingSubclass whenFacing: aCardinalPoint ].
	
	^headingSubclass of: aMarsRover.! !


!classDefinition: #MarsRoverHeadFacingEast category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveLeft.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveRight.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:22'!
rotateLeft

	^marsRover headNorth.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:14'!
rotateRight

	^marsRover headSouth.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingEast class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingEast class
	instanceVariableNames: ''!

!MarsRoverHeadFacingEast class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #East! !


!classDefinition: #MarsRoverHeadFacingNorth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveDown.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveUp.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:33'!
rotateLeft

	^marsRover headWest.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:58'!
rotateRight

	^marsRover headEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingNorth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingNorth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #North! !


!classDefinition: #MarsRoverHeadFacingSouth category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveUp.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveDown! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:43'!
rotateLeft

	^marsRover headEast.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:30'!
rotateRight

	^marsRover headWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingSouth class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingSouth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #South! !


!classDefinition: #MarsRoverHeadFacingWest category: 'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveRight.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveLeft.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:52'!
rotateLeft

	^marsRover headSouth.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:44'!
rotateRight

	^marsRover headNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingWest class' category: 'MarsRover-Solucion'!
MarsRoverHeadFacingWest class
	instanceVariableNames: ''!

!MarsRoverHeadFacingWest class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #West! !


!classDefinition: #MarsRoverLog category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'entries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverLog methodsFor: 'testing' stamp: 'ML 7/21/2021 11:40:55'!
isEmpty

	^ (self size = 0).! !


!MarsRoverLog methodsFor: 'accessing' stamp: 'ML 7/21/2021 11:45:40'!
first

	^entries first.! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'ML 7/21/2021 12:08:33'!
second

	^entries second.! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'ML 7/21/2021 11:43:01'!
size

	^ entries size.! !


!MarsRoverLog methodsFor: 'initialization' stamp: 'ML 7/21/2021 11:34:40'!
initialize

	entries := OrderedCollection new.! !


!MarsRoverLog methodsFor: 'log' stamp: 'ML 7/21/2021 15:30:30'!
headingChangedTo: newHead

	(newHead isKindOf: MarsRoverHeadFacingEast) ifTrue: [entries add: 'East'].
	(newHead isKindOf: MarsRoverHeadFacingWest) ifTrue: [entries add: 'West'].
	(newHead isKindOf: MarsRoverHeadFacingSouth) ifTrue: [entries add: 'South'].
	(newHead isKindOf: MarsRoverHeadFacingNorth) ifTrue: [entries add: 'North'].! !

!MarsRoverLog methodsFor: 'log' stamp: 'ML 7/21/2021 15:30:50'!
positionChangedTo: newPosition

	entries add: newPosition asString.! !


!classDefinition: #MarsRoverObservableVariable category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverObservableVariable
	instanceVariableNames: 'observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverObservableVariable methodsFor: 'value' stamp: 'ML 7/21/2021 19:32:53'!
updateValue: newValue

	self subclassResponsibility ! !

!MarsRoverObservableVariable methodsFor: 'value' stamp: 'ML 7/21/2021 19:36:06'!
value

	self subclassResponsibility ! !


!MarsRoverObservableVariable methodsFor: 'observers' stamp: 'ML 7/21/2021 19:28:02'!
addObserver: aMarsRoverObserver

	observers add: aMarsRoverObserver.! !


!MarsRoverObservableVariable methodsFor: 'notify' stamp: 'ML 7/21/2021 19:29:55'!
changed

	self subclassResponsibility! !


!classDefinition: #ObservableHead category: 'MarsRover-Solucion'!
MarsRoverObservableVariable subclass: #ObservableHead
	instanceVariableNames: 'head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!ObservableHead methodsFor: 'value' stamp: 'ML 7/21/2021 19:32:07'!
updateValue: newHead

	head := newHead.
	self changed.! !

!ObservableHead methodsFor: 'value' stamp: 'ML 7/21/2021 19:36:22'!
value

	^head! !


!ObservableHead methodsFor: 'initialization' stamp: 'ML 7/21/2021 19:30:50'!
initializeFor: aMarsRoverHead

	head := aMarsRoverHead.
	observers := OrderedCollection new.! !


!ObservableHead methodsFor: 'notify' stamp: 'ML 7/21/2021 19:30:45'!
changed

	observers do: [ :anObserver | anObserver headingChangedTo: head ].! !


!ObservableHead methodsFor: 'as yet unclassified' stamp: 'ML 7/22/2021 18:03:36'!
doesNotUnderstand: aMessage

	^aMessage sendTo: self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObservableHead class' category: 'MarsRover-Solucion'!
ObservableHead class
	instanceVariableNames: ''!

!ObservableHead class methodsFor: 'as yet unclassified' stamp: 'ML 7/21/2021 18:40:16'!
for: aMarsRoverHead

	^self new initializeFor: aMarsRoverHead.	! !


!classDefinition: #ObservablePosition category: 'MarsRover-Solucion'!
MarsRoverObservableVariable subclass: #ObservablePosition
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!ObservablePosition methodsFor: 'initialization' stamp: 'ML 7/21/2021 19:31:01'!
initializeFor: aCardinalPoint

	position := aCardinalPoint.
	observers := OrderedCollection new. ! !


!ObservablePosition methodsFor: 'value' stamp: 'ML 7/21/2021 19:32:38'!
updateValue: newPosition

	position := newPosition.
	self changed.! !

!ObservablePosition methodsFor: 'value' stamp: 'ML 7/21/2021 19:36:55'!
value

	^position! !


!ObservablePosition methodsFor: 'notify' stamp: 'ML 7/21/2021 19:30:57'!
changed

	observers do: [ :anObserver | anObserver positionChangedTo: position ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObservablePosition class' category: 'MarsRover-Solucion'!
ObservablePosition class
	instanceVariableNames: ''!

!ObservablePosition class methodsFor: 'as yet unclassified' stamp: 'ML 7/21/2021 17:14:47'!
for: aCardinalPoint

	^self new initializeFor: aCardinalPoint! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-Solucion'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'positionTextField headingTextField'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverWindow methodsFor: 'accessing' stamp: 'ML 7/21/2021 13:11:12'!
status

	^positionTextField, headingTextField! !


!MarsRoverWindow methodsFor: 'initialization' stamp: 'ML 7/21/2021 13:10:37'!
initialize

	positionTextField := ''.
	headingTextField := ''.! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'ML 7/21/2021 15:30:30'!
headingChangedTo: newHead

	(newHead isKindOf: MarsRoverHeadFacingEast) ifTrue: [headingTextField := 'East']. 
	(newHead isKindOf: MarsRoverHeadFacingWest) ifTrue: [headingTextField := 'West']. 
	(newHead isKindOf: MarsRoverHeadFacingSouth) ifTrue: [headingTextField := 'South']. 
	(newHead isKindOf: MarsRoverHeadFacingNorth) ifTrue: [headingTextField := 'North']. ! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'ML 7/21/2021 15:30:50'!
positionChangedTo: newPosition

	positionTextField := newPosition asString.! !
