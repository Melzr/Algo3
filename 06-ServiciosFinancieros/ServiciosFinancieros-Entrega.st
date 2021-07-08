!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 22:55:59'!
test01BalanceOfAnEmptyPortfolioIs0
	
	self assert: 0 equals: Portfolio new balance	.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:07:32'!
test02BalanceOfPortfolioWithOneAccountEqualsAccountBalance

	| portfolio anAccount |
	
	anAccount := ReceptiveAccount new.
	portfolio := Portfolio new.
	
	portfolio add: anAccount.
	Deposit register: 50*peso on: anAccount.
	
	self assert: 50*peso equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:18:54'!
test03BalanceOfPortfolioWithMultipleAccountsIstheSumOfItsAccountsTransactions

	| portfolio anAccount |
	
	portfolio := Portfolio new.
	
	3 timesRepeat: [
		anAccount := ReceptiveAccount new.	
		portfolio add: anAccount.
		Deposit register: 50*peso on: anAccount.
				].
	
	self assert: 150*peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:34:26'!
test04PortfolioRegistersItsAccountsTransactions

	| portfolio anAccount aTransaction |
	
	portfolio := Portfolio new.
	
	3 timesRepeat: [
		anAccount := ReceptiveAccount new.	
		portfolio add: anAccount.
		Deposit register: 50*peso on: anAccount.
				].
	
	aTransaction := Withdraw register: 20*peso on: anAccount.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:38:43'!
test05PortfolioDoesNotRegisterATransactionOnAccountThatIsNotInPortfolio

	| portfolio anAccount aTransaction |
	
	portfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.	
	aTransaction := Withdraw register: 20*peso on: anAccount.
	
	self deny: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 00:14:23'!
test06PortfolioKnowsAllItsAccountsTransactions

	| portfolio anAccount deposit withdrawal |
	
	portfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.	
	portfolio add: anAccount.
	deposit := Deposit register: 50*peso on: anAccount.
	
	anAccount := ReceptiveAccount new.
	portfolio add: anAccount.
	withdrawal := Withdraw register: 20*peso on: anAccount.	
	
	self assert: 2 equals: portfolio transactions size.
	self assert: portfolio transactions includes: deposit.
	self assert: portfolio transactions includes: withdrawal.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:48:49'!
test07CannotAddAccountThatIsAlreadyInPortfolio

	| portfolio anAccount |
	
	portfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.	
	portfolio add: anAccount.
	
	[ portfolio add: anAccount. self fail. ] 
		on: Error 
		do: [ :anError | self assert: anError messageText = Portfolio accountAlreadyInPortfolioErrorMessage ].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:58:44'!
test08

	| portfolioA portfolioB anAccount aTransaction |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	aTransaction := Deposit register: 50*peso on: anAccount.
	portfolioB add: anAccount.
	
	portfolioA add: portfolioB.
	
	self assert: 50*peso equals: portfolioA balance.
	self assert: (portfolioA hasRegistered: aTransaction).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:03:19'!
test09

	| portfolioA portfolioB anAccount |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	portfolioB add: anAccount.
	portfolioA add: portfolioB.
	
	[portfolioA add: anAccount. self fail.] 
		on: Error 
		do: [ :anError | self assert: anError messageText = Portfolio accountAlreadyInPortfolioErrorMessage ].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:21:17'!
test10

	| portfolioA portfolioB |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	portfolioA add: portfolioB.
	
	[portfolioA add: portfolioB. self fail.] 
		on: Error 
		do: [ :anError | self assert: anError messageText = Portfolio accountAlreadyInPortfolioErrorMessage ].! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:33:04'!
test11

	| portfolioA portfolioB anAccount aTransaction |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	portfolioA add: portfolioB.
	anAccount := ReceptiveAccount new.
	aTransaction := Withdraw register: 5*peso on: anAccount.
	portfolioB add: anAccount.
	
	self assert: (portfolioA transactions includes: aTransaction).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:35:51'!
test12

	| portfolioA portfolioB |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	
	portfolioA add: portfolioB.
	
	[ portfolioB add: portfolioA. self fail. ]
		on: Error
		do: [ :anError | self assert: anError messageText = Portfolio accountAlreadyInPortfolioErrorMessage ].! !


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

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MC 7/7/2021 20:23:41'!
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


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 22:23:19'!
add: anAccount
	
	(self containsOrAnyParentContains: anAccount) ifTrue: [ self error: Portfolio accountAlreadyInPortfolioErrorMessage ].
	
	accounts add: anAccount.
	anAccount parent: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:17:14'!
balance

	accounts ifEmpty: [ ^0 ].
	^ accounts inject: 0*peso into: [ :currentBalance :anAccount | currentBalance + anAccount balance ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 22:02:56'!
contains: anAccount

	^ (self = anAccount) or: [ accounts anySatisfy: [ :account | account contains: anAccount ] ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 22:23:19'!
containsOrAnyParentContains: anAccount
	
	parent ifNil: [ ^ self contains: anAccount ].
	
	^ parent containsOrAnyParentContains: anAccount.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:37:22'!
hasRegistered: aTransaction

    ^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:13:08'!
initialize

	accounts := Set new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:44:58'!
parent: aPortfolio

	parent := aPortfolio.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 23:56:30'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	
	accounts do: [ :anAccount | transactions addAll: anAccount transactions. ].
	
	^ transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:47:34'!
accountAlreadyInPortfolioErrorMessage

	^ 'Account already in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MC 7/6/2021 23:40:46'!
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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:12:44'!
contains: anAccount

	^ self = anAccount.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 21:46:09'!
parent: aPortfolio! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value outgoingPart incomingPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 16:07:20'!
incomingPart

	^ incomingPart.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:29:16'!
initializeFor: aValue from: aSender to: aReceiver
	
	value := aValue.
	outgoingPart := OutgoingTransference of: self.
	incomingPart := IncomingTransference of: self.! !

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

!TransferencePart class methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:27:33'!
of: aTransference 
	
	^ self new initializeFor: aTransference.! !


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

!IncomingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:27:10'!
initializeFor: aTransference .

	transference := aTransference.! !

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

!OutgoingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/7/2021 20:27:00'!
initializeFor: aTransference .

	transference := aTransference.! !

!OutgoingTransference methodsFor: 'as yet unclassified' stamp: 'MC 7/6/2021 17:12:53'!
value

	^ transference value.! !
