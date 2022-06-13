!classDefinition: #AANewTests category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AANewTests
	instanceVariableNames: 'aReportToCompareWith'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AANewTests methodsFor: 'setup' stamp: 'JMS 6/12/2022 20:55:54'!
setUp

	aReportToCompareWith := OrderedCollection new.! !


!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:29:41'!
test01AReceptiveAccountCanGiveOutASummaryWhenItHasNoTransactionsMade
	
	| aReport |

	aReportToCompareWith add: 'Balance = 0 * pesos'.

	aReport := AccountSummary new reportOf: ReceptiveAccount new.
	
	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:07'!
test02AReceptiveAccountCanGiveOutASummaryWhenItHasAnOnlyTransactionThatIsADeposit

	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Depósito por 100 * pesos'. 'Balance = 100 * pesos'}.
	
	Deposit register: 100 * peso on: anAccount.
	
	aReport := AccountSummary new reportOf: anAccount.
	
	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:11'!
test03AReceptiveAccountCanGiveOutASummaryWhenItHasAnOnlyTransactionThatIsAWithdraw

	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Extracción por 100 * pesos'. 'Balance = -100 * pesos'}.
	
	Withdraw register: 100 * peso on: anAccount.
	
	aReport := AccountSummary new reportOf: anAccount.

	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:14'!
test04AReceptiveAccountCanGiveOutASummaryWhenItHasDifferentTransactionsMade

	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Depósito por 100 * pesos'. 'Extracción por 40 * pesos'. 'Balance = 60 * pesos'}.
	
	Deposit    register: 100 * peso on: anAccount.
	Withdraw register: 40 * peso on: anAccount.
	
	aReport := AccountSummary new reportOf: anAccount.

	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:18'!
test05AReceptiveAccountCanGiveOutASummaryWhenItHasTransferedMoneyToAnotherAccount

	| anAccountToTransferMoneyFrom aReport |
	
	anAccountToTransferMoneyFrom := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Salida por transferencia de 100 * pesos'. 'Balance = -100 * pesos'}.
	
	Transfer amount: 100 * peso from: anAccountToTransferMoneyFrom to: ReceptiveAccount new.
	
	aReport := AccountSummary new reportOf: anAccountToTransferMoneyFrom.

	self assert: aReportToCompareWith equals: aReport.
	! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:24'!
test06AReceptiveAccountCanGiveOutASummaryWhenItHasBeenTransferedMoneyFromAnotherAccount

	| anAccountToTransferMoneyTo aReport |

	anAccountToTransferMoneyTo := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Entrada por transferencia de 100 * pesos'. 'Balance = 100 * pesos'}.
	
	Transfer amount: 100 * peso from: ReceptiveAccount new to: anAccountToTransferMoneyTo.
	
	aReport := AccountSummary new reportOf: anAccountToTransferMoneyTo.

	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:32'!
test07AReceptiveAccountCanGiveOutASummaryWhenItHasMultipleTransactionsMade

	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {
				'Depósito por 100 * pesos'. 'Extracción por 50 * pesos'.
				'Salida por transferencia de 20 * pesos'. 
				'Entrada por transferencia de 30 * pesos'. 'Balance = 60 * pesos'
				}.
	
	Deposit    register: 100 * peso on: anAccount.
	Withdraw register:   50 * peso on: anAccount.
	Transfer amount:    20 * peso from: anAccount to: ReceptiveAccount new.
	Transfer amount:    30 * peso from: ReceptiveAccount new to: anAccount.
	
	aReport := AccountSummary new reportOf: anAccount.

	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:32:55'!
test08APortfolioCanGiveOutASummaryWhenItHasNoTransactionsMade
	
	| aReport |
	
	aReportToCompareWith add: 'Balance = 0 * pesos'.
	
	aReport := AccountSummary new reportOf: Portfolio new.

	self assert: aReportToCompareWith equals: aReport.! !

