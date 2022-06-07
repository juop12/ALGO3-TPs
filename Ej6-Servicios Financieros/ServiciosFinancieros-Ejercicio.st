!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:09:37'!
test01

	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:09:32'!
test02

	| portfolio account1 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio add: account1.
	
	self assert: portfolio balance equals: 0 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:28:19'!
test03

	| portfolio account1 |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account1. 
	portfolio add: account1.
	Withdraw register: 150 * peso on: account1.
	
	self assert: portfolio balance equals: -50 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:18:21'!
test04hasRegistered

	| portfolio account1 deposit withdraw |
	
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio add: account1.
	deposit := Deposit register: 100 * peso on: account1.
	withdraw := Withdraw register: 100 * peso on: account1.

	self assert: (portfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:43:19'!
test05transactionCopy

	| portfolio account deposit transactionsOfAccount |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account.
	deposit := Deposit register: 100 * peso on: account.
	transactionsOfAccount := portfolio transactionsOf: account.

	self assert: 1 equals: transactionsOfAccount size. 
	self assert: (transactionsOfAccount includes: deposit).! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:48:39'!
test06NowPortfoliosWithPortfolios

	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	
	self assert: portfolio1 balance equals: 0 * peso.
	self assert: portfolio2 balance equals: 0 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'jms 6/6/2022 21:52:40'!
test07NowPortfoliosWithPortfoliosAndMoney

	| portfolio1 portfolio2 portfolio3 account1 account2 account3 account4 account5 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	account5 := ReceptiveAccount new.
		
	portfolio2 add: account1.
	portfolio1 add: portfolio2.
	Deposit register: 100 * peso on: account1. 
	
	self assert: portfolio1 balance equals: 100 * peso.
	self assert: portfolio2 balance equals: 100 * peso.! !


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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'rb 6/5/2022 15:34:51'!
test01TransferDecreasesBalanceOnOneAccountAndDepositsItOnAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: -100 * peso equals: account1 balance.
	self assert:  100 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'rb 6/5/2022 15:35:05'!
test02TransferMovesMoneyFromOneAccountToTheOtherAndViceversa

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	Transfer transfer:   50 * peso from: account2 to: account1.
	
	self assert: -50 * peso equals: account1 balance.
	self assert:  50 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/6/2022 20:53:53'!
test03InATransactionTheDepositLegKnowsTheWithdrawLeg
"cambiar el assert"
	| account1 account2 transferencia |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	transferencia := Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: (account2 transactions last hasAsItsCounterpart: account1 transactions last).! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/6/2022 20:49:59'!
test04InATransactionTheWithdrawLegKnowsTheDepositLeg

	| account1 account2 transferencia |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	transferencia := Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: (account1 transactions last hasAsItsCounterpart: account2 transactions last).! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/6/2022 20:22:45'!
test05TransferCannotMove0PesosFromOneAccountToAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	self should: [Transfer transfer: 0 * peso from: account1 to: account2.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer canOnlyTransferPositiveAmountsErrorDescription equals: anError messageText ].! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/6/2022 20:47:14'!
test06TransferCannotMoveANegativeAmountFromOneAccountToAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	self should: [Transfer transfer: -100 * peso from: account1 to: account2.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer canOnlyTransferPositiveAmountsErrorDescription equals: anError messageText ].! !

!TransferTest methodsFor: 'tests' stamp: 'jms 6/6/2022 20:47:23'!
test07TransferCannotMoveAnAmountFromAnAccountToItself

	| account1 |
	
	account1 := ReceptiveAccount new.

	self should: [Transfer transfer: 10 * peso from: account1 to: account1.]
		raise: Error
		withExceptionDo: [ :anError | 
				self assert: Transfer anAccountCannotTransferAnAmountToItselfErrorDescription equals: anError messageText ].! !


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
	instanceVariableNames: 'wallet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'jms 6/6/2022 20:59:21'!
initialize

	wallet := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/6/2022 21:06:37'!
add: aReceptiveAccount 
	
	wallet add: aReceptiveAccount.! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/6/2022 21:08:53'!
balance
	^wallet sum: [ :aReceptiveAccount | aReceptiveAccount balance ] ifEmpty: [ 0 ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/6/2022 21:26:46'!
hasRegistered: aTransaction 
	"
	wallet do: [ :aReceptiveAccount | (aReceptiveAccount hasRegistered: aTransaction) ifTrue: [^true]. ].
	
	^false.
	"
	wallet 
		detect: [ :aReceptiveAccount | aReceptiveAccount hasRegistered: aTransaction ]
		ifFound: [ :aReceptiveAccount | ^true ]
		ifNone: [ ^false ].! !

!Portfolio methodsFor: 'main protocol' stamp: 'jms 6/6/2022 21:42:22'!
transactionsOf: aReceptiveAccount 
	
	(wallet includes: aReceptiveAccount) ifFalse: [self error: 'No se encontro la cuenta en el portfolio'.].
	
	^aReceptiveAccount transactions.
	
	"
	wallet 
		detect: [ :anElement | anElement = aReceptiveAccount ]
		ifFound: [ :anElement | ^anElement transactions ]
		ifNone: [ self error: 'No se encontro la cuenta en el portfolio'. ].
	"! !


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


!Transfer methodsFor: 'main protocol' stamp: 'rb 6/6/2022 00:23:21'!
matchesDepositLeg: aTransaction

	^depositLeg = aTransaction.! !

!Transfer methodsFor: 'main protocol' stamp: 'rb 6/6/2022 00:23:06'!
matchesWithdrawLeg: aTransaction

	^withdrawLeg = aTransaction.! !

!Transfer methodsFor: 'main protocol' stamp: 'rb 6/5/2022 22:49:25'!
value

	^value! !

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

!TransferDeposit methodsFor: 'main protocol' stamp: 'rb 6/5/2022 23:20:22'!
effectOnTheBalance
	
	^self value.! !

!TransferDeposit methodsFor: 'main protocol' stamp: 'rb 6/6/2022 00:28:13'!
hasAsItsCounterpart: aTransaction

	
	^entireTransfer matchesWithdrawLeg: aTransaction.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'main protocol' stamp: 'rb 6/5/2022 23:20:47'!
effectOnTheBalance

	^self value negated.! !

!TransferWithdraw methodsFor: 'main protocol' stamp: 'rb 6/6/2022 01:01:13'!
hasAsItsCounterpart: aTransaction

	^entireTransfer matchesDepositLeg: aTransaction. ! !
