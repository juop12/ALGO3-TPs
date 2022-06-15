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


!classDefinition: #ReportTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: 'aReportToCompareWith accountSummary transferNet portfolioTreePrinter portfolioDetailedTreePrinter aReportToBeCompared'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportTest methodsFor: 'setup' stamp: 'jms 6/14/2022 21:48:54'!
setUp

	aReportToCompareWith := OrderedCollection new.
	aReportToBeCompared := nil.
	
	accountSummary := AccountSummary new.
	transferNet := TransferNet new.
	portfolioTreePrinter := PortfolioTreePrinter new.
	portfolioDetailedTreePrinter := PortfolioDetailedTreePrinter new.! !


!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:13:52'!
test01ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasNoTransactionsMade

	aReportToCompareWith add: 'Balance = 0 * pesos'.

	self createAccountSummaryReportOf: ReceptiveAccount new.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:14:00'!
test02ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasAnOnlyTransactionThatIsADeposit

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Depósito por 100 * pesos'. 'Balance = 100 * pesos'}.
	
	Deposit register: 100 * peso on: anAccount.
	
	self createAccountSummaryReportOf: anAccount.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:14:07'!
test03ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasAnOnlyTransactionThatIsAWithdraw

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Extracción por 100 * pesos'. 'Balance = -100 * pesos'}.
	
	Withdraw register: 100 * peso on: anAccount.
	
	self createAccountSummaryReportOf: anAccount.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:14:16'!
test04ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasDifferentTransactionsMade

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Depósito por 100 * pesos'. 'Extracción por 40 * pesos'. 'Balance = 60 * pesos'}.
	
	Deposit    register: 100 * peso on: anAccount.
	Withdraw register: 40 * peso on: anAccount.
	
	self createAccountSummaryReportOf: anAccount.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:14:32'!
test05ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasTransferedMoneyToAnotherAccount

	| anAccountToTransferMoneyFrom |
	
	anAccountToTransferMoneyFrom := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Salida por transferencia de 100 * pesos'. 'Balance = -100 * pesos'}.
	
	Transfer amount: 100 * peso from: anAccountToTransferMoneyFrom to: ReceptiveAccount new.
	
	self createAccountSummaryReportOf: anAccountToTransferMoneyFrom.
	self assertReportEqualsWhatIsExpected.
	! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:14:46'!
test06ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasBeenTransferedMoneyFromAnotherAccount

	| anAccountToTransferMoneyTo |

	anAccountToTransferMoneyTo := ReceptiveAccount new.
	aReportToCompareWith addAll: {'Entrada por transferencia de 100 * pesos'. 'Balance = 100 * pesos'}.
	
	Transfer amount: 100 * peso from: ReceptiveAccount new to: anAccountToTransferMoneyTo.
	
	self createAccountSummaryReportOf: anAccountToTransferMoneyTo.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:15:36'!
test07ASummaryCanBeGeneratedFromAReceptiveAccountWhenItHasMultipleTransactionsMade

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	aReportToCompareWith addAll: {
				'Depósito por 100 * pesos'. 
				'Extracción por 50 * pesos'.
				'Salida por transferencia de 20 * pesos'. 
				'Entrada por transferencia de 30 * pesos'. 
				'Balance = 60 * pesos'.
				}.
	
	Deposit    register: 100 * peso on: anAccount.
	Withdraw register:   50 * peso on: anAccount.
	Transfer  amount:   20 * peso from: anAccount to: ReceptiveAccount new.
	Transfer  amount:   30 * peso from: ReceptiveAccount new to: anAccount.
	
	self createAccountSummaryReportOf: anAccount.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:15:55'!
test08ASummaryCanBeGeneratedFromAPortfolioWhenItHasNoTransactionsMade
	
	aReportToCompareWith add: 'Balance = 0 * pesos'.
	
	self createAccountSummaryReportOf: Portfolio new.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests1 - account summary' stamp: 'jms 6/14/2022 22:16:07'!
