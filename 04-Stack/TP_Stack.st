!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'MC 6/6/2021 23:38:00'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'MC 6/6/2021 23:03:07'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size topItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:52:02'!
isEmpty
	
	^ topItem = nil.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:26:04'!
pop
	| poppedItem |
	
	(topItem = nil) ifTrue: [ self signalEmptyStack].	
	
	poppedItem := topItem.
	topItem := poppedItem nextItem.
	size := (size - 1).
	
	^ poppedItem content.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:06:11'!
push: anItem

	| item |
	
	item := StackItem new.
	item content: anItem.
	item nextItem: topItem.
	topItem := item.
	size := (size + 1).
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:25:15'!
signalEmptyStack

	self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:37:06'!
size

	^ size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:51:12'!
size: newSize
	
	size := newSize.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:27:44'!
top
	self isEmpty ifTrue: [ self signalEmptyStack ].
	^ topItem content.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:36:58'!
topItem

	^ topItem.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:07:07'!
topItem: anItem

	topItem := anItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'MC 6/6/2021 23:12:02'!
stackEmptyErrorDescription

	^ 'Stack is empty'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:52:23'!
new
	| newStack |
	
	newStack := super new.
	newStack size: 0.
	newStack topItem: nil.
	
	^ newStack.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackItem category: 'Stack-Exercise'!
Object subclass: #StackItem
	instanceVariableNames: 'nextItem content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:05:18'!
content 

	^ content.! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:28:33'!
content: newContent

	content := newContent.! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:31:42'!
initializeWith: newContent

	self content: newContent.
	self nextItem: nil.! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 00:03:51'!
nextItem

	^ nextItem.! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/6/2021 23:29:16'!
nextItem: anItem

	nextItem := anItem.! !
