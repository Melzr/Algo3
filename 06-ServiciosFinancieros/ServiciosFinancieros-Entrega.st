!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:18:03'!
test01BalanceOfAnEmptyPortfolioIsZero
	
	self assert: 0 equals: portfolio balance	.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:26:59'!
test02BalanceOfPortfolioWithOneAccountEqualsAccountBalance

	self addAccountWithDepositOf: 50*peso to: portfolio.
	
	self assert: 50*peso equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:29:47'!
test03BalanceOfPortfolioWithMultipleAccountsIstheSumOfItsAccountsTransactions

	self add: 3 AccountsWithDepositOf: 50*peso to: portfolio. 
	
	self assert: 150*peso equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 13:23:08'!
test04PortfolioRegistersItsAccountsTransactions

	| aTransaction |

	aTransaction := self transaction: Withdraw of: 20*peso onAccountAddedTo: portfolio.
	
	self assert: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:18:03'!
test05PortfolioDoesNotRegisterATransactionOnAccountThatIsNotInPortfolio

	| anAccount aTransaction |
	
	anAccount := ReceptiveAccount new.	
	aTransaction := Withdraw register: 20*peso on: anAccount.
	
	self deny: (portfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:49:19'!
test06PortfolioTransactionsIncludesAllOfItsAccountsTransactions

	| deposit withdrawal |
	
	deposit := self transaction: Deposit of: 20*peso onAccountAddedTo: portfolio.
	withdrawal := self transaction: Withdraw of: 20*peso onAccountAddedTo: portfolio.
	
	self assert: 2 equals: portfolio transactions size.
	self assert: portfolio transactions includes: deposit.
	self assert: portfolio transactions includes: withdrawal.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 15:35:11'!
test07PortfolioThatContainsAnotherPortfolioRegistersItsTransactionsAndBalance

	| subPortfolio aTransaction |
	
	subPortfolio := Portfolio new.
	aTransaction := self transaction: Deposit of: 50*peso onAccountAddedTo: subPortfolio.
	portfolio add: subPortfolio.
	
	self assert: 50*peso equals: portfolio balance.
	self assert: (portfolio hasRegistered: aTransaction).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 15:35:19'!
test08CannotAddAccountThatIsAlreadyInPortfolio

	| anAccount |
	
	anAccount := ReceptiveAccount new.	
	portfolio add: anAccount.
	
	self assertThat: [ portfolio add: anAccount ] throwsErrorSignalWithMessage: Portfolio accountAlreadyInPortfolioErrorMessage.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 13:29:51'!
test09CannotAddAnAccountThatIsInInferiorPortfolio

	| subPortfolio anAccount |
	
	subPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	subPortfolio add: anAccount.
	portfolio add: subPortfolio.
	
	self assertThat: [ portfolio add: anAccount ]  throwsErrorSignalWithMessage: Portfolio accountAlreadyInPortfolioErrorMessage.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 15:33:30'!
test10PortfolioCannotIncludeItself
	
	self assertThat: [ portfolio add: portfolio ] throwsErrorSignalWithMessage: Portfolio accountAlreadyInPortfolioErrorMessage.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 15:33:40'!
test11CannotAddAnAccountThatIsAlreadyInSuperiorPortfolio

	| subPortfolioA subPortfolioB |
	
	subPortfolioA := Portfolio new.
	subPortfolioB := Portfolio new.
	
	portfolio add: subPortfolioA.
	portfolio add: subPortfolioB.
	
	self assertThat: [ subPortfolioA add: subPortfolioB ] throwsErrorSignalWithMessage: Portfolio accountAlreadyInPortfolioErrorMessage.! !

!PortfolioTest methodsFor: 'tests' stamp: 'ML 7/8/2021 15:41:09'!
test12CannotAddPortfolioThatCointainsAnAccountThatAlreadyIsInSuperiorPortfolio

	| subPortfolio anAccount |
	
	subPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio add: anAccount.
	subPortfolio add: anAccount.
		
	self assertThat: [ portfolio add: subPortfolio ] throwsErrorSignalWithMessage: Portfolio accountAlreadyInPortfolioErrorMessage.! !


!PortfolioTest methodsFor: 'setup' stamp: 'ML 7/8/2021 12:18:03'!
setUp

	portfolio := Portfolio new.! !


!PortfolioTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 12:29:13'!
add: aNumber AccountsWithDepositOf: aValue to: aPortfolio 

	aNumber timesRepeat: [ self addAccountWithDepositOf: aValue to: aPortfolio ].! !

!PortfolioTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 12:26:08'!
addAccountWithDepositOf: aValue to: aPortfolio 

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	Deposit register: aValue on: anAccount.
	
	aPortfolio add: anAccount.! !

!PortfolioTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 12:52:43'!
assertThat: aBlock throwsErrorSignalWithMessage: aMessage

	[ aBlock value. self fail ]
		on: Error
		do: [ :anError | self assert: aMessage equals: anError messageText ].! !

!PortfolioTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 12:47:12'!
transaction: aTransactionType of: aValue onAccountAddedTo: aPortfolio

	| anAccount|

	anAccount := ReceptiveAccount new.
	aPortfolio add: anAccount.
	^aTransactionType register: aValue on: anAccount.	! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:01:19'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:01:52'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:01:48'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |

	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:02:04'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:02:15'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:02:28'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ML 7/8/2021 12:02:40'!
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

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:51:11'!
test01TransferDecreasesSenderBalanceAndIncreasesRecipientBalance
	
	Transference register: 50*peso from: sender to: receiver.
	
	self assertThatSenderBalanceIs: -50*peso andReceiverBalanceIs: 50*peso.! !

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:37:09'!
test02TransferKnowsItsValue
	
	| transferValue |
	
	transferValue := 50 * peso.
	
	self assert: transferValue equals: (Transference register: transferValue from: sender to: receiver) value.
! !

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:59:52'!
test03BothAccountsRegisterTransferenceCorrectly

	| transference |

	transference := Transference register: 50*peso from: sender to: receiver.
	
	self assertThatSenderAndReceiverAccountsRegisteredCorrectly: transference.! !

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:51:32'!
test04EachTransferencePartKnowsItsCounterpart

	| transference |
	
	transference := Transference register: 50*peso from: sender to: receiver.
	
	self assertThatBothPartsKnowTheirCounterpartOf: transference.! !

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:54:55'!
test05BothPartsKnowTransferenceValue

	| transference transferenceValue |

	transferenceValue := 50*peso.
	transference := Transference register: transferenceValue from: sender to: receiver.
	
	self assertThatBothPartsOf: transference haveTheSameValue: transferenceValue.! !

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:58:55'!
test06CannotTransfer0Pesos

	self assertThat: [ Transference register: 0*peso from: sender to: receiver ] 
		throwsErrorSignalWithMessage: Transference invalidTransferenceValueErrorMessage.! !

!TransferenceTest methodsFor: 'tests' stamp: 'ML 7/8/2021 11:58:23'!
test07CannotTransferNegativeValue

	self assertThat: [ Transference register: -50*peso from: sender to: receiver ] 
	 	throwsErrorSignalWithMessage: Transference invalidTransferenceValueErrorMessage.! !


!TransferenceTest methodsFor: 'setup' stamp: 'ML 7/8/2021 11:41:00'!
setUp

	receiver := ReceptiveAccount new.
	sender := ReceptiveAccount new.! !


!TransferenceTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 11:56:47'!
assertThat: aBlock throwsErrorSignalWithMessage: aMessage

	[ aBlock value. self fail ]
		on: Error
		do: [ :anError | self assert: aMessage equals: anError messageText ].! !

!TransferenceTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 11:51:01'!
assertThatBothPartsKnowTheirCounterpartOf: aTransference

	| senderPart receiverPart |

	senderPart := aTransference outgoingPart.
	receiverPart := aTransference incomingPart.
	
	self assert: receiverPart equals: senderPart counterpart.
	self assert: senderPart equals: receiverPart counterpart.! !

!TransferenceTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 11:53:59'!
assertThatBothPartsOf: aTransference haveTheSameValue: aValue
	
	| senderPart receiverPart |

	senderPart := aTransference outgoingPart.
	receiverPart := aTransference incomingPart.
	
	self assert: aValue equals: senderPart value.
	self assert: aValue equals: receiverPart value.! !

!TransferenceTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 11:47:29'!
assertThatSenderAndReceiverAccountsRegisteredCorrectly: aTransference


	self assert: (sender hasRegistered: aTransference outgoingPart).
	self assert: (receiver hasRegistered: aTransference incomingPart).! !

!TransferenceTest methodsFor: 'helpers' stamp: 'ML 7/8/2021 11:51:11'!
assertThatSenderBalanceIs: senderBalance andReceiverBalanceIs: receiverBalance

	self assert: senderBalance equals: sender balance.
	self assert: receiverBalance  equals: receiver balance.! !


!classDefinition: #AccountComponent category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountComponent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountComponent methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:09:49'!
balance

	self subclassResponsibility ! !

!AccountComponent methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:10:46'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!AccountComponent methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:12:16'!
transactions
	
	self subclassResponsibility ! !


!AccountComponent methodsFor: 'testing' stamp: 'ML 7/8/2021 11:10:15'!
contains: anAccount

	self subclassResponsibility ! !


!AccountComponent methodsFor: 'structure' stamp: 'ML 7/8/2021 16:04:50'!
accounts

	self subclassResponsibility ! !

!AccountComponent methodsFor: 'structure' stamp: 'ML 7/8/2021 11:16:08'!
setParent: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
AccountComponent subclass: #Portfolio
	instanceVariableNames: 'accounts parent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'ML 7/8/2021 16:18:02'!
initialize

	accounts := Set new.
	
	"Parent comienza en nil y se setea solo en el caso en que el portfolio es agregado a otro portfolio. De esta manera
	solo usamos isNil una vez en rootParent, lo que no nos parecio justificacion suficiente para modelarlo de una manera mas compleja"! !


!Portfolio methodsFor: 'structure - private' stamp: 'ML 7/8/2021 16:03:21'!
accounts

	| accountsWithSelf |

	accountsWithSelf := accounts copy.
	accountsWithSelf add: self.
	
	^accountsWithSelf ! !

!Portfolio methodsFor: 'structure - private' stamp: 'ML 7/8/2021 14:29:33'!
rootPortfolio

	parent ifNil: [ ^self ].
	
	^parent rootPortfolio.! !

!Portfolio methodsFor: 'structure - private' stamp: 'ML 7/8/2021 11:15:12'!
setParent: aPortfolio

	parent := aPortfolio.! !


!Portfolio methodsFor: 'testing' stamp: 'ML 7/8/2021 10:57:02'!
contains: anAccount

	^ (self = anAccount) or: [ accounts anySatisfy: [ :account | account contains: anAccount ] ].! !


!Portfolio methodsFor: 'main protocol' stamp: 'ML 7/8/2021 13:45:54'!
add: anAccount
	
	(self canAdd: anAccount) ifFalse: [ self error: Portfolio accountAlreadyInPortfolioErrorMessage ].
	
	accounts add: anAccount.
	anAccount setParent: self.! !

!Portfolio methodsFor: 'main protocol' stamp: 'ML 7/8/2021 13:44:35'!
balance

	^ accounts inject: 0*peso into: [ :currentBalance :anAccount | currentBalance + anAccount balance ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:01:21'!
hasRegistered: aTransaction

    ^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:01:46'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	
	accounts do: [ :anAccount | transactions addAll: anAccount transactions. ].
	
	^ transactions.! !


!Portfolio methodsFor: 'testing - private' stamp: 'ML 7/8/2021 16:00:57'!
canAdd: anAccount

	| initialPortfolio |
	
	initialPortfolio := self rootPortfolio.

	anAccount accounts do: [ :account | (initialPortfolio contains: account) ifTrue: [^false] ].
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'ML 7/8/2021 12:54:29'!
accountAlreadyInPortfolioErrorMessage

	^ 'Account already in portfolio'! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
AccountComponent subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ML 7/8/2021 16:05:16'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:13:38'!
balance

	^ transactions inject: 0*peso into: [ :currentBalance :aTransaction | aTransaction effectOnBalance: currentBalance ].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:13:33'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction ! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:13:26'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'ML 7/8/2021 11:13:20'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'ML 7/8/2021 11:14:36'!
contains: anAccount

	^ self = anAccount.! !


!ReceptiveAccount methodsFor: 'structure - private' stamp: 'ML 7/8/2021 15:59:02'!
accounts

	^Set with: self! !

!ReceptiveAccount methodsFor: 'structure - private' stamp: 'ML 7/8/2021 16:10:29'!
setParent: aPortfolio

	"Nos dimos cuenta que ReceptiveAccount no necesita la referencia a su padre, pero nos parecio mas
	conveniente dejar el mensaje vacio para no tener que chequear la clase con isKindOf al agregar algo al portfolio"! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'ML 7/8/2021 11:28:18'!
effectOnBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'ML 7/8/2021 11:27:48'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'ML 7/8/2021 16:26:52'!
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

!Deposit methodsFor: 'value' stamp: 'ML 7/8/2021 16:28:18'!
effectOnBalance: aBalance

	^ aBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'ML 7/8/2021 16:28:12'!
value
	
	^value! !


!Deposit methodsFor: 'initialization' stamp: 'ML 7/8/2021 16:28:47'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'ML 7/8/2021 16:25:57'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingTransference category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #IncomingTransference
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!IncomingTransference methodsFor: 'counterpart' stamp: 'ML 7/8/2021 15:20:52'!
counterpart

	^ transference outgoingPart.! !


!IncomingTransference methodsFor: 'value' stamp: 'ML 7/8/2021 16:34:05'!
effectOnBalance: aBalance

	^ aBalance + self value.! !

!IncomingTransference methodsFor: 'value' stamp: 'ML 7/8/2021 16:34:10'!
value

	^transference value! !


!IncomingTransference methodsFor: 'initialization' stamp: 'ML 7/8/2021 16:30:33'!
initializeFor: aTransference

	transference := aTransference.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransference class' category: 'ServiciosFinancieros-Ejercicio'!
IncomingTransference class
	instanceVariableNames: ''!

!IncomingTransference class methodsFor: 'instance creation' stamp: 'ML 7/8/2021 16:31:46'!
of: aTransference 
	
	^ self new initializeFor: aTransference.! !


!classDefinition: #OutgoingTransference category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #OutgoingTransference
	instanceVariableNames: 'transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!OutgoingTransference methodsFor: 'value' stamp: 'ML 7/8/2021 16:33:59'!
effectOnBalance: aBalance

	^ aBalance - self value.! !

!OutgoingTransference methodsFor: 'value' stamp: 'ML 7/8/2021 16:33:52'!
value

	^transference value! !


!OutgoingTransference methodsFor: 'counterpart' stamp: 'ML 7/8/2021 15:20:52'!
counterpart

	^ transference incomingPart.! !


!OutgoingTransference methodsFor: 'initialization' stamp: 'ML 7/8/2021 16:30:41'!
initializeFor: aTransference

	transference := aTransference.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransference class' category: 'ServiciosFinancieros-Ejercicio'!
OutgoingTransference class
	instanceVariableNames: ''!

!OutgoingTransference class methodsFor: 'instance creation' stamp: 'ML 7/8/2021 16:31:56'!
of: aTransference 
	
	^ self new initializeFor: aTransference.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'value' stamp: 'ML 7/8/2021 16:28:23'!
effectOnBalance: aBalance

	^ aBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'ML 7/8/2021 16:28:04'!
value
	
	^value! !


!Withdraw methodsFor: 'initialization' stamp: 'ML 7/8/2021 16:28:53'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'ML 7/8/2021 16:26:14'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transference category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transference
	instanceVariableNames: 'value incomingPart outgoingPart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transference methodsFor: 'initialization' stamp: 'ML 7/8/2021 15:15:15'!
initializeFor: aValue 
	
	value := aValue.
	incomingPart := IncomingTransference of: self.
	outgoingPart := OutgoingTransference of: self.! !


!Transference methodsFor: 'value' stamp: 'ML 7/8/2021 11:33:37'!
value

	^ value.! !


!Transference methodsFor: 'accessing' stamp: 'ML 7/8/2021 15:14:39'!
incomingPart

	^incomingPart.! !

!Transference methodsFor: 'accessing' stamp: 'ML 7/8/2021 15:14:47'!
outgoingPart

	^outgoingPart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: 'ServiciosFinancieros-Ejercicio'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'error messages' stamp: 'ML 7/8/2021 11:32:06'!
invalidTransferenceValueErrorMessage

	^ 'Transfer value cannot be 0 or negative'.! !


!Transference class methodsFor: 'instance creation' stamp: 'ML 7/8/2021 14:43:12'!
register: aValue from: aSender to: aReceiver 
	
	| transference |
	
	(aValue <= 0) ifTrue: [ self error: self invalidTransferenceValueErrorMessage ].
	transference := self new initializeFor: aValue.
	
	aSender register: transference outgoingPart.
	aReceiver register: transference incomingPart.
	
	^ transference.
	! !
