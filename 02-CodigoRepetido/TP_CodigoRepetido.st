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

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 01:09:51'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	| operationTime 		customerBook | 
	
	customerBook := CustomerBook new.
	operationTime := self operationTimeInMilliseconds: [ customerBook addCustomerNamed: 'John Lennon'. ].
	
	self assert: (operationTime) < (50 * millisecond).! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 00:08:03'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	
	| operationTime customerBook | 
	
	customerBook := self customerBookWithCustomer: 'Paul McCartney'.
	operationTime := self operationTimeInMilliseconds: [ customerBook removeCustomerNamed: 'Paul McCartney'. ].
	
	self assert: (operationTime) < (100 * millisecond).	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 00:37:29'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook assertion |
	
	customerBook := CustomerBook new.
	assertion := [ :anError |
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].
		
	self testThat: [ customerBook addCustomerNamed: ''. self fail ] catches: Error andChecks: assertion.! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 00:31:31'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook assertion|
	
	customerBook := self customerBookWithCustomer: 'John Lennon'.
	assertion := [self testThat: customerBook hasASingleCustomerWhichIs: 'John Lennon' ].
	
	self testThat: [ customerBook removeCustomerNamed: 'Paul McCartney'.	 self fail ] catches: NotFound andChecks: assertion.! !

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

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 00:29:01'!
test07CanNotSuspendAnInvalidCustomer

	| customerBook assertion |
	
	customerBook := self customerBookWithCustomer: 'John Lennon'.
	assertion := [self testThat: customerBook hasASingleCustomerWhichIs: 'John Lennon'].
	
	self testThat: [ customerBook suspendCustomerNamed: 'Ringo Starr'. self fail ] catches: CantSuspend andChecks: assertion.  

! !

!CustomerBookTest methodsFor: 'tests' stamp: 'ML 5/18/2021 00:28:08'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	| customerBook assertion |
			
	customerBook := self customerBookWithSuspendedCustomer: 'John Lennon'.
	assertion := [self testThat: customerBook hasASingleCustomerWhichIs: 'John Lennon' ].
		
	self testThat: [ customerBook suspendCustomerNamed: 'John Lennon'.  self fail ] catches: CantSuspend andChecks: assertion. 
! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'ML 5/18/2021 00:06:36'!
customerBookWithCustomer: name

	| customerBook |

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: name.
	^customerBook. ! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'ML 5/18/2021 00:07:27'!
customerBookWithSuspendedCustomer: name

	| customerBook |

	customerBook := self customerBookWithCustomer: name.
	customerBook suspendCustomerNamed: name.
	^customerBook.
		! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'MC 5/16/2021 19:19:44'!
operationTimeInMilliseconds: aClosure

	^aClosure timeToRun * millisecond.
	
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'ML 5/18/2021 00:20:18'!
testNumberOfCustomersFrom: aCustomerBook active: activeCustomers  suspended: suspendedCustomers total: totalCustomers

	self assert: activeCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'ML 5/17/2021 23:47:13'!
testThat: aClosure catches: anException andChecks: anAssertion  

	aClosure
		on: anException
		do: anAssertion.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'ML 5/18/2021 00:28:29'!
testThat: aCustomerBook hasASingleCustomerWhichIs: customerName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: customerName).

! !


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

!CustomerBook methodsFor: 'customer management' stamp: 'ML 5/18/2021 00:48:17'!
removeCustomerNamed: aName from: aCollection

	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aName 
			] 
	].

	^NotFound! !

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
