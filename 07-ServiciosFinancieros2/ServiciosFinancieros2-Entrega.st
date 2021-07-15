!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'account summary tests' stamp: 'MC 7/12/2021 21:00:54'!
test01SummaryOfANewAccountOnlyHasBalance

	| anAccount aSummary |
	
	anAccount := ReceptiveAccount new.
	aSummary := anAccount summary.
	
	self assert: aSummary size = 1.
	self assert: aSummary includes: 'Balance = 0 pesos'.! !

!ReportTest methodsFor: 'account summary tests' stamp: 'MC 7/12/2021 21:25:19'!
test02SummaryOfAccountWithOneDeposit

	| anAccount aSummary expectedSummary |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50*peso on: anAccount.
	aSummary := anAccount summary.
	
	expectedSummary := OrderedCollection with: 'Depósito por 50 pesos' with: 'Balance = 50 pesos'.
	
	self assert: (expectedSummary = aSummary).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'MC 7/12/2021 21:25:27'!
test03SummaryOfAccountWithOneWithdrawal

	| anAccount aSummary expectedSummary |
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 50*peso on: anAccount.
	aSummary := anAccount summary.
	
	expectedSummary := OrderedCollection with: 'Extracción por 50 pesos' with: 'Balance = -50 pesos'.
	
	self assert: (expectedSummary = aSummary).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'MC 7/12/2021 21:25:54'!
test04SummaryOfAccountWithOneTransference

	| originAccount destinationAccount originSummary destinationSummary expectedOriginSummary expectedDestinationSummary |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.

	Transfer amount: 50*peso from: originAccount to: destinationAccount.
	originSummary := originAccount summary.
	destinationSummary := destinationAccount summary.
	
	expectedOriginSummary := OrderedCollection with: 'Salida por transferencia de 50 pesos' with: 'Balance = -50 pesos'.
	expectedDestinationSummary := OrderedCollection with: 'Entrada por transferencia de 50 pesos' with: 'Balance = 50 pesos'.

	self assert: (expectedOriginSummary = originSummary).
	self assert: (expectedDestinationSummary = destinationSummary).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'MC 7/14/2021 15:49:22'!
test05SummaryOfAPortfolioWithReceptiveAccounts

	| accountA accountB aSummary expectedSummary aPortfolio |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	aPortfolio := Portfolio with: accountA with: accountB.
	
	Deposit register: 100*peso on: accountA.
	Withdraw register: 25*peso on: accountB.
	Transfer amount: 50*peso from: accountA to: accountB.
	
	aSummary := aPortfolio summary.
	
	expectedSummary := OrderedCollection with: 'Depósito por 100 pesos' with: 'Salida por transferencia de 50 pesos' with: 'Extracción por 25 pesos' with: 'Entrada por transferencia de 50 pesos' with: 'Balance = 75 pesos'.
	
	self assert: (expectedSummary = aSummary).! !

!ReportTest methodsFor: 'account summary tests' stamp: 'MC 7/14/2021 15:50:08'!
test06SummaryOfAPortfolioThatContainsPortfolio

	| accountA accountB aSummary expectedSummary portfolioA portfolioB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	portfolioB := Portfolio with: accountB.
	portfolioA := Portfolio with: accountA with: portfolioB.
	
	Deposit register: 100*peso on: accountA.
	Withdraw register: 25*peso on: accountB.
	Transfer amount: 50*peso from: accountA to: accountB.
	
	aSummary := portfolioA summary.
	
	expectedSummary := OrderedCollection with: 'Depósito por 100 pesos' with: 'Salida por transferencia de 50 pesos' with: 'Extracción por 25 pesos' with: 'Entrada por transferencia de 50 pesos' with: 'Balance = 75 pesos'.
	
	self assert: (expectedSummary = aSummary).! !


!ReportTest methodsFor: 'transfer net tests' stamp: 'MC 7/14/2021 16:03:44'!
test07TransferNetOfANewAccountOnlyHasZeroTransferBalance

	| accountA aTransferNet expectedTransferNet |
	
	accountA := ReceptiveAccount new.
	aTransferNet := accountA transferNet.
	
	expectedTransferNet := OrderedCollection with: 'Neto de transferencias = 0 pesos'.
	
	self assert: (expectedTransferNet = aTransferNet).! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'MC 7/14/2021 16:09:39'!