!AANewTests methodsFor: 'tests - account summary' stamp: 'JMS 6/12/2022 21:36:43'!
test09APortfolioCanGiveOutASummaryWhenAPortfolioContainedWithinTheFirstPortfolioContainsAccountsThatHaveMultipleTransactionsMade
	| rootPortfolio secondPortfolioContainedInRootPortfolio firstAccountInRootPortfolio secondAccountInSecondPortfolio aReport |
	
	firstAccountInRootPortfolio    								 := ReceptiveAccount new.
	secondAccountInSecondPortfolio  								 := ReceptiveAccount new.
	secondPortfolioContainedInRootPortfolio  		:= Portfolio with: secondAccountInSecondPortfolio.
	rootPortfolio := Portfolio with: firstAccountInRootPortfolio with: secondPortfolioContainedInRootPortfolio.
	
	aReportToCompareWith addAll: {
				'Depósito por 100 * pesos'. 'Extracción por 50 * pesos'.
				'Salida por transferencia de 40 * pesos'.
				'Depósito por 100 * pesos'. 'Extracción por 40 * pesos'.
				'Entrada por transferencia de 50 * pesos'.
				'Balance = 120 * pesos'.
				}.

	Deposit register:  100 * peso on: firstAccountInRootPortfolio.
	Withdraw register: 50 * peso on: firstAccountInRootPortfolio.
	
	Deposit register:  100 * peso on: secondAccountInSecondPortfolio.
	Withdraw	 register: 40 * peso on: secondAccountInSecondPortfolio.
	
	Transfer amount: 40 * peso from: firstAccountInRootPortfolio to: ReceptiveAccount new.
	Transfer amount: 50 * peso from: ReceptiveAccount new to: secondAccountInSecondPortfolio.
	
	aReport := AccountSummary new reportOf: rootPortfolio.

	self assert: aReportToCompareWith equals: aReport.! !


!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 21:55:40'!
test10IgnoraDepositYWithdraw
	
	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register:    100 * peso on: anAccount.
	Withdraw register: 200 * peso on: anAccount.

	aReport := TransferNet new reportOf: anAccount.
	
	self assert: 0 * peso equals: aReport.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 21:56:26'!
test11entrada

	| anAccountToTransferMoneyTo aReport |
	
	anAccountToTransferMoneyTo := ReceptiveAccount new.
	
	Transfer amount: 100 * peso from: ReceptiveAccount new to: anAccountToTransferMoneyTo.
	
	aReport := TransferNet new reportOf: anAccountToTransferMoneyTo.
	
	self assert: 100 * peso equals: aReport.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 21:57:21'!
test12salida

	| anAccountToTransferMoneyFrom aReport |
	
	anAccountToTransferMoneyFrom 	:= ReceptiveAccount new.
	
	Transfer amount: 100 * peso from: anAccountToTransferMoneyFrom to: ReceptiveAccount new.
	
	aReport := TransferNet new reportOf: anAccountToTransferMoneyFrom.
	
	self assert: -100 * peso equals: aReport.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 21:57:56'!
test13entradaYsalida

	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.
	
	Transfer amount: 100 * peso from: anAccount to: ReceptiveAccount new.
	Transfer amount:   50 * peso from: ReceptiveAccount new to: anAccount.
	
	aReport := TransferNet new reportOf: anAccount.
	
	self assert: -50 * peso equals: aReport.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 21:58:38'!
test14conWithdrawYDepositoParaIgnorar

	| anAccount aReport |
	
	anAccount := ReceptiveAccount new.

	Deposit register:    200 * peso on: anAccount.
	Withdraw register: 100 * peso on: anAccount.
	Transfer amount:  100 * peso from: anAccount to: ReceptiveAccount new.
	Transfer amount:    50 * peso from: ReceptiveAccount new to: anAccount.
	
	aReport := TransferNet new reportOf: anAccount.
	
	self assert: -50 * peso equals: aReport.
	self assert:  50 * peso equals: anAccount balance.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 21:59:19'!
test15PortfolioIgnoraDepositYWithdraw

	| aPortfolio anAccountInPortfolio aReport |
	
	anAccountInPortfolio := ReceptiveAccount new.	
	aPortfolio := Portfolio with: anAccountInPortfolio.
	
	Deposit register:    100 * peso on: anAccountInPortfolio.
	Withdraw register: 200 * peso on: anAccountInPortfolio.
	
	aReport := TransferNet new reportOf: aPortfolio.
	
	self assert: 0 * peso equals: aReport.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 22:00:23'!
test16PortfolioConWithdrawYDepositarParaIgnorar

	| aPortfolio anAccountInPortfolio aReport |
	
	anAccountInPortfolio := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccountInPortfolio.
	
	Deposit register:    200 * peso on: anAccountInPortfolio.	
	Withdraw register: 100 * peso on: anAccountInPortfolio.
	Transfer amount:  100 * peso from: anAccountInPortfolio to: ReceptiveAccount new.
	Transfer amount:    50 * peso from: ReceptiveAccount new to: anAccountInPortfolio.
	
	aReport := TransferNet new reportOf: aPortfolio.
	
	self assert: -50 * peso equals: aReport.
	self assert:  50 * peso equals: aPortfolio balance.! !