test09ASummaryCanBeGeneratedFromAPortfolioWhenAPortfolioContainedWithinTheFirstPortfolioContainsAccountsThatHaveMultipleTransactionsMade
	| rootPortfolio secondPortfolioIncludedInRootPortfolio firstAccountIncludedInRootPortfolio secondAccountIncludedInSecondPortfolio |
	
	firstAccountIncludedInRootPortfolio    									:= ReceptiveAccount new.
	secondAccountIncludedInSecondPortfolio  									:= ReceptiveAccount new.
	secondPortfolioIncludedInRootPortfolio  									:= Portfolio with: secondAccountIncludedInSecondPortfolio.
	rootPortfolio := Portfolio with: firstAccountIncludedInRootPortfolio with: secondPortfolioIncludedInRootPortfolio.
	
	aReportToCompareWith addAll: {
				'Depósito por 100 * pesos'. 
				'Extracción por 50 * pesos'.
				'Salida por transferencia de 40 * pesos'.
				'Depósito por 100 * pesos'. 
				'Extracción por 40 * pesos'.
				'Entrada por transferencia de 50 * pesos'.
				'Balance = 120 * pesos'.
				}.

	Deposit register:  100 * peso on: firstAccountIncludedInRootPortfolio.
	Withdraw register: 50 * peso on: firstAccountIncludedInRootPortfolio.
	
	Deposit register:  100 * peso on: secondAccountIncludedInSecondPortfolio.
	Withdraw	 register: 40 * peso on: secondAccountIncludedInSecondPortfolio.
	
	Transfer amount: 40 * peso from: firstAccountIncludedInRootPortfolio to: ReceptiveAccount new.
	Transfer amount: 50 * peso from: ReceptiveAccount new to: secondAccountIncludedInSecondPortfolio.
	
	self createAccountSummaryReportOf: rootPortfolio.
	self assertReportEqualsWhatIsExpected.! !


!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/14/2022 22:17:08'!
test10ATransferNetReportCanBeGeneratedFromAReceptiveAccountWhenItHasNoTranfersMade
	
	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	Deposit register:    100 * peso on: anAccount.
	Withdraw register: 200 * peso on: anAccount.

	self createTransferNetReportOf: anAccount.
	
	self assertTransferNetReportEquals: 0 * peso.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/14/2022 22:20:02'!
test11ATransferNetReportCanBeGeneratedFromAReceptiveAccountWhenItHasBeenTransferedMoneyFromAnotherAccount

	| anAccountToTransferMoneyTo |
	
	anAccountToTransferMoneyTo := ReceptiveAccount new.
	
	Transfer amount: 100 * peso from: ReceptiveAccount new to: anAccountToTransferMoneyTo.
	
	self createTransferNetReportOf: anAccountToTransferMoneyTo.
	
	self assertTransferNetReportEquals: 100 * peso.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/14/2022 22:20:14'!
test12ATransferNetReportCanBeGeneratedFromAReceptiveAccountWhenItHasTransferedMoneyToAnotherAccount

	| anAccountToTransferMoneyFrom |
	
	anAccountToTransferMoneyFrom 	:= ReceptiveAccount new.
	
	Transfer amount: 100 * peso from: anAccountToTransferMoneyFrom to: ReceptiveAccount new.
	
	self createTransferNetReportOf: anAccountToTransferMoneyFrom.
	
	self assertTransferNetReportEquals: -100 * peso.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/15/2022 00:06:34'!
test13ATransferNetReportCanBeGeneratedFromAReceptiveAccountWhenItHasTransferedAndBeenTransferedMoneyFromAnotherAccount

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	Transfer amount: 100 * peso from: anAccount to: ReceptiveAccount new.
	Transfer amount:   50 * peso from: ReceptiveAccount new to: anAccount.
	
	self createTransferNetReportOf: anAccount.
	
	self assertTransferNetReportEquals: -50 * peso.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/14/2022 22:24:58'!
test14ATransferNetReportCanBeGeneratedFromAReceptiveAccountWhenItHasMultipleTransactionsMade

	| anAccount |
	
	anAccount := ReceptiveAccount new.

	Deposit    register: 200 * peso on: anAccount.
	Withdraw register: 100 * peso on: anAccount.
	Transfer  amount: 100 * peso from: anAccount to: ReceptiveAccount new.
	Transfer  amount:   50 * peso from: ReceptiveAccount new to: anAccount.
	
	self createTransferNetReportOf: anAccount.
	
	self assertTransferNetReportEquals: -50 * peso.
	self assert: 50 * peso equals: anAccount balance.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/14/2022 22:26:38'!
