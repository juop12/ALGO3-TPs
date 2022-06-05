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

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/4/2022 23:21:34'!
test01TransferenceDecreasesBalanceOnOneAccountAndDepositsItOnAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: -100 * peso equals: account1 balance.
	self assert:  100 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/4/2022 23:21:34'!
test02TransferenceMovesMoneyFromOneAccountToTheOtherAndViceversa

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	Transfer transfer:   50 * peso from: account2 to: account1.
	
	self assert: -50 * peso equals: account1 balance.
	self assert:  50 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:51:14'!
test03

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: (account1 lastTransaction isLinkedTo: account2 lastTransaction).! !


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


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
Deposit subclass: #TransferDeposit
	instanceVariableNames: 'parallelTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:51:32'!
isLinkedTo: aTransaction

	^parallelTransaction = aTransaction.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:45:54'!
linkTo: aTransaction

	parallelTransaction := aTransaction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: 'ServiciosFinancieros-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:24:27'!
with: aValue

	^self new initializeFor: aValue.! !


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


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
Withdraw subclass: #TransferWithdraw
	instanceVariableNames: 'parallelTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:51:41'!
isLinkedTo: aTransaction

	^parallelTransaction = aTransaction.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:46:10'!
linkTo: aTransaction

	parallelTransaction := aTransaction.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: 'ServiciosFinancieros-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:25:05'!
with: aValue

	^self new initializeFor: aValue.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'jms 6/2/2022 21:26:24'!
balance

	^transactions sum: [ :aTransaction | aTransaction effectOnTheBalance ] ifEmpty: [ 0 ]
	
	" (aTransaction isKindOf: Deposit) ifTrue: [ aTransaction value ] ifFalse: [ aTransaction value negated ] "! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'rb 6/5/2022 01:03:41'!
lastTransaction
	^self transactions last.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'category-name' stamp: 'rb 6/3/2022 18:34:47'!
assertAValueIsNot0: aValue

	^ aValue = 0 ifTrue: [ self error: self class canNotTransfer0PesosErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error descriptions' stamp: 'rb 6/3/2022 18:29:16'!
canNotTransfer0PesosErrorDescription

	^'Cant transfer 0 pesos' ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:49:13'!
transfer: aValue from: accountToTransferFrom to: accountToTransferTo

	| depositTransaction withdrawTransaction |
	
	depositTransaction   := TransferDeposit    with: aValue.
	withdrawTransaction := TransferWithdraw with: aValue.
	
	depositTransaction   linkTo: withdrawTransaction.
	withdrawTransaction linkTo: depositTransaction.
	
	accountToTransferFrom register: withdrawTransaction.
	accountToTransferTo     register: depositTransaction.! !


!classDefinition: #TransferTransactions category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransactions
	instanceVariableNames: 'value counterpart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!classDefinition: #TransferDepositEx category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferDepositEx
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDepositEx methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 01:27:01'!
initializeFor: aValue

	value := aValue! !


!classDefinition: #TransferWithdrawEx category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferWithdrawEx
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!
