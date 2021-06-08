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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ML 6/8/2021 20:54:51'!
test01CantFindStringByEmptyPrefix
	
	|aStack|

	self find: '' in: aStack! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size topItem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'MC 6/7/2021 23:22:10'!
initialize

	size := 0.
	topItem := EndOfStack new.! !


!OOStack methodsFor: 'testing' stamp: 'MC 6/7/2021 23:17:14'!
isEmpty
	
	^ size = 0.! !


!OOStack methodsFor: 'stack operations' stamp: 'MC 6/8/2021 00:02:21'!
pop
	| poppedItem |
	
	poppedItem := topItem content.
	topItem := topItem nextItem.
	size := (size - 1).
	
	^ poppedItem.! !

!OOStack methodsFor: 'stack operations' stamp: 'MC 6/8/2021 00:00:02'!
push: aContent

	topItem := StackItem with: aContent nextItem: topItem.
	size := (size + 1).
! !

!OOStack methodsFor: 'stack operations' stamp: 'MC 6/6/2021 23:37:06'!
size

	^ size.! !

!OOStack methodsFor: 'stack operations' stamp: 'MC 6/8/2021 00:03:47'!
top

	^ topItem content.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'MC 6/6/2021 23:12:02'!
stackEmptyErrorDescription

	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'ML 6/8/2021 20:38:05'!
verifyPrefix: aPrefix andStack: aStack
	
	aStack isEmpty ifTrue: [ self error: OOStack stackEmptyErrorDescription ].
	(aPrefix = ''	) ifTrue: [ self error: SentenceFinderByPrefix prefixIsEmptyErrorDescription ].
	(aPrefix findString: ' ') > 0 ifTrue: [ self error: SentenceFinderByPrefix prefixCannotContainMoreThanOneWordErrorDescription ].! !


!SentenceFinderByPrefix methodsFor: 'sentence finder' stamp: 'ML 6/8/2021 20:40:28'!
find: aPrefix in: aStack

	| auxStack coincidences |
	
	self verifyPrefix: aPrefix andStack: aStack.
	
	auxStack := aStack.
	coincidences := OrderedCollection new.
	
	aStack size timesRepeat: [ 
		| currentString |
		currentString := auxStack pop.
		(currentString beginsWith: aPrefix) ifTrue: [ coincidences add: currentString ].
				 ].
	
	^ coincidences.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'MC 6/8/2021 01:00:34'!
prefixCannotContainMoreThanOneWordErrorDescription

	^ 'Prefix should only be a word!!'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'MC 6/8/2021 00:50:20'!
prefixIsEmptyErrorDescription

	^ 'Prefix cannot be empty!!'! !


!classDefinition: #StackComponent category: 'Stack-Exercise'!
Object subclass: #StackComponent
	instanceVariableNames: 'nextItem content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackComponent methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 19:46:00'!
content 

	self subclassResponsibility.! !


!classDefinition: #EndOfStack category: 'Stack-Exercise'!
StackComponent subclass: #EndOfStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EndOfStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 23:35:33'!
content 

	self signalEmptyStack.! !

!EndOfStack methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 23:29:32'!
signalEmptyStack

	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #StackItem category: 'Stack-Exercise'!
StackComponent subclass: #StackItem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 19:53:31'!
content
	
	^ content.! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/8/2021 00:12:55'!
initializeWith: newContent nextItem: anItem

	content := newContent.
	nextItem := anItem.! !

!StackItem methodsFor: 'as yet unclassified' stamp: 'MC 6/7/2021 19:53:42'!
nextItem

	^ nextItem.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackItem class' category: 'Stack-Exercise'!
StackItem class
	instanceVariableNames: ''!

!StackItem class methodsFor: 'as yet unclassified' stamp: 'MC 6/8/2021 00:00:23'!
with: newContent nextItem: anItem

	| stackItem |
	
	stackItem := self new.
	
	stackItem initializeWith: newContent nextItem: anItem.
	
	^ stackItem.! !