test08TransferNetForTwoAccountsWithOnlyOneTransference

	| accountA accountB transferNetA transferNetB expectedTransferNetA expectedTransferNetB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Transfer amount: 50*peso from: accountA to: accountB.
	transferNetA := accountA transferNet.
	transferNetB := accountB transferNet.

	expectedTransferNetA := OrderedCollection with: 'Salida por transferencia de 50 pesos' with: 'Neto de transferencias = -50 pesos'.
	expectedTransferNetB := OrderedCollection with: 'Entrada por transferencia de 50 pesos' with: 'Neto de transferencias = 50 pesos'.

	self assert: (expectedTransferNetA = transferNetA).
	self assert: (expectedTransferNetB = transferNetB).

! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'MC 7/14/2021 16:34:21'!
test09TransferNetOfAccountWithDifferentTransactionsOnlyRegistersTransferences

	| accountA accountB transferNetA transferNetB expectedTransferNetA expectedTransferNetB |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 50*peso on: accountA.
	Withdraw register: 25*peso on: accountB.
	Transfer amount: 50*peso from: accountA to: accountB.
	transferNetA := accountA transferNet.
	transferNetB := accountB transferNet.

	expectedTransferNetA := OrderedCollection with: 'Salida por transferencia de 50 pesos' with: 'Neto de transferencias = -50 pesos'.
	expectedTransferNetB := OrderedCollection with: 'Entrada por transferencia de 50 pesos' with: 'Neto de transferencias = 50 pesos'.

	self assert: (expectedTransferNetA = transferNetA).
	self assert: (expectedTransferNetB = transferNetB).

! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'MC 7/14/2021 16:41:17'!
test10TransferNetOfAPortfolioWithReceptiveAccounts

	| accountA accountB aPortfolio transferNet expectedTransferNet |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	aPortfolio := Portfolio with: accountA with: accountB.

	Transfer amount: 50*peso from: accountA to: accountB.
	transferNet := aPortfolio transferNet.

	expectedTransferNet := OrderedCollection with: 'Salida por transferencia de 50 pesos' with: 'Entrada por transferencia de 50 pesos' with: 'Neto de transferencias = 0 pesos'.

	self assert: (expectedTransferNet = transferNet).
! !

!ReportTest methodsFor: 'transfer net tests' stamp: 'MC 7/14/2021 16:44:02'!
test11TransferNetOfAPortfolioThatContainsPortfolio

	| accountA accountB portfolioA portfolioB transferNet expectedTransferNet |
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	portfolioB := Portfolio with: accountB.
	portfolioA := Portfolio with: accountA with: portfolioB.
	
	Transfer amount: 50*peso from: accountA to: accountB.
	transferNet := portfolioA transferNet.

	expectedTransferNet := OrderedCollection with: 'Salida por transferencia de 50 pesos' with: 'Entrada por transferencia de 50 pesos' with: 'Neto de transferencias = 0 pesos'.

	self assert: (expectedTransferNet = transferNet).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'MC 7/14/2021 15:51:53'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'MC 7/14/2021 17:13:31'!
transactions

	| transactions |
	
	transactions := OrderedCollection new.
	
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/14/2021 17:27:07'!
accept: aVisitor

	^ aVisitor visitPortfolio: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/14/2021 17:10:25'!
summary

	^ AccountSummary of: self.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MC 7/14/2021 17:19:45'!
transferNet

	^ TransferNet of: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: (0*peso)
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'MC 7/14/2021 23:29:11'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MC 7/14/2021 17:26:11'!
accept: aVisitor

	^ aVisitor visitReceptiveAccount: self.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MC 7/14/2021 17:07:35'!
summary

	^ AccountSummary of: self.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MC 7/14/2021 17:19:18'!
transferNet

	^ TransferNet of: self.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visiting' stamp: 'MC 7/14/2021 23:52:40'!
accept: aVisitor

	self subclassResponsibility.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visiting' stamp: 'MC 7/14/2021 17:27:55'!
accept: aVisitor

	^ aVisitor visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!Deposit class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'visiting' stamp: 'MC 7/14/2021 23:53:58'!
accept: aVisitor

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'visiting' stamp: 'MC 7/14/2021 17:28:22'!
accept: aVisitor

	^ aVisitor visitTransferDepositLeg: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'visiting' stamp: 'MC 7/14/2021 17:28:37'!
accept: aVisitor

	^ aVisitor visitTransferWithdrawLeg: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visiting' stamp: 'MC 7/14/2021 17:28:52'!
accept: aVisitor

	^ aVisitor visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!Withdraw class methodsFor: 'as yet unclassified' stamp: 'LL 7/8/2021 21:45:05'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'visiting' stamp: 'MC 7/14/2021 23:36:40'!