test15ATransferNetReportCanBeGeneratedFromAPortfolioWhenItHasNoTransfersMade

	| aPortfolio anAccountIncludedInPortfolio |
	
	anAccountIncludedInPortfolio := ReceptiveAccount new.	
	aPortfolio := Portfolio with: anAccountIncludedInPortfolio.
	
	Deposit register:    100 * peso on: anAccountIncludedInPortfolio.
	Withdraw register: 200 * peso on: anAccountIncludedInPortfolio.
	
	self createTransferNetReportOf: aPortfolio.
	
	self assertTransferNetReportEquals: 0 * peso.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/14/2022 22:27:37'!
test16ATransferNetReportCanBeGeneratedFromAPortfolioWhenItHasMultipleTransactionsMade

	| aPortfolio anAccountIncludedInPortfolio |
	
	anAccountIncludedInPortfolio := ReceptiveAccount new.
	aPortfolio := Portfolio with: anAccountIncludedInPortfolio.
	
	Deposit    register: 200 * peso on: anAccountIncludedInPortfolio.	
	Withdraw register: 100 * peso on: anAccountIncludedInPortfolio.
	Transfer  amount: 100 * peso from: anAccountIncludedInPortfolio to: ReceptiveAccount new.
	Transfer  amount:   50 * peso from: ReceptiveAccount new to: anAccountIncludedInPortfolio.
	
	self createTransferNetReportOf: aPortfolio.
	
	self assertTransferNetReportEquals: -50 * peso.
	self assert: 50 * peso equals: aPortfolio balance.! !

!ReportTest methodsFor: 'tests2 - transfer net' stamp: 'jms 6/15/2022 00:07:41'!
test17ATransferNetReportCanBeGeneratedFromAPortfolioWhenItContainsAHierarchyOfPortfoliosWithEachHavingMultipleTransactionsMade

	| rootPortfolio secondPortfolioIncludedInRootPortfolio firstAccountIncludedInRootPortfolio secondAccountIncludedInSecondPortfolio |
	
	firstAccountIncludedInRootPortfolio  								 := ReceptiveAccount new.
	secondAccountIncludedInSecondPortfolio		 := ReceptiveAccount new.
	secondPortfolioIncludedInRootPortfolio  						 := Portfolio with: secondAccountIncludedInSecondPortfolio.
	rootPortfolio := Portfolio with: firstAccountIncludedInRootPortfolio with: secondPortfolioIncludedInRootPortfolio.
	
	Deposit register:  100 * peso on: firstAccountIncludedInRootPortfolio.
	Withdraw register: 50 * peso on: firstAccountIncludedInRootPortfolio.
	
	Deposit register:  100 * peso on: secondAccountIncludedInSecondPortfolio.
	Withdraw	 register: 40 * peso on: secondAccountIncludedInSecondPortfolio.
	
	Transfer amount: 100 * peso from: firstAccountIncludedInRootPortfolio to: ReceptiveAccount new.
	Transfer amount:   50 * peso from: ReceptiveAccount new to: firstAccountIncludedInRootPortfolio.
	
	Transfer amount: 100 * peso from: secondAccountIncludedInSecondPortfolio to: ReceptiveAccount new.
	Transfer amount:   50 * peso from: ReceptiveAccount new to: secondAccountIncludedInSecondPortfolio.
	
	self createTransferNetReportOf: rootPortfolio.
	
	self assertTransferNetReportEquals: -100 * peso.
	self assert: 10 * peso equals: rootPortfolio balance.
	
	self createTransferNetReportOf: secondPortfolioIncludedInRootPortfolio.
	
	self assertTransferNetReportEquals: -50 * peso.! !


!ReportTest methodsFor: 'tests3 - portfolio tree printer' stamp: 'jms 6/15/2022 00:08:43'!
test18APortfolioTreeCanBeGeneratedFromAnEmptyPortfolio
	
	| aPortfolio |
	
	aPortfolio := Portfolio named: 'Portfolio padre'.
	aReportToCompareWith add: 'Portfolio padre'.

	self createPortfolioTreePrinterReportOf: aPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests3 - portfolio tree printer' stamp: 'jms 6/15/2022 00:09:38'!
