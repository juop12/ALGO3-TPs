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

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 15:34:51'!
test01TransferDecreasesBalanceOnOneAccountAndDepositsItOnAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: -100 * peso equals: account1 balance.
	self assert:  100 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 15:35:05'!
test02TransferMovesMoneyFromOneAccountToTheOtherAndViceversa

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	Transfer transfer:   50 * peso from: account2 to: account1.
	
	self assert: -50 * peso equals: account1 balance.
	self assert:  50 * peso equals: account2 balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/6/2022 00:25:04'!
test03TransferTransactionsKnowTheirCounterpart

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Transfer transfer: 100 * peso from: account1 to: account2.
	
	self assert: (account1 transactions last hasAsItsCounterpart: account2 transactions last).
	self assert: (account2 transactions last hasAsItsCounterpart: account1 transactions last).! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 15:24:48'!
test04TransferCannotMoveANegativeAmountFromOneAccountToAnother

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	self should: [Transfer transfer: -100 * peso from: account1 to: account2.]
		raise: Error
		withExceptionDo: [ :anError | self assert: Transfer cannotTranserNegativeValuesErrorDescription equals: anError messageText ].! !


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


!classDefinition: #TransferDepositEx category: 'ServiciosFinancieros-Ejercicio'!
Deposit subclass: #TransferDepositEx
	instanceVariableNames: 'parallelTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDepositEx methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:51:32'!
isLinkedTo: aTransaction

	^parallelTransaction = aTransaction.! !

!TransferDepositEx methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:45:54'!
linkTo: aTransaction

	parallelTransaction := aTransaction.! !


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


!classDefinition: #TransferWithdrawEx category: 'ServiciosFinancieros-Ejercicio'!
Withdraw subclass: #TransferWithdrawEx
	instanceVariableNames: 'parallelTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdrawEx methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:51:41'!
isLinkedTo: aTransaction

	^parallelTransaction = aTransaction.! !

!TransferWithdrawEx methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 02:46:10'!
linkTo: aTransaction

	parallelTransaction := aTransaction.! !


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

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'rb 6/5/2022 15:08:10'!
lastTransaction

	^self transactions last.! !

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

!Transfer methodsFor: 'initialization' stamp: 'rb 6/5/2022 22:26:24'!
initializeWith: aValue
	
	value := aValue.
	
	depositLeg   := TransferDeposit     new initializeWith: self.
	withdrawLeg := TransferWithdraw new initializeWith: self.! !

!Transfer methodsFor: 'initialization' stamp: 'rb 6/6/2022 00:23:21'!
matchesDepositLeg: aTransaction

	^depositLeg = aTransaction.! !

!Transfer methodsFor: 'initialization' stamp: 'rb 6/6/2022 00:23:06'!
matchesWithdrawLeg: aTransaction

	^withdrawLeg = aTransaction.! !

!Transfer methodsFor: 'initialization' stamp: 'rb 6/5/2022 22:49:25'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 15:33:37'!
assertThatAValueIsPositive: aValue

	aValue > 0 ifFalse:[self error: self cannotTranserNegativeValuesErrorDescription].! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 15:31:55'!
cannotTranserNegativeValuesErrorDescription

	^'Unable to transfer a negative amount'.
	! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 15:05:37'!
linkTransactions: transaction1 and: transaction2

	transaction1 linkTo: transaction2.
	transaction2 linkTo: transaction1.
	! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 22:46:36'!
transfer: aValue from: accountToTransferFrom to: accountToTransferTo

	| transaction |
	
	self assertThatAValueIsPositive: aValue.
	
	transaction := self new initializeWith: aValue.
	
	transaction beRegisteredFrom: accountToTransferFrom to: accountToTransferTo.
	"
	| depositTransaction withdrawTransaction |
	
	depositTransaction   := TransferDepositEx    for: aValue.
	withdrawTransaction := TransferWithdrawEx for: aValue.
	
	self linkTransactions: depositTransaction and: withdrawTransaction.
	
	accountToTransferFrom register: withdrawTransaction.
	accountToTransferTo     register: depositTransaction.
	"! !


!classDefinition: #TransferTransactions category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #TransferTransactions
	instanceVariableNames: 'entireTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTransactions methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 22:51:30'!
counterpart

	self subclassResponsibility.! !

!TransferTransactions methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 23:19:41'!
effectOnTheBalance
	
	self subclassResponsibility.! !

!TransferTransactions methodsFor: 'as yet unclassified' stamp: 'rb 6/6/2022 00:04:36'!
hasAsItsCounterpart: aTransaction

	self subclassResponsibility.! !

!TransferTransactions methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 22:23:47'!
initializeWith: aTransfer

	entireTransfer := aTransfer.! !

!TransferTransactions methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 22:50:18'!
value

	^entireTransfer value.! !


!classDefinition: #TransferDeposit category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 23:20:22'!
effectOnTheBalance
	
	^self value.! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'rb 6/6/2022 00:28:13'!
hasAsItsCounterpart: aTransaction

	
	^entireTransfer matchesWithdrawLeg: aTransaction.! !


!classDefinition: #TransferWithdraw category: 'ServiciosFinancieros-Ejercicio'!
TransferTransactions subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'rb 6/5/2022 23:20:47'!
effectOnTheBalance

	^self value negated.! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'rb 6/6/2022 01:01:13'!
hasAsItsCounterpart: aTransaction

	^entireTransfer matchesDepositLeg: aTransaction. ! !