visitDeposit: aDeposit

	self subclassResponsibility.! !

!Report methodsFor: 'visiting' stamp: 'MC 7/14/2021 23:37:08'!
visitTransferDepositLeg: aTransferDepositLeg

	self subclassResponsibility.! !

!Report methodsFor: 'visiting' stamp: 'MC 7/14/2021 23:37:19'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	self subclassResponsibility.! !

!Report methodsFor: 'visiting' stamp: 'MC 7/14/2021 23:36:49'!
visitWithdraw: aWithdraw

	self subclassResponsibility.! !


!Report methodsFor: 'report' stamp: 'MC 7/14/2021 23:37:33'!
calculate

	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account transactionLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'report' stamp: 'MC 7/15/2021 17:21:18'!
addTransactionLinesFrom: aCollectionOfTransactions 
	
	aCollectionOfTransactions do: [ :aTransaction | aTransaction accept: self ].! !

!AccountSummary methodsFor: 'report' stamp: 'MC 7/15/2021 17:21:19'!
calculate

	self addTransactionLinesFrom: account transactions .
	
	transactionLines add: ('Balance = ', account balance asString).
	
	^ transactionLines.
! !


!AccountSummary methodsFor: 'visiting' stamp: 'MC 7/15/2021 17:20:50'!
visitDeposit: aDeposit

	^ transactionLines add: ('Depósito por ', aDeposit value asString).! !

!AccountSummary methodsFor: 'visiting' stamp: 'MC 7/15/2021 17:20:50'!
visitTransferDepositLeg: aTransferDepositLeg

	^ transactionLines add: ('Entrada por transferencia de ', aTransferDepositLeg value asString).		
		! !

!AccountSummary methodsFor: 'visiting' stamp: 'MC 7/15/2021 17:20:50'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	^ transactionLines add: ('Salida por transferencia de ', aTransferWithdrawLeg value asString).		
		! !

!AccountSummary methodsFor: 'visiting' stamp: 'MC 7/15/2021 17:20:50'!
visitWithdraw: aWithdraw

	^ transactionLines add: ('Extracción por ', aWithdraw value asString).		! !


!AccountSummary methodsFor: 'initialization' stamp: 'MC 7/15/2021 17:23:10'!
initializeFor: anAccount

	account := anAccount.
	transactionLines := OrderedCollection new.
	
	^ self.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'MC 7/15/2021 17:23:28'!
of: anAccount

	^ (self new initializeFor: anAccount) calculate.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'account transferLines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'visiting' stamp: 'MC 7/14/2021 17:43:41'!
visitDeposit: aDeposit! !

!TransferNet methodsFor: 'visiting' stamp: 'MC 7/15/2021 17:20:24'!
visitTransferDepositLeg: aTransferDepositLeg

	^ transferLines add: ('Entrada por transferencia de ', aTransferDepositLeg value asString).! !

!TransferNet methodsFor: 'visiting' stamp: 'MC 7/15/2021 17:20:24'!
visitTransferWithdrawLeg: aTransferWithdrawLeg

	^ transferLines add: ('Salida por transferencia de ', aTransferWithdrawLeg value asString).! !

!TransferNet methodsFor: 'visiting' stamp: 'MC 7/14/2021 17:43:51'!
visitWithdraw: aWithdraw! !


!TransferNet methodsFor: 'report' stamp: 'MC 7/15/2021 17:19:38'!
addTransferLinesFrom: aCollectionOfTransactions 

	aCollectionOfTransactions do: [ :aTransaction | aTransaction accept: self ].
		! !

!TransferNet methodsFor: 'report' stamp: 'MC 7/15/2021 17:20:24'!
calculate

	self addTransferLinesFrom: account transactions .
	
	transferLines add: ('Neto de transferencias = ', (self transferBalanceOf: account transactions) asString).
	
	^ transferLines.! !

!TransferNet methodsFor: 'report' stamp: 'MC 7/14/2021 17:22:31'!
transferBalanceOf: aCollectionOfTransactions
	
	^ aCollectionOfTransactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | (transaction isKindOf: TransferLeg) 
			ifTrue: [ transaction affectBalance: currentBalance ] 
			ifFalse: [ currentBalance ] ].
		! !


!TransferNet methodsFor: 'initialization' stamp: 'MC 7/15/2021 17:23:58'!
initializeFor: anAccount

	account := anAccount.
	transferLines := OrderedCollection new.
	
	^ self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'MC 7/15/2021 17:23:50'!
of: anAccount

	^ (self new initializeFor: anAccount) calculate.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
