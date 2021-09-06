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
	instanceVariableNames: 'stack finder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/8/2021 23:16:18'!
test01CannotFindStringByEmptyPrefix

	| findingStringByEmptyPrefix errorIsThatPrefixCannotBeEmpty|
	
	findingStringByEmptyPrefix := [ finder find: '' in: stack. ].	

	errorIsThatPrefixCannotBeEmpty := [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixIsEmptyErrorDescription. ].
	
	self testThat: findingStringByEmptyPrefix throwsSignal: Error andInThatCaseTestThat: errorIsThatPrefixCannotBeEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/8/2021 23:18:53'!
test02PrefixCannotContainMoreThanOneWord

	| findingStringByMultiwordPrefix errorIsThatPrefixExceedesOneWord |
	
	findingStringByMultiwordPrefix := [ finder find: 'la filita' in: stack. ].	

	errorIsThatPrefixExceedesOneWord := [ :anError | 
		self assert: anError messageText = SentenceFinderByPrefix prefixCannotContainMoreThanOneWordErrorDescription. ].
	
	self testThat: findingStringByMultiwordPrefix throwsSignal: Error andInThatCaseTestThat: errorIsThatPrefixExceedesOneWord.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/8/2021 23:23:14'!
test03StackCannotBeEmpty

	| findingStringInEmptyStack errorIsThatStackIsEmpty |
	
	findingStringInEmptyStack := [ finder find: 'A' in: stack. ].	

	errorIsThatStackIsEmpty := [ :anError | 
		self assert: anError messageText = OOStack stackEmptyErrorDescription. ].
	
	self testThat: findingStringInEmptyStack throwsSignal: Error andInThatCaseTestThat: errorIsThatStackIsEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/10/2021 16:20:15'!
test04CanFindOneMatch
	
	| matches elements prefix |
	
	prefix := 'the'.
	elements := #('winter is coming' 'winning is everything' 'the winds of winter' 'winter is here').
	self pushElementsFrom: elements to: stack.
	
	matches := finder find: prefix in: stack.
	
	self testThatThereAre: 1 elementsIn: matches andAllStartWith: prefix.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/10/2021 15:45:00'!
test05CanFindMultipleMatches
	
	| matches elements prefix |
	
	prefix := 'wint'.
	elements := #('winter is coming' 'winning is everything' 'the winds of winter' 'winter is here').
	self pushElementsFrom: elements to: stack.
	
	matches := finder find: prefix in: stack.
	
	self testThatThereAre: 2 elementsIn: matches andAllStartWith: prefix.

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/10/2021 15:44:18'!
test06MatchIsCaseSensitive
	
	| matches elements prefix |
	
	prefix := 'Wint'.
	elements := #('winter is coming' 'winning is everything' 'The winds of Winter' 'Winter is here').
	self pushElementsFrom: elements to: stack.
	
	matches := finder find: prefix in: stack.
	
	self testThatThereAre: 1 elementsIn: matches andAllStartWith: prefix.

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/8/2021 23:58:04'!
test07CannotFindMatches
	
	| matches elements |
	elements := #('winter is coming' 'winning is everything' 'the winds of winter' 'winter is here').
	self pushElementsFrom: elements to: stack.
	
	matches := finder find: 'a' in: stack.
	
	self assert: (matches isEmpty).

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/9/2021 00:21:03'!
test08StackRemainsUntouched
	
	| elements auxStack |
	
	elements := #('winter is coming' 'winning is everything' 'the winds of winter' 'winter is here').
	self pushElementsFrom: elements to: stack.
	
	auxStack := stack copy.
	finder find: 'wint' in: stack.
	
	self verifyThat: stack hasTheSameElementsAs: auxStack.
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/10/2021 15:42:22'!
test09AllElementsInStackMatch
	
	| matches elements prefix |
	
	prefix := 'winter'.
	elements := #('winter is coming' 'winter is everything' 'winter is not here' 'winter is here' 'winter, i love it' 'winter.').
	self pushElementsFrom: elements to: stack.
	
	matches := finder find: prefix in: stack.
	
	self testThatThereAre: (stack size) elementsIn: matches andAllStartWith: prefix.

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/10/2021 15:40:57'!
test10CanFindElementThatOnlyContainsPrefix
	
	| matches elements prefix |
	
	prefix := 'winter'.
	elements := #('asasdas' 'sadads' 'A' 'winter').
	self pushElementsFrom: elements to: stack.
	
	matches := finder find: prefix in: stack.
	
	self testThatThereAre: 1 elementsIn: matches andAllStartWith: prefix.

	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'MC 6/10/2021 16:16:18'!
test11MatchFoundContainsTheEntireSentenceAndNotJustThePrefix
	
	| matches prefix expectedMatch |
	
	prefix := 'wint'.
	expectedMatch := 'winter is coming'.
	
	stack push: expectedMatch.
	matches := finder find: prefix in: stack.
	
	self assert: ((matches at: 1) = expectedMatch).! !


!SentenceFinderByPrefixTest methodsFor: 'helpers' stamp: 'MC 6/8/2021 23:49:46'!
pushElementsFrom: anArray to: aStack

	anArray do: [ :anElement | aStack push: anElement ].! !

!SentenceFinderByPrefixTest methodsFor: 'helpers' stamp: 'MC 6/8/2021 22:53:15'!
testThat: aClosure throwsSignal: anException andInThatCaseTestThat: anotherClosure  

	[aClosure value. self fail.]
		on: anException
		do: anotherClosure.! !

!SentenceFinderByPrefixTest methodsFor: 'helpers' stamp: 'MC 6/10/2021 15:43:36'!
testThatThereAre: aNumber elementsIn: aCollection andAllStartWith: aPrefix.

	self assert: (aCollection size = aNumber).
	self assert: ((aCollection count: [ :aMatch | aMatch beginsWith: aPrefix]) = aNumber).! !

!SentenceFinderByPrefixTest methodsFor: 'helpers' stamp: 'MC 6/9/2021 00:20:31'!
verifyThat: aStack hasTheSameElementsAs: anotherStack

	self assert: (aStack size = anotherStack size).
	aStack size timesRepeat: [ self assert: (aStack pop = anotherStack pop) ].

	! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'MC 6/8/2021 23:09:05'!
setUp
	
	stack := OOStack new.
	finder := SentenceFinderByPrefix new.! !


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

!OOStack methodsFor: 'stack operations' stamp: 'MC 6/9/2021 00:11:11'!
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

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'MC 6/8/2021 23:06:17'!
verifyPrefix: aPrefix andStack: aStack

	(aPrefix = ''	) ifTrue: [ self error: SentenceFinderByPrefix prefixIsEmptyErrorDescription ].	
	
	(aPrefix findString: ' ') > 0 ifTrue: [ self error: SentenceFinderByPrefix prefixCannotContainMoreThanOneWordErrorDescription ].
	
	aStack isEmpty ifTrue: [ self error: OOStack stackEmptyErrorDescription ].! !


!SentenceFinderByPrefix methodsFor: 'sentence finder' stamp: 'MC 6/9/2021 00:15:40'!
find: aPrefix in: aStack

	| auxStack coincidences |
	
	self verifyPrefix: aPrefix andStack: aStack.
	
	auxStack := aStack copy.
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
