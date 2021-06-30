!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'test' stamp: 'MC 6/30/2021 01:13:53'!
test01CanMoveForward

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 facing: #North.
	rover executeCommandSequence: 'f'.

	self assert: (0@1) equals: (rover position).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MC 6/30/2021 01:13:53'!
test02CanMoveBackwards

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 facing: #North.
	rover executeCommandSequence: 'b'.

	self assert: (0@-1) equals: (rover position).! !

!MarsRoverTest methodsFor: 'test' stamp: 'MC 6/30/2021 01:13:53'!
test03CanRotateRight

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 facing: #North.
	rover executeCommandSequence: 'r'.

	self assert: #East equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MC 6/30/2021 01:13:53'!
test04CanRotateLeft

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 facing: #North.
	rover executeCommandSequence: 'l'.

	self assert: #West equals: rover direction.! !

!MarsRoverTest methodsFor: 'test' stamp: 'MC 6/30/2021 01:13:53'!
test05CanMoveAndRotateInOneCommandSequence

	| rover |
	
	rover := MarsRover inPosition: 0 and: 0 facing: #North.
	rover executeCommandSequence: 'frfr'.

	self assert: (1@1) equals: rover position.
	self assert: #South equals: rover direction.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'MC 6/30/2021 00:08:30'!
initializeInPosition: x and: y facing: aDirection  

	position := x@y.
	direction := aDirection.! !


!MarsRover methodsFor: 'commands' stamp: 'MC 6/30/2021 01:14:08'!
executeCommandSequence: aCommandSequence 
	
	aCommandSequence do: [ :command |
				(command = $f) ifTrue: [ self moveForward ].
				(command = $b) ifTrue: [ self moveBackwards ].
				(command = $r) ifTrue: [ self rotateRight ].
				(command = $l) ifTrue: [ self rotateLeft ].
			].
		
	! !


!MarsRover methodsFor: 'accessing' stamp: 'MC 6/30/2021 00:09:50'!
direction
	
	^ direction.! !

!MarsRover methodsFor: 'accessing' stamp: 'MC 6/29/2021 23:52:50'!
position
	
	^ position.! !


!MarsRover methodsFor: 'movement' stamp: 'MC 6/30/2021 01:07:02'!
moveBackwards

	direction = #North ifTrue: [ position := position + (0@-1). ^self ].
	direction = #East ifTrue: [ position := position + (-1@0). ^self ].
	direction = #West ifTrue: [ position := position + (1@0). ^self ].
	direction = #South ifTrue: [ position := position + (0@1). ^self ].! !

!MarsRover methodsFor: 'movement' stamp: 'MC 6/30/2021 01:06:54'!
moveForward

	direction = #North ifTrue: [ position := position + (0@1). ^self ].
	direction = #East ifTrue: [ position := position + (1@0). ^self ].
	direction = #West ifTrue: [ position := position + (-1@0). ^self ].
	direction = #South ifTrue: [ position := position + (0@-1). ^self ].! !

!MarsRover methodsFor: 'movement' stamp: 'MC 6/30/2021 01:06:18'!
rotateLeft

	direction = #North ifTrue: [ direction := #West. ^self ].
	direction = #East ifTrue: [ direction := #North. ^self ].
	direction = #West ifTrue: [ direction := #South. ^self ].
	direction = #South ifTrue: [ direction := #East. ^self ].! !

!MarsRover methodsFor: 'movement' stamp: 'MC 6/30/2021 01:06:34'!
rotateRight

	direction = #North ifTrue: [ direction := #East. ^self ].
	direction = #East ifTrue: [ direction := #South. ^self ].
	direction = #West ifTrue: [ direction := #North. ^self ].
	direction = #South ifTrue: [ direction := #West. ^self ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'MC 6/30/2021 00:07:21'!
inPosition: x and: y facing: aDirection  

	^ self new initializeInPosition: x and: y facing: aDirection.! !