test19APortfolioTreeCanBeGeneratedFromAPortfolioWhenItOnlyContainsAnEmptyReceptiveAccount
	
	| aPortfolio anAccountIncludedInPortfolio |
	
	anAccountIncludedInPortfolio := ReceptiveAccount named: 'Cuenta uno'.
	aPortfolio := Portfolio named: 'Portfolio padre' with: anAccountIncludedInPortfolio.
	
	aReportToCompareWith addAll: {
						'Portfolio padre'. 
						'    Cuenta uno'}.

	self createPortfolioTreePrinterReportOf: aPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests3 - portfolio tree printer' stamp: 'jms 6/15/2022 00:10:12'!
test20APortfolioTreeCanBeGeneratedFromAPortfolioWhenItOnlyContainsAnEmptyPortfolio
	
	| rootPortfolio secondPortfolioIncludedInRootPortfolio |
	
	secondPortfolioIncludedInRootPortfolio := Portfolio named: 'Portfolio de hijos'.
	rootPortfolio := Portfolio named: 'Portfolio padre' with: secondPortfolioIncludedInRootPortfolio.
	
	aReportToCompareWith addAll: {
						'Portfolio padre'.
						'    Portfolio de hijos'}.

	self createPortfolioTreePrinterReportOf: rootPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests3 - portfolio tree printer' stamp: 'jms 6/15/2022 00:10:49'!
test21APortfolioTreeCanBeGeneratedFromAPortfolioWhenItContainsAnEmptyPortfolioAndAnEmptyReceptiveAccount

	| rootPortfolio secondPortfolioIncludedInRootPortfolio firstAccountIncludedInRootPortfolio |
	
	secondPortfolioIncludedInRootPortfolio  						:= Portfolio named: 'Portfolio de hijos'.
	firstAccountIncludedInRootPortfolio  								:= ReceptiveAccount named: 'Cuenta uno'.
	rootPortfolio := Portfolio named: 'Portfolio padre' with: firstAccountIncludedInRootPortfolio with: secondPortfolioIncludedInRootPortfolio.
	
	aReportToCompareWith addAll: {
						'Portfolio padre'. 
						'    Cuenta uno'. 
						'    Portfolio de hijos'}.

	self createPortfolioTreePrinterReportOf: rootPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests3 - portfolio tree printer' stamp: 'jms 6/15/2022 00:11:17'!
test22APortfolioTreeCanBeGeneratedFromAPortfolioWhenItContainsAPortfolioThatIsNotEmpty
	
	| rootPortfolio secondPortfolioIncludedInRootPortfolio firstAccountIncludedInSecondPortfolio secondAccountIncludedInSecondPortfolio |
	
	firstAccountIncludedInSecondPortfolio  									:= ReceptiveAccount named: 'Cuenta uno'.
	secondAccountIncludedInSecondPortfolio  									:= ReceptiveAccount named: 'Cuenta dos'.
	secondPortfolioIncludedInRootPortfolio  									:= Portfolio named: 'Portfolio de hijos' with: firstAccountIncludedInSecondPortfolio with: secondAccountIncludedInSecondPortfolio.
	rootPortfolio := Portfolio named: 'Portfolio padre' with: secondPortfolioIncludedInRootPortfolio.
	
	aReportToCompareWith addAll: {
					'Portfolio padre'. 
					'    Portfolio de hijos'.
					'        Cuenta uno'.
					'        Cuenta dos'}.
					
	self createPortfolioTreePrinterReportOf: rootPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests3 - portfolio tree printer' stamp: 'jms 6/15/2022 00:11:48'!
test23APortfolioTreeCanBeGeneratedFromAPortfolioWhenItContainsAPortfolioThatIsNotEmptyAndAReceptiveAccount
	
	| rootPortfolio secondPortfolioIncludedInRootPortfolio firstAccountIncludedInRootPortfolio secondAccountIncludedInSecondPortfolio thirdAccountIncludedInSecondPortfolio |
	
	firstAccountIncludedInRootPortfolio  									:= ReceptiveAccount named: 'Cuenta uno'.
	secondAccountIncludedInSecondPortfolio  									:= ReceptiveAccount named: 'Cuenta dos'.
	thirdAccountIncludedInSecondPortfolio  									:= ReceptiveAccount named: 'Cuenta tres'.
	secondPortfolioIncludedInRootPortfolio  									:= Portfolio named: 'Portfolio de hijos' with: secondAccountIncludedInSecondPortfolio with: thirdAccountIncludedInSecondPortfolio .
	rootPortfolio := Portfolio named: 'Portfolio padre' with: secondPortfolioIncludedInRootPortfolio with: firstAccountIncludedInRootPortfolio.
	
	aReportToCompareWith addAll: {
					'Portfolio padre'. 
					'    Portfolio de hijos'.
					'        Cuenta dos'.
					'        Cuenta tres'.
					'    Cuenta uno'}.
					
	self createPortfolioTreePrinterReportOf: rootPortfolio.
	self assertReportEqualsWhatIsExpected.! !


