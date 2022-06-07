!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio_1 account_1 portfolio_2 portfolio_3 account_2 account_4 account_5 account_3 deposit_1 deposit_2 deposit_3'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/7/2022 18:44:22'!
test01

	portfolio_1 add: account_1.
	
	self should: [portfolio_1 add: account_1]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/7/2022 18:06:59'!
test02

	self prepForTesting06y07y08.
	
	self should: [ portfolio_1 add: account_5 ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/7/2022 18:44:33'!
test03
	
	self should: [ portfolio_1 add: portfolio_1 ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/7/2022 19:46:54'!
test03_5
	
	| portfolio_4 portfolio_5 |
	
	portfolio_4 := Portfolio new.
	portfolio_5 := Portfolio new.
	
	portfolio_1 add: portfolio_2.
	portfolio_2 add: portfolio_3.
	portfolio_3 add: portfolio_4.
	portfolio_4 add: portfolio_5.
	portfolio_5 add: account_1.
	
	self should: [ portfolio_5 add: portfolio_1 ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/7/2022 18:51:35'!
test04

	portfolio_1 add: account_1.
	portfolio_1 add: portfolio_2.
	portfolio_1 add: account_2.
	portfolio_2 add: account_3.
	
	self should: [ portfolio_2 add: account_1 ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !

!PortfolioTest methodsFor: 'extra - tests' stamp: 'jms 6/7/2022 19:51:52'!
test06

	portfolio_1 add: account_1.
	portfolio_1 add: account_2.
	portfolio_2 add: account_1.
	portfolio_2 add: account_3.
	
	self should: [ portfolio_1 add: portfolio_2 ]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Portfolio canNotAddAnAccountThatHasAlreadyBeenAddedErrorDescription equals: anError messageText ].! !


!PortfolioTest methodsFor: 'setup' stamp: 'jms 6/7/2022 17:30:03'!
setUp

	portfolio_1 := Portfolio new.
	portfolio_2 := Portfolio new.
	portfolio_3 := Portfolio new.
	
	account_1 := ReceptiveAccount new.
	account_2 := ReceptiveAccount new.
	account_3 := ReceptiveAccount new.
	account_4 := ReceptiveAccount new.
	account_5 := ReceptiveAccount new.
	
	deposit_1 := Deposit register: 100 * peso on: account_2. 
	deposit_2 := Deposit register: 100 * peso on: account_3. 
	deposit_3 := Deposit register: 100 * peso on: account_5. ! !


!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:30:03'!
test01PortfolioCanAddAnAccountWithZeroAsBalance
	
	portfolio_1 add: account_1.	
	
	self assert: 0* peso equals: portfolio_1 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:41:25'!
test02TransactionsChangesBalanceValueInPortfolio
	
	portfolio_1 add: account_1.	
	
	self depositAHundredPesosOnAccount_1. 
	self withdrawAHundredAndFiftyPesosOfAccount_1.
	
	self assert: -50 * peso equals: portfolio_1 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:41:26'!
test03PortfolioKnowsRegisteredTransactionsOfAllTheAccountsItContains

	| withdraw |

	portfolio_1 add: account_1.	
	
	deposit_1 := self depositAHundredPesosOnAccount_1.
	withdraw := self withdrawAHundredAndFiftyPesosOfAccount_1.

	self assert: (portfolio_1 hasRegistered: deposit_1).
	self assert: (portfolio_1 hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:39:23'!
test04transactionCopy
	
	portfolio_1 add: account_1.	

	deposit_1 := self depositAHundredPesosOnAccount_1.

	self assert: 1 equals: portfolio_1 transactions size. 
	self assert: (portfolio_1 transactions includes: deposit_1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:30:03'!
test05NowPortfoliosWithPortfolios
	
	portfolio_2 add: account_1.
	portfolio_1 add: portfolio_2.
	
	self assert: 0 * peso equals: portfolio_1 balance.
	self assert: 0 * peso equals: portfolio_2 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:40:29'!
test06NowPortfoliosWithPortfoliosAndMoney
		
	self prepForTesting06y07y08.
	
	self assert: 300 * peso equals: portfolio_1 balance.
	self assert: 200 * peso equals: portfolio_2 balance.
	self assert: 100 * peso equals: portfolio_3 balance.
	"tremendo!!"
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:40:29'!
test07NowPortfoliosWithPortfoliosAndMoneyRegistered
		
	self prepForTesting06y07y08.
	
	self assert: (portfolio_1 hasRegistered: deposit_3).
	self assert: (portfolio_1 hasRegistered: deposit_2).
	self assert: (portfolio_1 hasRegistered: deposit_1).
	
	self assert: (portfolio_2 hasRegistered: deposit_3).
	self assert: (portfolio_2 hasRegistered: deposit_2).
	
	self assert: (portfolio_3 hasRegistered: deposit_3).
	"tremendo!!"
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:40:29'!
test08transactionCollectionNowPortfoliosWithPortfoliosAndMoney
		
	self prepForTesting06y07y08.

	self assert: 3 equals: portfolio_1 transactions size.
	self assert: (portfolio_1 transactions includes: deposit_1).
	self assert: (portfolio_1 transactions includes: deposit_2).
	self assert: (portfolio_1 transactions includes: deposit_3).

	self assert: 2 equals: portfolio_2 transactions size.
	self assert: (portfolio_2 transactions includes: deposit_2).
	self assert: (portfolio_2 transactions includes: deposit_3).

	self assert: 1 equals: portfolio_3 transactions size.
	self assert: (portfolio_3 transactions includes: deposit_3).
	"tremendo!!"
	
	
	! !


!PortfolioTest methodsFor: 'private' stamp: 'jms 6/7/2022 17:36:16'!
depositAHundredPesosOnAccount_1

	^ Deposit register: 100 * peso on: account_1.! !

!PortfolioTest methodsFor: 'private' stamp: 'jms 6/7/2022 17:40:29'!
prepForTesting06y07y08

	portfolio_1 add: account_1.
	portfolio_1 add: portfolio_2.
	portfolio_1 add: account_2.
	portfolio_2 add: account_3.
	portfolio_2 add: portfolio_3.
	portfolio_2 add: account_4.
	portfolio_3 add: account_5! !

!PortfolioTest methodsFor: 'private' stamp: 'jms 6/7/2022 17:41:25'!
withdrawAHundredAndFiftyPesosOfAccount_1

	^ Withdraw register: 150 * peso on: account_1! !


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


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'account01 account02'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 15:19:33'!
test01TransferDecreasesBalanceOnOneAccountAndDepositsItOnAnother

	Transfer transfer: 100 * peso from: account01 to: account02.
	
	self assert: -100 * peso equals: account01 balance.
	self assert:  100 * peso equals: account02 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 15:19:42'!
test02TransferMovesMoneyFromOneAccountToTheOtherAndViceversa

	Transfer transfer: 100 * peso from: account01 to: account02.
	Transfer transfer:   50 * peso from: account02 to: account01.
	
	self assert: -50 * peso equals: account01 balance.
	self assert:  50 * peso equals: account02 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:06:03'!
test03InATransactionTheDepositLegKnowsTheWithdrawLeg

	| transfer |

	transfer := Transfer transfer: 100 * peso from: account01 to: account02.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg counterpart.
	"self assert: (account2 transactions last hasAsItsCounterpart: account1 transactions last)."
	
	"Seguimos teniendo los msjs que hacen que pase el test comentado, los dejamos por las dudas por ahora."! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 17:05:44'!
test04InATransactionTheWithdrawLegKnowsTheDepositLeg

	| transfer |

	transfer := Transfer transfer: 100 * peso from: account01 to: account02.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg counterpart.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 15:20:16'!
test05TransferCannotMove0PesosFromOneAccountToAnother

	self should: [Transfer transfer: 0 * peso from: account01 to: account02.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer canOnlyTransferPositiveAmountsErrorDescription equals: anError messageText ].! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 15:20:52'!
test06TransferCannotMoveANegativeAmountFromOneAccountToAnother

	self should: [Transfer transfer: -100 * peso from: account01 to: account02.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer canOnlyTransferPositiveAmountsErrorDescription equals: anError messageText ].! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/7/2022 15:21:00'!
test07TransferCannotMoveAnAmountFromAnAccountToItself

	self should: [Transfer transfer: 10 * peso from: account01 to: account01.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer anAccountCannotTransferAnAmountToItselfErrorDescription equals: anError messageText ].! !


!TransferTest methodsFor: 'setup' stamp: 'jms 6/7/2022 15:19:16'!
setUp

	account01 :=	 ReceptiveAccount new.
	account02 := ReceptiveAccount new.! !


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


!Portfolio methodsFor: 'initialization' stamp: 'jms 6/7/2022 19:07:32'!
initialize

	wallet := OrderedCollection new.
	fatherPortfolio := nil.! !


!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/7/2022 19:08:30'!
add: anAccountToBeAdded

	self preAssertPortfolioDoesNotInclude: anAccountToBeAdded.
	
	anAccountToBeAdded assignFatherPortfolio: self.
	wallet add: anAccountToBeAdded.! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/7/2022 18:34:16'!
balance

	^wallet sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/7/2022 18:34:32'!
hasRegistered: aTransaction 
	"
	wallet do: [ :aReceptiveAccount | (aReceptiveAccount hasRegistered: aTransaction) ifTrue: [^true]. ].
	
	^false.
	"
	wallet 
		detect: [ :anAccount | anAccount hasRegistered: aTransaction ]
		ifFound: [ :anAccount | ^true ]
		ifNone: [ ^false ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/7/2022 16:35:28'!
transactions

	| transactions |

	transactions := OrderedCollection new.

	wallet do: [ :anAccount | transactions addAll: anAccount transactions ].
	
	^transactions.! !


!Portfolio methodsFor: 'testing' stamp: 'jms 6/7/2022 20:10:08'!
assertPortfolioDoesNotInclude: anAccountToBeAdded

	self = anAccountToBeAdded ifTrue: [ self canNotAddAnAccountThatHasAlreadyBeenAdded ].

	wallet do: [ :anAccount | anAccount assertAccountFrom: self isNotEqualTo: anAccountToBeAdded.			].	
	! !


!Portfolio methodsFor: 'private' stamp: 'jms 6/7/2022 18:57:41'!
assignFatherPortfolio: aFatherPortfolio

	fatherPortfolio := aFatherPortfolio.! !

!Portfolio methodsFor: 'private' stamp: 'jms 6/7/2022 19:34:44'!
getOldestFather

	fatherPortfolio = nil ifTrue: [ ^self. ].
	
	^fatherPortfolio getOldestFather.! !

!Portfolio methodsFor: 'private' stamp: 'jms 6/7/2022 20:06:47'!
preAssertPortfolioDoesNotInclude: anAccountToBeAdded

	self getOldestFather assertPortfolioDoesNotInclude: anAccountToBeAdded.

	(anAccountToBeAdded isKindOf: Portfolio) ifTrue: [
			anAccountToBeAdded wallet do: [ :anAccount |
					self preAssertPortfolioDoesNotInclude: anAccount.
				].
		]
	
	
	"self getOldestFather assertPortfolioDoesNotInclude: anAccountToBeAdded."! !


!Portfolio methodsFor: 'private - accessing' stamp: 'jms 6/7/2022 20:04:53'!
wallet 

	^wallet.! !


!Portfolio methodsFor: 'private - recursion' stamp: 'jms 6/7/2022 18:42:29'!
alreadyIncludesThisReceptiveAccount

	self canNotAddAnAccountThatHasAlreadyBeenAdded.

! !

!Portfolio methodsFor: 'private - recursion' stamp: 'jms 6/7/2022 19:40:27'!
assertAccountFrom: aPortfolio isNotEqualTo: anAccountToBeAdded
	"Llamado recursivo."
	"Lo llamas para el otro portfolio, por eso el self."

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


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jms 6/6/2022 21:11:36'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'jms 6/7/2022 18:57:09'!
assignFatherPortfolio: aPortfolio
	
	self.! !


!ReceptiveAccount methodsFor: 'private - recursion' stamp: 'jms 6/7/2022 18:42:23'!
assertAccountFrom: aPortfolio isNotEqualTo: anAccount
	"Caso base"
	
	self = anAccount 
			ifTrue: [
				aPortfolio alreadyIncludesThisReceptiveAccount.
				].! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'rb 6/5/2022 22:47:28'!
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


!Transfer methodsFor: 'main protocol' stamp: 'rb 6/6/2022 00:23:21'!
matchesDepositLeg: aTransaction

	^depositLeg = aTransaction.! !

!Transfer methodsFor: 'main protocol' stamp: 'rb 6/6/2022 00:23:06'!
matchesWithdrawLeg: aTransaction

	^withdrawLeg = aTransaction.! !

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

!TransferTransactions methodsFor: 'main protocol' stamp: 'rb 6/6/2022 00:04:36'!
hasAsItsCounterpart: aTransaction

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

!TransferDeposit methodsFor: 'main protocol' stamp: 'jms 6/7/2022 15:16:05'!
hasAsItsCounterpart: aTransaction

	^entireTransfer matchesWithdrawLeg: aTransaction.! !


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

!TransferWithdraw methodsFor: 'main protocol' stamp: 'rb 6/6/2022 01:01:13'!
hasAsItsCounterpart: aTransaction

	^entireTransfer matchesDepositLeg: aTransaction. ! !
