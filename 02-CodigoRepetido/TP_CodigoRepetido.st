!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 23:09:09'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	| customerBook addingACustomer | 
	
	customerBook := CustomerBook new.
	addingACustomer := [ customerBook addCustomerNamed: 'John Lennon'. ].
	 
	self operationTimeOf: addingACustomer isShorterThan: (50 * millisecond).! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 23:10:53'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| customerBook removingACustomer | 
	
	customerBook := self customerBookWithCustomer: 'Paul McCartney'.
	removingACustomer := [ customerBook removeCustomerNamed: 'Paul McCartney'. ].
	
	self operationTimeOf: removingACustomer isShorterThan: (100 * millisecond).
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 23:14:32'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook addingCustomerWithEmpyName errorIsThatCustomerCanNotBeEmpty |
	
	customerBook := CustomerBook new.
	
	addingCustomerWithEmpyName := [ customerBook addCustomerNamed: ''. self fail ].
	errorIsThatCustomerCanNotBeEmpty := [ :anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. ].
		
	self testThat: addingCustomerWithEmpyName throwsSignal: Error andInThatCaseTestThat: errorIsThatCustomerCanNotBeEmpty.
	self assert: customerBook isEmpty.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 22:58:36'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook removingCustomerThatDoesntExist thereIsOnlyOneCustomer|
	
	customerBook := self customerBookWithCustomer: 'John Lennon'.
	
	removingCustomerThatDoesntExist := [ customerBook removeCustomerNamed: 'Paul McCartney'.	 self fail ].
	thereIsOnlyOneCustomer := [self testThat: customerBook hasASingleCustomerWhichIs: 'John Lennon' ].
	
	self testThat: removingCustomerThatDoesntExist throwsSignal: NotFound andInThatCaseTestThat: thereIsOnlyOneCustomer.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/17/2021 23:33:02'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self customerBookWithSuspendedCustomer: 'Paul McCartney'.	
	
	self testNumberOfCustomersFrom: customerBook active: 0 suspended: 1 total: 1.
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/17/2021 23:32:07'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self customerBookWithSuspendedCustomer: 'Paul McCartney'.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self testNumberOfCustomersFrom: customerBook active: 0 suspended: 0 total: 0.
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 22:58:42'!
test07CanNotSuspendAnInvalidCustomer

	| customerBook suspendingInvalidCustomer thereIsOnlyOneCustomer|
	
	customerBook := self customerBookWithCustomer: 'John Lennon'.
	
	suspendingInvalidCustomer := [ customerBook suspendCustomerNamed:  'Ringo Starr'. self fail ].
	thereIsOnlyOneCustomer := [self testThat: customerBook hasASingleCustomerWhichIs: 'John Lennon'].
	
	self testThat: suspendingInvalidCustomer throwsSignal: CantSuspend andInThatCaseTestThat: thereIsOnlyOneCustomer.  
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 22:58:47'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	| customerBook suspendingSuspendedCustomer thereIsOnlyOneCustomer |
			
	customerBook := self customerBookWithSuspendedCustomer: 'John Lennon'.
	
	suspendingSuspendedCustomer := [ customerBook suspendCustomerNamed: 'John Lennon'.  self fail ].
	thereIsOnlyOneCustomer := [self testThat: customerBook hasASingleCustomerWhichIs: 'John Lennon' ].
		
	self testThat: suspendingSuspendedCustomer throwsSignal: CantSuspend andInThatCaseTestThat: thereIsOnlyOneCustomer.
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'ML 5/18/2021 21:57:16'!
customerBookWithCustomer: aName

	| customerBook |

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aName.
	^customerBook! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'ML 5/18/2021 21:57:34'!
customerBookWithSuspendedCustomer: aName

	| customerBook |

	customerBook := self customerBookWithCustomer: aName.
	customerBook suspendCustomerNamed: aName.
	^customerBook
		! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'ML 5/18/2021 23:03:59'!
operationTimeOf: aClosure isShorterThan: timeInMilliseconds

	|operationTime|

	operationTime := (aClosure timeToRun) * millisecond.
	
	self assert: operationTime < timeInMilliseconds.
	
! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'ML 5/18/2021 00:20:18'!
testNumberOfCustomersFrom: aCustomerBook active: activeCustomers  suspended: suspendedCustomers total: totalCustomers

	self assert: activeCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'ML 5/18/2021 00:28:29'!
testThat: aCustomerBook hasASingleCustomerWhichIs: customerName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: customerName).

! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'ML 5/18/2021 22:59:34'!
testThat: aClosure throwsSignal: anException andInThatCaseTestThat: anotherClosure  

	aClosure
		on: anException
		do: anotherClosure.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'ML 5/18/2021 00:40:59'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'ML 5/18/2021 00:58:09'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'ML 5/18/2021 00:53:23'!
removeCustomerNamed: aName 

	(self removeCustomerNamed: aName from: active) = aName
		ifTrue: [ ^aName ].

	(self removeCustomerNamed: aName from: suspended) = aName
		ifTrue: [ ^aName ].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'ML 5/18/2021 23:27:43'!
removeCustomerNamed: aName from: aCollection

	aCollection remove: aName ifAbsent: [^NotFound].
	
	^aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'ML 5/18/2021 01:00:12'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	active remove: aName.
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'ML 5/18/2021 00:54:16'!
numberOfActiveCustomers

	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'ML 5/18/2021 00:55:26'!
numberOfCustomers

	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'accessing' stamp: 'ML 5/18/2021 00:54:30'!
numberOfSuspendedCustomers

	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'ML 5/18/2021 00:55:55'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'ML 5/18/2021 00:56:02'!
isEmpty

	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'ML 5/18/2021 00:56:28'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'ML 5/18/2021 01:04:17'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'ML 5/18/2021 01:05:03'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'ML 5/18/2021 01:04:54'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
