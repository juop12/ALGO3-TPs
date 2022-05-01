!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 01:44:31'!
Do: messageWithError ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:40:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	self should: [customerBook addCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 50 milliSeconds.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:41:23'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'Paul McCartney'.
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 100 milliSeconds.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:42:17'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: '']
	
		raise: Error 
		withExceptionDo: [:anError | 
			
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			
			self assert: customerBook isEmpty].
		
	"[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]"
		
		! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:39:28'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'John Lennon'.

	self should: [customerBook removeCustomerNamed: 'Paul McCartney']
	
     	       raise: NotFound
	
	       withExceptionDo: [ :anError | self assertOnlyCustomerIn: customerBook Is: 'John Lennon'.]
				
	"
	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
		"

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:43:23'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	
	self assertDataOf: customerBook with: 0 with: 1 with: 1. 
	
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:44:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assertDataOf: customerBook with: 0 with: 0 with: 0. 
	
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:38:48'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	self should: [customerBook suspendCustomerNamed: 'Ringo Starr']
	
		 raise: CantSuspend
		
		 withExceptionDo: [ :anError | self assertOnlyCustomerIn: customerBook Is: 'John Lennon'.]
"
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]"
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:40:08'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook |
	customerBook := CustomerBook new.
	self addAndSuspend: 'John Lennon' From: customerBook.
	self should: [customerBook suspendCustomerNamed: 'John Lennon']
	
		raise: CantSuspend
		
		withExceptionDo: [ :anError | self assertOnlyCustomerIn: customerBook Is: 'John Lennon'.]
"	[ customerBook suspendCustomerNamed: 'John Lennon'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]"
! !


!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 00:15:00'!
actualTime 
	
	^Time millisecondClockValue * millisecond.
	
	
	! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 02:21:00'!
addAndSuspend: aCustomer From: customerBook
	
	customerBook addCustomerNamed: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 02:17:11'!
assertDataOf: customerBook From: aCollection

self assert: (aCollection at: 1) equals: customerBook numberOfActiveCustomers.
self assert: (aCollection at: 2) equals: customerBook numberOfSuspendedCustomers.
self assert: (aCollection at: 3) equals: customerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 14:59:58'!
assertDataOf: customerBook with: numberOfActive with: numberOfSuspended with: totalNumber

self assert: numberOfActive equals: customerBook numberOfActiveCustomers.
self assert: numberOfSuspended equals: customerBook numberOfSuspendedCustomers.
self assert: totalNumber equals: customerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'RB 5/1/2022 17:29:35'!
assertOnlyCustomerIn: customerBook Is: aCustomer
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: aCustomer).! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 01:06:17'!
assertTimeSpentDoing: aClosure isLessThan: aNumber 
	
	self assert: (self timeSpentDoing: aClosure) < (aNumber * millisecond)! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 00:24:18'!
diferenceInTimeBetween: startTime And: finishTime
	
	^(finishTime-startTime)! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 00:25:36'!
timeSpentDoing: aClosure
	
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := self actualTime.
	aClosure value.
	millisecondsAfterRunning := self actualTime.
	
	^self diferenceInTimeBetween: millisecondsBeforeRunning And: millisecondsAfterRunning. 
	
	
	
	! !


!CustomerBookTest methodsFor: 'Probando' stamp: 'jms 5/1/2022 01:42:00'!
value: aClosure do: aClosureOnError ifError: error 
	
	aClosure
		on: error 
		do: aClosureOnError! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 15:46:54'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 02:35:39'!
numberOfCustomers

	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 15:13:53'!
removeCustomerNamed: aName 
 	
	^active remove: aName ifAbsent: 
		[suspended remove: aName ifAbsent: [^NotFound signal.]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 14:06:39'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 02:44:22'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 14:35:38'!
suspendCustomerNamed: aName 
	
	active detect: [:aux | aux = aName] ifFound: [:name | active remove: name. suspended add: name] ifNone: [^CantSuspend signal].

	
	
	
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