!ReportTest methodsFor: 'tests4 - portfolio detailed tree printer' stamp: 'jms 6/15/2022 00:12:36'!
test24APortfolioDetailedTreeCanBeGeneratedFromAnEmptyPortfolio
	
	| aPortfolio |
	
	aPortfolio := Portfolio named: 'Portfolio padre'.
	aReportToCompareWith addAll: {
						'Portfolio padre'.
						'    Balance = 0 * pesos'}.

	self createPortfolioDetailedTreePrinterReportOf: aPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests4 - portfolio detailed tree printer' stamp: 'jms 6/15/2022 00:13:15'!
test25APortfolioDetailedTreeCanBeGeneratedFromAPortfolioWhenItContainsAReceptiveAccountWithMultipleTransactionsMade
	
	| aPortfolio anAccount |
	
	anAccount := ReceptiveAccount named: 'Cuenta uno'.
	aPortfolio := Portfolio named: 'Portfolio padre' with: anAccount.
	aReportToCompareWith addAll: {
						'Portfolio padre'. 
						'    Cuenta uno'.
						'        Depósito por 100 * pesos'.
						'        Extracción por 50 * pesos'.
						'        Salida por transferencia de 20 * pesos'.
						'        Entrada por transferencia de 30 * pesos'.
						'        Balance = 60 * pesos'.
						'    Balance = 60 * pesos'}.
						
	Deposit    register: 100 * peso on: anAccount.
	Withdraw register:   50 * peso on: anAccount.
	Transfer  amount:   20 * peso from: anAccount to: ReceptiveAccount new.
	Transfer  amount:   30 * peso from: ReceptiveAccount new to: anAccount.
	
	self createPortfolioDetailedTreePrinterReportOf: aPortfolio.
	self assertReportEqualsWhatIsExpected.! !

!ReportTest methodsFor: 'tests4 - portfolio detailed tree printer' stamp: 'jms 6/15/2022 00:14:15'!
test26APortfolioDetailedTreeCanBeGeneratedFromAPortfolioWhenItContainsAReceptiveAccountWithMultipleTransactionsMadeAndAPortfolioThatContainsReceptiveAccountsWithMultipleTransactionsMade
	
	| rootPortfolio secondPortfolioIncludedInRootPortfolio firstAccountIncludedInRootPortfolio secondAccountIncludedInSecondPortfolio thirdAccountIncludedInSecondPortfolio |
	
	firstAccountIncludedInRootPortfolio  									:= ReceptiveAccount named: 'Cuenta uno'.
	secondAccountIncludedInSecondPortfolio  									:= ReceptiveAccount named: 'Cuenta dos'.
	thirdAccountIncludedInSecondPortfolio  									:= ReceptiveAccount named: 'Cuenta tres'.
	secondPortfolioIncludedInRootPortfolio  									:= Portfolio named: 'Portfolio de hijos' with: secondAccountIncludedInSecondPortfolio with: thirdAccountIncludedInSecondPortfolio .
	rootPortfolio := Portfolio named: 'Portfolio padre' with: secondPortfolioIncludedInRootPortfolio with: firstAccountIncludedInRootPortfolio.
	
	aReportToCompareWith addAll: {
						'Portfolio padre'. 
						'    Portfolio de hijos'.
						'        Cuenta dos'.
						'            Depósito por 100 * pesos'.
						'            Extracción por 50 * pesos'.
						'            Balance = 50 * pesos'.
						'        Cuenta tres'.
						'            Salida por transferencia de 100 * pesos'.
						'            Balance = -100 * pesos'.
						'        Balance = -50 * pesos'.
						'    Cuenta uno'.
						'        Depósito por 200 * pesos'.
						'        Extracción por 50 * pesos'.
						'        Balance = 150 * pesos'.
						'    Balance = 100 * pesos'}.
						
	Deposit    register: 200 * peso on: firstAccountIncludedInRootPortfolio.
	Withdraw register:   50 * peso on: firstAccountIncludedInRootPortfolio.
	
	Deposit    register: 100 * peso on: secondAccountIncludedInSecondPortfolio .
	Withdraw register:   50 * peso on: secondAccountIncludedInSecondPortfolio.
	
	Transfer  amount: 100 * peso from: thirdAccountIncludedInSecondPortfolio to: ReceptiveAccount new.
	
	self createPortfolioDetailedTreePrinterReportOf: rootPortfolio.
	self assertReportEqualsWhatIsExpected.! !