!AANewTests methodsFor: 'tests - transfer net' stamp: 'JMS 6/12/2022 22:03:12'!
test17PortfolioConPortfolio

	| rootPortfolio secondPortfolioContainedInRootPortfolio firstAccountInRootPortfolio secondAccountInSecondPortfolio aReportOfRootPortfolio aReportOfSecondPortfolio |
	
	firstAccountInRootPortfolio  								 := ReceptiveAccount new.
	secondAccountInSecondPortfolio  								 := ReceptiveAccount new.
	secondPortfolioContainedInRootPortfolio  		:= Portfolio with: secondAccountInSecondPortfolio.
	rootPortfolio := Portfolio with: firstAccountInRootPortfolio with: secondPortfolioContainedInRootPortfolio.
	
	Deposit register:  100 * peso on: firstAccountInRootPortfolio.
	Withdraw register: 50 * peso on: firstAccountInRootPortfolio.
	
	Deposit register:  100 * peso on: secondAccountInSecondPortfolio.
	Withdraw	 register: 40 * peso on: secondAccountInSecondPortfolio.
	
	Transfer amount: 100 * peso from: firstAccountInRootPortfolio to: ReceptiveAccount new.
	Transfer amount:   50 * peso from: ReceptiveAccount new to: firstAccountInRootPortfolio.
	
	Transfer amount: 100 * peso from: secondAccountInSecondPortfolio to: ReceptiveAccount new.
	Transfer amount:   50 * peso from: ReceptiveAccount new to: secondAccountInSecondPortfolio.
	
	aReportOfRootPortfolio := TransferNet new reportOf: rootPortfolio.
	aReportOfSecondPortfolio := TransferNet new reportOf: secondPortfolioContainedInRootPortfolio.
	
	self assert: -100 * peso equals: aReportOfRootPortfolio.
	self assert:   -50 * peso equals: aReportOfSecondPortfolio.
	self assert:    10 * peso equals: rootPortfolio balance.! !


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

!PortfolioTest methodsFor: 'tests' stamp: 'LL 11/29/2021 18:55:37'!
test12PortfolioCanNotIncludeItself

	| simplePortfolio |
	
	simplePortfolio := Portfolio new.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 0 equals: simplePortfolio accountsSize. ]! !

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


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
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

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
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

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:45:50'!
addedTo: aPortfolio

	self subclassResponsibility! !

!Account methodsFor: 'composition' stamp: 'LL 7/8/2021 21:46:48'!
isComposedBy: anAccount

	self subclassResponsibility! !


!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 20:53:18'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

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

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 20:53:22'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


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


!AccountTransaction methodsFor: 'transfer net' stamp: 'JMS 6/12/2022 17:32:43'!
affectTransferNet: aBalance
	
	^aBalance.! !


!AccountTransaction methodsFor: 'private' stamp: 'rb 6/11/2022 16:30:06'!
transactionDescription

	self subclassResponsibility.! !

!AccountTransaction methodsFor: 'private' stamp: 'JMS 6/12/2022 22:16:48'!
transactionDescription: reporte

	reporte transactionDescription: self.! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'private' stamp: 'JMS 6/12/2022 16:58:09'!
transactionDescription

	^'Depósito por ', self value asString.! !

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

!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !


!TransferLeg methodsFor: 'transfer net' stamp: 'JMS 6/12/2022 17:39:17'!
affectTransferNet: aBalance

	^self affectBalance: aBalance.! !


!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !

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


!TransferDepositLeg methodsFor: 'private' stamp: 'JMS 6/12/2022 16:58:04'!
transactionDescription

	^'Entrada por transferencia de ', self value asString.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'rb 6/11/2022 17:24:12'!
affectBalance: aBalance

	^aBalance + self value negated! !


!TransferWithdrawLeg methodsFor: 'private' stamp: 'JMS 6/12/2022 16:57:57'!
transactionDescription

	^'Salida por transferencia de ', self value asString.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'balance' stamp: 'rb 6/11/2022 17:23:19'!
affectBalance: aBalance

	^aBalance +  value negated! !


!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'private' stamp: 'JMS 6/12/2022 16:57:44'!
transactionDescription

	^'Extracción por ', self value asString.! !

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

!Report methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 21:41:55'!
reportOf: anAccount

	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 21:38:21'!
reportOf: anAccount

	"generateSummaryOf: anAccount"

	| aReport |
	
	aReport := OrderedCollection new.
	
	anAccount transactions do: [ :aTransaction | aReport add: aTransaction transactionDescription ].

	aReport add: ('Balance = ', anAccount balance asString).
	
	^aReport.
! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 21:55:50'!
reportOf: anAccount

	^anAccount transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectTransferNet: currentBalance ].
	! !


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
