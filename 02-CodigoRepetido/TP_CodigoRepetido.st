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

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:26:37'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	
	| operationTime 		customerBook | 
	
	customerBook := CustomerBook new.
	
	operationTime := self operationTimeInMilliseconds: [ customerBook addCustomerNamed: 'John Lennon'. ].
	
	self assert: (operationTime) < (50 * millisecond).! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:25:52'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	
	| operationTime customerBook | 
	
	customerBook := CustomerBook new. 
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	operationTime := self operationTimeInMilliseconds: [ customerBook removeCustomerNamed: 'Paul McCartney'. ].
	
	self assert: (operationTime) < (100 * millisecond).	
	
	
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 20:00:45'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
	
	customerBook := CustomerBook new.
	
	[ customerBook addCustomerNamed: ''. self fail ] 
		on: Error 
		do: [ :anError | 
			
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:30:55'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook johnLennon |
	
	customerBook := CustomerBook new.
	
	johnLennon := 'John Lennon'.
	
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.	 self fail ]

		on: NotFound 
		
		do: [ :anError | 
			
			self assert: customerBook numberOfCustomers = 1.
			
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
		
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:54:48'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self customerBookWithSuspendedCustomer: 'Paul McCartney'.	
	
	self testNumberOfCustomers: customerBook active: 0 suspended: 1 total: 1.
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:55:15'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self customerBookWithSuspendedCustomer: 'Paul McCartney'.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self testNumberOfCustomers: customerBook active: 0 suspended: 0 total: 0.
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').
	! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:57:32'!
test07CanNotSuspendAnInvalidCustomer


	| customerBook johnLennon |
	
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	[ customerBook suspendCustomerNamed: 'Ringo Starr'. 
	self fail ]
		
		on: CantSuspend 
		
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'tests' stamp: 'MC 5/16/2021 19:57:08'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.  self fail ]
	
		on: CantSuspend 
		
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'MC 5/16/2021 19:43:45'!
customerBookWithSuspendedCustomer: name

	| customerBook |

	customerBook := CustomerBook new.
	customerBook addCustomerNamed: name.
	customerBook suspendCustomerNamed: name.
	^customerBook.
		! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'MC 5/16/2021 19:19:44'!
operationTimeInMilliseconds: closure

	^closure timeToRun * millisecond.
	
! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'MC 5/16/2021 19:54:03'!
testNumberOfCustomers: customerBook active: activeCustomers  suspended: suspendedCustomers total: totalCustomers

	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'MC 5/16/2021 19:41:08'!
unLugar

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'initialization' stamp: 'MC 5/16/2021 18:13:25'!
initialize


	active := OrderedCollection new.
	
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'accessing' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !


!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signal errors' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