!ReportTest methodsFor: 'private' stamp: 'jms 6/14/2022 21:48:23'!
assertReportEqualsWhatIsExpected

	self assert: aReportToCompareWith equals: aReportToBeCompared.! !

!ReportTest methodsFor: 'private' stamp: 'jms 6/14/2022 21:48:23'!
assertTransferNetReportEquals: amountOfMoney

	self assert: amountOfMoney equals: aReportToBeCompared.! !

!ReportTest methodsFor: 'private' stamp: 'jms 6/14/2022 21:54:58'!
createAccountSummaryReportOf: anAccount

	aReportToBeCompared := accountSummary generateReportOf: anAccount.! !

!ReportTest methodsFor: 'private' stamp: 'jms 6/14/2022 21:54:58'!
createPortfolioDetailedTreePrinterReportOf: aPortfolio

	aReportToBeCompared := portfolioDetailedTreePrinter generateReportOf: aPortfolio.! !

!ReportTest methodsFor: 'private' stamp: 'jms 6/14/2022 21:54:58'!
createPortfolioTreePrinterReportOf: aPortfolio

	aReportToBeCompared := portfolioTreePrinter generateReportOf: aPortfolio.! !

!ReportTest methodsFor: 'private' stamp: 'jms 6/14/2022 21:54:58'!
createTransferNetReportOf: anAccount

	aReportToBeCompared := transferNet generateReportOf: anAccount.! !


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
	instanceVariableNames: 'accounts parents name'
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


!Portfolio methodsFor: 'initialization' stamp: 'jms 6/14/2022 21:10:07'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.
	name := nil.! !

!Portfolio methodsFor: 'initialization' stamp: 'jms 6/14/2022 16:25:53'!
registerName: aName

	name := aName.! !


!Portfolio methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 20:53:18'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 * peso ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/14/2022 19:38:53'!
forEachAccountDo: aBlock
	
	accounts do: aBlock.! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/14/2022 21:15:18'!
forEachTransactionsDo: aBlock
	
	self transactions do: aBlock.! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'private' stamp: 'jms 6/14/2022 17:19:05'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:28:51'!
accept: aReport

	^aReport visitForPortfolio: self. 
	
	"tremendo!!"! !


!Portfolio methodsFor: 'private - accessing' stamp: 'jms 6/14/2022 18:12:20'!
name

	^name.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error message' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!Portfolio class methodsFor: 'instance creation - name' stamp: 'jms 6/14/2022 16:49:21'!
named: aName

	^self new 
		registerName: aName;
		yourself.! !

!Portfolio class methodsFor: 'instance creation - name' stamp: 'jms 6/14/2022 16:20:37'!
named: aName with: anAccount

	^self new 
		registerName: aName;
		add: anAccount;
		yourself.! !

!Portfolio class methodsFor: 'instance creation - name' stamp: 'jms 6/14/2022 16:20:41'!
named: aName with: anAccount with: anotherAccount

	^self new 
		registerName: aName;
		add: anAccount;
		add: anotherAccount;
		yourself.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'initialization' stamp: 'jms 6/14/2022 21:10:53'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	name := nil.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jms 6/14/2022 16:26:35'!
registerName: aName

	name := aName.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'JMS 6/12/2022 20:53:22'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jms 6/14/2022 20:52:13'!
forEachTransactionsDo: aBlock
	
	transactions do: aBlock.! !

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


!ReceptiveAccount methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:19'!
accept: aReport

	^aReport visitForReceptiveAccount: self. ! !


!ReceptiveAccount methodsFor: 'private - accessing' stamp: 'jms 6/14/2022 18:11:41'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation - name' stamp: 'jms 6/14/2022 16:22:50'!
named: aName

	^self new 
		registerName: aName;
		yourself.! !


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


