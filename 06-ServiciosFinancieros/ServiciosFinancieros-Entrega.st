!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferenceTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferenceTest
	instanceVariableNames: 'receiver sender'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:46:34'!
test01TransferDecreasesSenderBalanceAndIncreasesRecipientBalance
	
	Deposit register: 50*peso on: sender.
	Transference register: 50*peso from: sender to: receiver.
	
	self assert: 0*peso equals: sender balance.
	self assert: 50*peso equals: receiver balance.! !

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:45:41'!
test02TransferKnowsItsValue

	| transferValue |
	
	transferValue := 50 * peso.
	
	self assert: transferValue equals: (Transference register: transferValue from: sender to: receiver) value.
! !

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:45:41'!
test03BothAccountsRegisterTransference

	| transference senderPart receiverPart |

	transference := Transference register: 50*peso from: sender to: receiver.
	
	senderPart := transference outgoingPart.
	receiverPart := transference incomingPart.
	
	self assert: (sender hasRegistered: senderPart).
	self assert: (receiver hasRegistered: receiverPart).! !

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:45:40'!
test04EachTransferencePartKnowsItsCounterpart

	| transference senderPart receiverPart |
	
	transference := Transference register: 50*peso from: sender to: receiver.
	
	senderPart := transference outgoingPart.
	receiverPart := transference incomingPart.
	
	self assert: receiverPart equals: senderPart counterpart.
	self assert: senderPart equals: receiverPart counterpart.! !

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:45:41'!
test05BothPartsKnowTransferenceValue

	| transference senderPart receiverPart transferenceValue |

	transferenceValue := 50*peso.
	transference := Transference register: transferenceValue from: sender to: receiver.
	
	senderPart := transference outgoingPart.
	receiverPart := transference incomingPart.
	
	self assert: transferenceValue equals: senderPart value.
	self assert: transferenceValue equals: receiverPart value.! !

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:45:40'!
test06CannotTransfer0Pesos
	
	[ Transference register: 0*peso from: sender to: receiver. self fail. ] 
		on: Error 
		do: [ :anError | self assert: Transference invalidTransferenceValueErrorMessage equals: anError messageText. ].! !

!TransferenceTest methodsFor: 'testing' stamp: 'MC 7/6/2021 17:45:40'!
test07CannotTransferNegativeValue
	
	[ Transference register: -50*peso from: sender to: receiver. self fail. ] 
		on: Error 
		do: [ :anError | self assert: Transference invalidTransferenceValueErrorMessage equals: anError messageText. ].! !


!TransferenceTest methodsFor: 'setup' stamp: 'MC 7/6/2021 17:45:41'!
setUp

	receiver := ReceptiveAccount new.
	sender := ReceptiveAccount new.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 14:53:25'!
effectOnBalance: aBalance

	^ aBalance + self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 14:53:33'!
effectOnBalance: aBalance

	^ aBalance - self value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MC 7/6/2021 14:54:54'!
balance

	^ transactions inject: 0*peso into: [ :currentBalance :aTransaction | aTransaction effectOnBalance: currentBalance ].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MC 7/6/2021 17:33:07'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction ! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MC 7/6/2021 17:33:13'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MC 7/6/2021 17:33:19'!
transactions 

	^ transactions copy! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value outgoingPart incomingPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 16:07:20'!
incomingPart

	^ incomingPart.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:01:58'!
initializeFor: aValue from: aSender to: aReceiver
	
	value := aValue.
	outgoingPart := OutgoingTransference of: self on: aSender.
	incomingPart := IncomingTransference of: self on: aReceiver.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 16:07:35'!
outgoingPart

	^ outgoingPart.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 15:14:04'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:28:05'!
invalidTransferenceValueErrorMessage

	^ 'Transfer value cannot be 0 or negative'.! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:30:11'!
register: aValue from: aSender to: aReceiver 
	
	| transference |
	
	(aValue <= 0) ifTrue: [ self error: self invalidTransferenceValueErrorMessage ].
	transference := self new initializeFor: aValue from: aSender to: aReceiver.
	
	aSender register: transference outgoingPart.
	aReceiver register: transference incomingPart.
	
	^ transference.
	! !


!classDefinition: #TransferencePart category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferencePart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferencePart methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:10:14'!
counterpart

	self subclassResponsibility.! !

!TransferencePart methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:08:36'!
effectOnBalance: aBalance

	self subclassResponsibility.! !

!TransferencePart methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 16:40:39'!
value

	self subclassResponsibility.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferencePart class' category: 'ServiciosFinancieros-Ejercicio'!
TransferencePart class
	instanceVariableNames: ''!

!TransferencePart class methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:04:50'!
of: aTransference on: anAccount
	
	^ self new initializeFor: aTransference on: anAccount.! !


!classDefinition: #IncomingTransference category: 'ServiciosFinancieros-Ejercicio'!
TransferencePart subclass: #IncomingTransference
	instanceVariableNames: 'transference account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!IncomingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:09'!
counterpart

	^ transference outgoingPart.! !

!IncomingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:09'!
effectOnBalance: aBalance

	^ aBalance + transference value.! !

!IncomingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:09'!
initializeFor: aTransference on: anAccount.

	transference := aTransference.
	account := anAccount.! !

!IncomingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:09'!
value

	^ transference value.! !


!classDefinition: #OutgoingTransference category: 'ServiciosFinancieros-Ejercicio'!
TransferencePart subclass: #OutgoingTransference
	instanceVariableNames: 'transference account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutgoingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:54'!
counterpart

	^ transference incomingPart.! !

!OutgoingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:53'!
effectOnBalance: aBalance

	^ aBalance - transference value.! !

!OutgoingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:53'!
initializeFor: aTransference on: anAccount.

	transference := aTransference.
	account := anAccount.! !

!OutgoingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:53'!
value

	^ transference value.! !
