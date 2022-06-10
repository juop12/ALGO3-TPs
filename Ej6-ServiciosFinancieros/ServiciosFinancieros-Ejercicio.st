!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'rootPortfolio firstAccount portfolioTwoIncludedInRootPortfolio portfolioThreeIncludedInPortfolioTwo secondAccount fourthAccount fifthAccount thirdAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:05:48'!
test01APortfolioCannotAddTheSameAccountTwice
	rootPortfolio add: firstAccount.
	
	self should: [ rootPortfolio add: firstAccount ]
		raise: Error
		withExceptionDo: [ :anError |
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:05:27'!
test02APortfolioCannotAddAnAccountIfTheParentsOfTheAccountAreAlreadyIncludedInThePortfolio
	self organizePortfolioHierarchy.
	
	self should: [ rootPortfolio add: fifthAccount ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:05:27'!
test03APortfolioCannotAddItself
	
	self should: [ rootPortfolio add: rootPortfolio ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:23:04'!
test04APortfolioCannotAddAnAccountThatIsAlreadyContainedInAFatherPortfolio
	rootPortfolio add: firstAccount.
	rootPortfolio add: portfolioTwoIncludedInRootPortfolio.
	rootPortfolio add: secondAccount.
	portfolioTwoIncludedInRootPortfolio add: thirdAccount.
	
	self should: [ portfolioTwoIncludedInRootPortfolio add: firstAccount ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:49:03'!
test05APortfolioCannotAddAnotherPortfolioThatIsAlreadyContainedInAFatherPortfolio

	rootPortfolio add: portfolioTwoIncludedInRootPortfolio.
	portfolioTwoIncludedInRootPortfolio add: portfolioThreeIncludedInPortfolioTwo.
	portfolioThreeIncludedInPortfolioTwo add: firstAccount.
	
	self should: [ portfolioThreeIncludedInPortfolioTwo add: portfolioTwoIncludedInRootPortfolio ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:51:43'!
test06APortfolioCannotAddAnotherPortfolioThatIsAlreadyContainedInAFatherPortfolioWithMoreComplexRelations

	| portfolioThreeIncludedInRootPortfolio portfolioFourIncludedInPortfolioTwo portfolioFiveIncludedInPortfolioThree |
	
	portfolioThreeIncludedInRootPortfolio := Portfolio new.
	portfolioFourIncludedInPortfolioTwo := Portfolio new.
	portfolioFiveIncludedInPortfolioThree := Portfolio new.
	
	rootPortfolio add: firstAccount.
	rootPortfolio add: portfolioTwoIncludedInRootPortfolio.
	rootPortfolio add: secondAccount.
	rootPortfolio add: portfolioThreeIncludedInRootPortfolio.
	rootPortfolio add: thirdAccount.
	
	portfolioTwoIncludedInRootPortfolio add: fourthAccount.
	portfolioTwoIncludedInRootPortfolio add: portfolioFourIncludedInPortfolioTwo.
	portfolioTwoIncludedInRootPortfolio add: fifthAccount.
	
	portfolioThreeIncludedInRootPortfolio add: ReceptiveAccount new.
	portfolioThreeIncludedInRootPortfolio add: portfolioFiveIncludedInPortfolioThree.
	portfolioThreeIncludedInRootPortfolio add: ReceptiveAccount new.
	
	self should: [ portfolioFiveIncludedInPortfolioThree add: portfolioFourIncludedInPortfolioTwo ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].
			
					! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/9/2022 00:23:04'!
test07APortfolioCannotAddAnotherPortfolioIfThisOneContainsAnAccountAlreadyContainedInTheFirstPortfolio

	rootPortfolio add: firstAccount.
	rootPortfolio add: secondAccount.
	portfolioTwoIncludedInRootPortfolio add: firstAccount.
	portfolioTwoIncludedInRootPortfolio add: thirdAccount.
	
	self should: [ rootPortfolio add: portfolioTwoIncludedInRootPortfolio ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !


!PortfolioTest methodsFor: 'setup' stamp: 'jms 6/9/2022 00:30:27'!
setUp

	rootPortfolio := Portfolio new.
	portfolioTwoIncludedInRootPortfolio := Portfolio new.
	portfolioThreeIncludedInPortfolioTwo := Portfolio new.
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	thirdAccount := ReceptiveAccount new.
	fourthAccount := ReceptiveAccount new.
	fifthAccount := ReceptiveAccount new.! !


!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:07:46'!
test01PortfolioHasZeroBalanceWhenCreated

	self assert: 0 * peso equals: rootPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:07:50'!
test02PortfolioCanGiveUsItsBalanceWhenItOnlyContainsOneReceptiveAccountWithoutTransactions

	rootPortfolio add: firstAccount.	
	
	self assert: 0 * peso equals: rootPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:05:27'!
test03PortfolioCanGiveUsItsBalanceWhenItOnlyContainsOneReceptiveAccount

	rootPortfolio add: firstAccount.	
	
	Deposit    register: 100 * peso on: firstAccount.
	Withdraw register: 150 * peso on: firstAccount.
	
	self assert: -50 * peso equals: rootPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:05:27'!
test04PortfolioCanGiveUsItsBalanceWhenItOnlyContainsReceptiveAccounts

	rootPortfolio add: firstAccount.
	rootPortfolio add: secondAccount.
	
	Deposit register: 100 * peso on: firstAccount.
	Deposit register: 200 * peso on: secondAccount.
	
	self assert: 300 * peso equals: rootPortfolio balance.	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:23:04'!
test05PortfolioCanGiveUsItsBalanceWhenItContainsOnePortfolio

	portfolioTwoIncludedInRootPortfolio add: firstAccount.
	rootPortfolio add: portfolioTwoIncludedInRootPortfolio.
	
	Deposit register: 100 * peso on: firstAccount.
	
	self assert: 100 * peso equals: rootPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:23:22'!
test06PortfolioCanGiveUsItsBalanceWhenItContainsPortfolios

	Deposit register: 100 * peso on: secondAccount. 
	Deposit register: 100 * peso on: thirdAccount. 
	Deposit register: 100 * peso on: fifthAccount. 

	self organizePortfolioHierarchy.
	
	self assert: 300 * peso equals: rootPortfolio balance.
	self assert: 200 * peso equals: portfolioTwoIncludedInRootPortfolio balance.
	self assert: 100 * peso equals: portfolioThreeIncludedInPortfolioTwo balance.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:08:14'!
test07PortfolioKnowsTheTransactionsOfTheReceptiveAccountsItContains

	| deposit withdraw |

	rootPortfolio add: firstAccount.	
	rootPortfolio add: secondAccount.
	
	deposit   := Deposit    register: 100 * peso on: firstAccount.
	withdraw := Withdraw register:   50 * peso on: secondAccount.
	
	self assert: 2 equals: rootPortfolio transactions size. 
	self assert: (rootPortfolio transactions includes: deposit).
	self assert: (rootPortfolio transactions includes: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:23:22'!
test08PortfolioKnowsTheTransactionsOfTheReceptiveAccountsContainedInThePortfoliosItContains

	| deposit1 deposit2 deposit3 |

	deposit1 := Deposit register: 100 * peso on: secondAccount. 
	deposit2 := Deposit register: 100 * peso on: thirdAccount. 
	deposit3 := Deposit register: 100 * peso on: fifthAccount. 
	
	self organizePortfolioHierarchy.
	
	self assert: 3 equals: rootPortfolio transactions size.
	
	self assert: (rootPortfolio transactions includes: deposit1).
	self assert: (rootPortfolio transactions includes: deposit2).
	self assert: (rootPortfolio transactions includes: deposit3).
	
	self assert: 2 equals: portfolioTwoIncludedInRootPortfolio transactions size.
	
	self assert: (portfolioTwoIncludedInRootPortfolio transactions includes: deposit2).
	self assert: (portfolioTwoIncludedInRootPortfolio transactions includes: deposit3).
	
	self assert: 1 equals: portfolioThreeIncludedInPortfolioTwo transactions size.
	
	self assert: (portfolioThreeIncludedInPortfolioTwo transactions includes: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:05:27'!
test09PortfolioKnowsIfItHasRegisteredTheTransactionsOfTheReceptiveAccountsItContains

	| deposit withdraw |

	rootPortfolio add: firstAccount.	
	rootPortfolio add: secondAccount.
	
	deposit   := Deposit    register: 100 * peso on: firstAccount.
	withdraw := Withdraw register:  50  * peso on: secondAccount.
	
	self assert: 2 equals: rootPortfolio transactions size. 
	self assert: (rootPortfolio hasRegistered: deposit).
	self assert: (rootPortfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/9/2022 00:23:22'!
test10PortfolioKnowsIfItHasRegisteredTheTransactionsOfTheReceptiveAccountsContainedInThePortfoliosItContains

	| deposit1 deposit2 deposit3 |

	deposit1 := Deposit register: 100 * peso on: secondAccount. 
	deposit2 := Deposit register: 100 * peso on: thirdAccount. 
	deposit3 := Deposit register: 100 * peso on: fifthAccount. 
	
	self organizePortfolioHierarchy.
	
	self assert: (rootPortfolio hasRegistered: deposit3).
	self assert: (rootPortfolio hasRegistered: deposit2).
	self assert: (rootPortfolio hasRegistered: deposit1).
	
	self assert: (portfolioTwoIncludedInRootPortfolio hasRegistered: deposit3).
	self assert: (portfolioTwoIncludedInRootPortfolio hasRegistered: deposit2).
	
	self assert: (portfolioThreeIncludedInPortfolioTwo hasRegistered: deposit3).! !


!PortfolioTest methodsFor: 'private' stamp: 'jms 6/9/2022 00:23:22'!
organizePortfolioHierarchy

	rootPortfolio add: firstAccount.
	rootPortfolio add: portfolioTwoIncludedInRootPortfolio.
	rootPortfolio add: secondAccount.
	
	portfolioTwoIncludedInRootPortfolio add: thirdAccount.
	portfolioTwoIncludedInRootPortfolio add: portfolioThreeIncludedInPortfolioTwo.
	portfolioTwoIncludedInRootPortfolio add: fourthAccount.
	
	portfolioThreeIncludedInPortfolioTwo add: fifthAccount! !


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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jms 6/8/2022 22:49:46'!
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


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'firstAccount secondAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:00:07'!
test01TransferDecreasesBalanceOnOneAccountAndDepositsItOnAnother

	Transfer transfer: 100 * peso from: firstAccount to: secondAccount.
	
	self assert: -100 * peso equals: firstAccount balance.
	self assert:  100 * peso equals: secondAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:00:07'!
test02TransferMovesMoneyFromOneAccountToTheOtherAndViceversa

	Transfer transfer: 100 * peso from: firstAccount to: secondAccount.
	Transfer transfer:   50 * peso from: secondAccount to: firstAccount.
	
	self assert: -50 * peso equals: firstAccount balance.
	self assert:  50 * peso equals: secondAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:00:07'!
test03InATransactionTheDepositLegKnowsTheWithdrawLeg

	| transfer |
	
	transfer := Transfer transfer: 100 * peso from: firstAccount to: secondAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg counterpart.
	! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:00:21'!
test04InATransactionTheWithdrawLegKnowsTheDepositLeg

	| transfer |

	transfer := Transfer transfer: 100 * peso from: firstAccount to: secondAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg counterpart.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:00:28'!
test05TransferCannotMove0PesosFromOneAccountToAnother

	self should: [Transfer transfer: 0 * peso from: firstAccount to: secondAccount.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer canOnlyTransferPositiveAmountsErrorDescription equals: anError messageText ].! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:01:05'!
test06TransferCannotMoveANegativeAmountFromOneAccountToAnother

	self should: [Transfer transfer: -100 * peso from: firstAccount to: secondAccount.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer canOnlyTransferPositiveAmountsErrorDescription equals: anError messageText ].! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/8/2022 23:01:12'!
test07TransferCannotMoveAnAmountFromAnAccountToItself

	self should: [Transfer transfer: 10 * peso from: firstAccount to: firstAccount.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer anAccountCannotTransferAnAmountToItselfErrorDescription equals: anError messageText ].! !


!TransferTest methodsFor: 'setup' stamp: 'jms 6/8/2022 23:00:07'!
setUp

	firstAccount :=	 ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.! !


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

!AccountTransaction class methodsFor: 'instance creation' stamp: 'rb 6/4/2022 23:27:10'!
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


!Deposit methodsFor: 'value' stamp: 'jms 6/2/2022 21:26:24'!
effectOnTheBalance

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

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


!Withdraw methodsFor: 'value' stamp: 'jms 6/2/2022 21:26:24'!
effectOnTheBalance

	^ value negated! !

!Withdraw methodsFor: 'value' stamp: 'jms 6/2/2022 21:18:30'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'wallet fatherPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'error' stamp: 'jms 6/7/2022 17:56:03'!
canNotAddAnAccountThatHasAlreadyBeenAdded

	self error: self class canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription.! !


!Portfolio methodsFor: 'initialization' stamp: 'jms 6/8/2022 23:28:49'!
initialize

	wallet := OrderedCollection new.
	fatherPortfolio := nil.! !


!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/8/2022 23:28:05'!
add: anAccountToBeAdded

	self assertPortfolioHierarchyDoesNotInclude: anAccountToBeAdded.
	
	anAccountToBeAdded assignFatherPortfolio: self.	
	wallet add: anAccountToBeAdded.! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/8/2022 22:39:00'!
balance

	^wallet sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/8/2022 23:42:53'!
hasRegistered: aTransaction 

	^ wallet anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction. ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/8/2022 23:45:28'!
transactions
	^ wallet inject: OrderedCollection new into: [ :transactions :anAccount | transactions, anAccount transactions. ].! !


!Portfolio methodsFor: 'testing' stamp: 'jms 6/8/2022 23:21:43'!
assertEachAccountInAWalletIsNotEqualTo: anAccountToBeAdded

	wallet do: [ :anAccount | anAccount assertAccountFrom: self isNotEqualTo: anAccountToBeAdded.			].! !

!Portfolio methodsFor: 'testing' stamp: 'jms 6/8/2022 23:20:10'!
assertPortfolioDoesNotInclude: anAccountToBeAdded

	self assertPortfolioIsNotEqualTo: anAccountToBeAdded.

	self assertEachAccountInAWalletIsNotEqualTo: anAccountToBeAdded.	
	! !

!Portfolio methodsFor: 'testing' stamp: 'jms 6/8/2022 23:40:11'!
assertPortfolioHierarchyDoesNotInclude: anAccountToBeAdded

	self getOldestFather assertPortfolioDoesNotInclude: anAccountToBeAdded.
	
	" Iterar por la wallet de la accountToBeAdded si es un Portfolio "
	(anAccountToBeAdded isKindOf: Portfolio) ifTrue: [
					self assertPortfolioHierarchyDoesNotIncludeForEachElementOf: anAccountToBeAdded.
					].! !

!Portfolio methodsFor: 'testing' stamp: 'jms 6/8/2022 23:35:42'!
assertPortfolioHierarchyDoesNotIncludeForEachElementOf: anAccountToBeAdded

	anAccountToBeAdded wallet do: [ :anAccount |
						self assertPortfolioHierarchyDoesNotInclude: anAccount.
						].! !

!Portfolio methodsFor: 'testing' stamp: 'jms 6/8/2022 23:13:14'!
assertPortfolioIsNotEqualTo: anAccountToBeAdded

	self = anAccountToBeAdded ifTrue: [ self canNotAddAnAccountThatHasAlreadyBeenAdded ].! !


!Portfolio methodsFor: 'private' stamp: 'rb 6/7/2022 22:32:57'!
assignFatherPortfolio: aFatherPortfolio

	fatherPortfolio := aFatherPortfolio.! !

!Portfolio methodsFor: 'private' stamp: 'jms 6/8/2022 23:28:41'!
getOldestFather

	fatherPortfolio = nil ifTrue: [ ^self. ].
	
	^fatherPortfolio getOldestFather.! !


!Portfolio methodsFor: 'private - accessing' stamp: 'jms 6/7/2022 20:04:53'!
wallet 

	^wallet.! !


!Portfolio methodsFor: 'private - recursion' stamp: 'jms 6/7/2022 18:42:29'!
alreadyIncludesThisReceptiveAccount

	self canNotAddAnAccountThatHasAlreadyBeenAdded.

! !

!Portfolio methodsFor: 'private - recursion' stamp: 'jms 6/8/2022 23:39:12'!
assertAccountFrom: aPortfolioThatContainsThisAccount isNotEqualTo: anAccountToBeAdded	"Llamado recursivo."
	
	self assertPortfolioDoesNotInclude: anAccountToBeAdded.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'jms 6/7/2022 17:54:45'!
canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription

	^'Unable to add an account that has already been added.'.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jms 6/8/2022 22:50:09'!
balance

	^transactions sum: [ :aTransaction | aTransaction effectOnTheBalance ] ifEmpty: [ 0 ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'jms 6/8/2022 22:45:34'!
assignFatherPortfolio: aPortfolio

	self.! !


!ReceptiveAccount methodsFor: 'private - recursion' stamp: 'jms 6/8/2022 23:39:49'!
assertAccountFrom: aPortfolioThatContainsThisAccount isNotEqualTo: anAccountToBeAdded
	"Caso base"
	
	self = anAccountToBeAdded 
			ifTrue: [
				aPortfolioThatContainsThisAccount alreadyIncludesThisReceptiveAccount.
				].! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'jms 6/8/2022 22:45:59'!
beRegisteredFrom: accountToTransferFrom to: accountToTransferTo.

	accountToTransferFrom register: withdrawLeg.
	accountToTransferTo     register: depositLeg.! !

!Transfer methodsFor: 'initialization' stamp: 'jms 6/6/2022 20:08:38'!
initializeWith: aValue
	
	value := aValue.
	
	depositLeg := TransferDeposit new initializeWith: self.
	withdrawLeg := TransferWithdraw new initializeWith: self.! !


!Transfer methodsFor: 'accessing' stamp: 'jms 6/7/2022 15:14:01'!
depositLeg

	^depositLeg.! !

!Transfer methodsFor: 'accessing' stamp: 'rb 6/5/2022 22:49:25'!
value

	^value! !

!Transfer methodsFor: 'accessing' stamp: 'jms 6/7/2022 15:14:15'!
withdrawLeg

	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'jms 6/6/2022 20:49:06'!
transfer: anAmountToBeTransfered from: accountToTransferFrom to: accountToTransferTo

	| transaction |
	
	self assertThatAnAmountToTransferIsPositive: anAmountToBeTransfered.
	self assertThatAnAccount: accountToTransferFrom isNotTheSameAccountAs: accountToTransferTo.
	
	transaction := self new initializeWith: anAmountToBeTransfered.
	
	transaction beRegisteredFrom: accountToTransferFrom to: accountToTransferTo.
	
	^transaction.! !


!Transfer class methodsFor: 'testing' stamp: 'jms 6/6/2022 20:40:48'!
assertThatAnAccount: accountToTransferFrom isNotTheSameAccountAs: accountToTransferTo.

	accountToTransferFrom = accountToTransferTo ifTrue: [ self anAccountCannotTransferAnAmountToItself. ].! !

!Transfer class methodsFor: 'testing' stamp: 'jms 6/6/2022 20:23:47'!
assertThatAnAmountToTransferIsPositive: anAmountToBeTransfered

	anAmountToBeTransfered <= 0 ifTrue: [ self canOnlyTransferPositiveAmounts ].! !


!Transfer class methodsFor: 'error' stamp: 'jms 6/6/2022 20:40:48'!
anAccountCannotTransferAnAmountToItself

	^ self error: self anAccountCannotTransferAnAmountToItselfErrorDescription! !

!Transfer class methodsFor: 'error' stamp: 'jms 6/6/2022 20:22:45'!
canOnlyTransferPositiveAmounts

	^ self error: self canOnlyTransferPositiveAmountsErrorDescription.! !


!Transfer class methodsFor: 'error description' stamp: 'jms 6/6/2022 20:42:34'!
anAccountCannotTransferAnAmountToItselfErrorDescription

	^'Unable to transfer an amount of money to itself'.
	! !

!Transfer class methodsFor: 'error description' stamp: 'jms 6/6/2022 20:24:17'!
canOnlyTransferPositiveAmountsErrorDescription

	^'Unable to transfer zero or negative amounts'.
	! !


!classDefinition: #TransferTransactions category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransactions
	instanceVariableNames: 'entireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransactions methodsFor: 'initialization' stamp: 'rb 6/5/2022 22:23:47'!
initializeWith: aTransfer

	entireTransfer := aTransfer.! !


!TransferTransactions methodsFor: 'main protocol' stamp: 'jms 6/7/2022 15:22:44'!
counterpart

	self subclassResponsibility.! !

!TransferTransactions methodsFor: 'main protocol' stamp: 'rb 6/5/2022 23:19:41'!
effectOnTheBalance
	
	self subclassResponsibility.! !

!TransferTransactions methodsFor: 'main protocol' stamp: 'rb 6/5/2022 22:50:18'!
value

	^entireTransfer value.! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'main protocol' stamp: 'jms 6/7/2022 15:16:13'!
counterpart

	^entireTransfer withdrawLeg. ! !

!TransferDeposit methodsFor: 'main protocol' stamp: 'rb 6/5/2022 23:20:22'!
effectOnTheBalance
	
	^self value.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'main protocol' stamp: 'jms 6/7/2022 15:15:51'!
counterpart

	^entireTransfer depositLeg. ! !

!TransferWithdraw methodsFor: 'main protocol' stamp: 'rb 6/5/2022 23:20:47'!
effectOnTheBalance

	^self value negated.! !