!AccountTransaction methodsFor: 'private' stamp: 'jms 6/14/2022 21:52:46'!
transactionInformation: aReport

	self subclassResponsibility.! !


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


!Deposit methodsFor: 'private' stamp: 'jms 6/14/2022 21:52:58'!
transactionInformation: aReport

	^aReport transactionInformationForDeposit: self.! !

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


!TransferDepositLeg methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:08'!
transactionInformation: aReport

	^aReport transactionInformationForTransferDepositLeg: self.
	! !


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


!TransferWithdrawLeg methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:27'!
transactionInformation: aReport

	^aReport transactionInformationForTransferWithdrawLeg: self.
! !


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


!Withdraw methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:17'!
transactionInformation: aReport

	^aReport transactionInformationForWithdraw: self.
	! !

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


!classDefinition: #ReportOfAccounts category: 'ServiciosFinancieros-Solucion'!
Object subclass: #ReportOfAccounts
	instanceVariableNames: 'report tabulations'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportOfAccounts methodsFor: 'initialization' stamp: 'jms 6/14/2022 20:58:34'!
initialize

	tabulations := 0.
	report := OrderedCollection new.! !


!ReportOfAccounts methodsFor: 'main protocol' stamp: 'jms 6/14/2022 22:20:39'!
generateReportOf: anAccount
	
	anAccount accept: self.
	
	^report.! !


!ReportOfAccounts methodsFor: 'private' stamp: 'jms 6/14/2022 22:06:53'!
addToReport: aLineToBeReported

	report add: (self createIndentation, aLineToBeReported).! !

!ReportOfAccounts methodsFor: 'private' stamp: 'jms 6/14/2022 21:04:34'!
addToReportForEachAccountIn: anAccountToBeReported

	self subclassResponsibility.! !

!ReportOfAccounts methodsFor: 'private' stamp: 'jms 6/14/2022 20:58:17'!
createIndentation

	| indentation |
	
	indentation := ''.
	
	tabulations timesRepeat: [ indentation := indentation, '    ' ].
	
	^indentation.! !

!ReportOfAccounts methodsFor: 'private' stamp: 'jms 6/14/2022 20:58:17'!
withHigherIndentationDo: aBlock

	tabulations := tabulations + 1.
	
	aBlock value.
	
	tabulations  := tabulations - 1.! !


!ReportOfAccounts methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:10'!
visitForPortfolio: anAccount

	self subclassResponsibility.! !

!ReportOfAccounts methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:19'!
visitForReceptiveAccount: anAccount

	self subclassResponsibility.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros-Solucion'!
ReportOfAccounts subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jms 6/14/2022 22:09:26'!
addToReportAnAccountSummaryOf: anAccountToBeReported

	| anAccountReportSummary |
	
	anAccountReportSummary := self createAccountSummaryReportOf: anAccountToBeReported.	
	
	self withHigherIndentationDo: [ 
				self addToReportAnIndentedSummary: anAccountReportSummary. 
			].! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jms 6/14/2022 22:07:19'!
addToReportAnIndentedSummary: anAccountReportSummary

	anAccountReportSummary do: [ :aLineInAReport | self addToReport: aLineInAReport. ].! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jms 6/14/2022 21:06:06'!
addToReportBalanceOf: anAccountToBeReported

	report add: (self createIndentation, ('Balance = ', anAccountToBeReported balance asString)).! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jms 6/14/2022 22:20:39'!
addToReportForEachAccountIn: anAccountToBeReported

	self withHigherIndentationDo: [
				anAccountToBeReported forEachAccountDo: [ :anAccount | anAccount accept: self ].
	
				self addToReportBalanceOf: anAccountToBeReported.
			].! !

!PortfolioDetailedTreePrinter methodsFor: 'private' stamp: 'jms 6/14/2022 22:09:34'!
createAccountSummaryReportOf: anAccountToBeReported

	^AccountSummary new generateReportOf: anAccountToBeReported.! !


!PortfolioDetailedTreePrinter methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:10'!
visitForPortfolio: anAccountToBeReported

	self addToReport: anAccountToBeReported name.

	self addToReportForEachAccountIn: anAccountToBeReported.! !

!PortfolioDetailedTreePrinter methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:19'!
visitForReceptiveAccount: anAccountToBeReported

	self addToReport: anAccountToBeReported name.

	self addToReportAnAccountSummaryOf: anAccountToBeReported.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros-Solucion'!
ReportOfAccounts subclass: #PortfolioTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTreePrinter methodsFor: 'private' stamp: 'jms 6/14/2022 22:20:39'!
addToReportForEachAccountIn: anAccountToBeReported

	self withHigherIndentationDo: [	 
					anAccountToBeReported forEachAccountDo: [ :anAccount | anAccount accept: self ]. 
				].! !


!PortfolioTreePrinter methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:10'!
visitForPortfolio: anAccountToBeReported

	self addToReport: anAccountToBeReported name.

	self addToReportForEachAccountIn: anAccountToBeReported.! !

!PortfolioTreePrinter methodsFor: 'private - DD' stamp: 'jms 6/14/2022 22:21:19'!
visitForReceptiveAccount: anAccountToBeReported

	self addToReport: anAccountToBeReported name.! !


!classDefinition: #ReportOfTransactions category: 'ServiciosFinancieros-Solucion'!
Object subclass: #ReportOfTransactions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReportOfTransactions methodsFor: 'main protocol' stamp: 'jms 6/14/2022 21:54:57'!
generateReportOf: anAccountToBeReported

	self subclassResponsibility.! !


!ReportOfTransactions methodsFor: 'private' stamp: 'jms 6/14/2022 21:52:58'!
transactionInformationForDeposit: aTransactionToBeReported 
	
	self subclassResponsibility.! !

!ReportOfTransactions methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:07'!
transactionInformationForTransferDepositLeg: aTransactionToBeReported 
	
	self subclassResponsibility.! !

!ReportOfTransactions methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:27'!
transactionInformationForTransferWithdrawLeg: aTransactionToBeReported 
	
	self subclassResponsibility.! !

!ReportOfTransactions methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:16'!
transactionInformationForWithdraw: aTransactionToBeReported 
	
	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
ReportOfTransactions subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'main protocol' stamp: 'jms 6/14/2022 21:54:57'!
generateReportOf: anAccountToBeReported

	"generateSummaryOf: anAccount"

	| aReport |
	
	aReport := OrderedCollection new.
	
	anAccountToBeReported forEachTransactionsDo: [ :aTransaction | aReport add: (aTransaction transactionInformation: self) ].

	aReport add: ('Balance = ', anAccountToBeReported balance asString).
	
	^aReport.
! !


!AccountSummary methodsFor: 'private' stamp: 'jms 6/14/2022 21:52:58'!
transactionInformationForDeposit: aTransactionToBeReported 
	
	^'Depósito por ', aTransactionToBeReported value asString.! !

!AccountSummary methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:08'!
transactionInformationForTransferDepositLeg: aTransactionToBeReported 
	
	^'Entrada por transferencia de ', aTransactionToBeReported value asString.! !

!AccountSummary methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:27'!
transactionInformationForTransferWithdrawLeg: aTransactionToBeReported 
	
	^'Salida por transferencia de ', aTransactionToBeReported value asString.! !

!AccountSummary methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:17'!
transactionInformationForWithdraw: aTransactionToBeReported 
	
	^'Extracción por ', aTransactionToBeReported value asString.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros-Solucion'!
ReportOfTransactions subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferNet methodsFor: 'private' stamp: 'jms 6/14/2022 21:52:58'!
transactionInformationForDeposit: aTransactionToBeReported 
	
	^0 * peso.
	! !

!TransferNet methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:08'!
transactionInformationForTransferDepositLeg: aTransactionToBeReported 

	^aTransactionToBeReported value.
	! !

!TransferNet methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:27'!
transactionInformationForTransferWithdrawLeg: aTransactionToBeReported 
	
	^aTransactionToBeReported value negated.
	! !

!TransferNet methodsFor: 'private' stamp: 'jms 6/14/2022 21:53:17'!
transactionInformationForWithdraw: aTransactionToBeReported 
	
	^0 * peso.
	! !


!TransferNet methodsFor: 'main protocol' stamp: 'jms 6/14/2022 21:54:57'!
generateReportOf: anAccountToBeReported

	| transferNet |
	
	transferNet := 0.

	anAccountToBeReported forEachTransactionsDo: [ :aTransaction | transferNet := transferNet + (aTransaction transactionInformation: self)].
	
	^transferNet.! !


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
