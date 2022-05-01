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

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:42:37'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 50 milliSeconds.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:30:09'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 100 milliSeconds.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:43:28'!
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

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:50:49'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]

"self assert: customerBook numberOfCustomers = 1.
self assert: (customerBook includesCustomerNamed: 'John Lennon') "! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:01:03'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	
	self assertDataOf: customerBook with: 0 with: 1 with: 1. 
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:01:17'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assertDataOf: customerBook with: 0 with: 0 with: 0. 
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 15:44:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.

	customerBook addCustomerNamed: 'John Lennon'.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 13:48:56'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := CustomerBook new.

	self addAndSuspend: 'John Lennon' From: customerBook.
	
	[ customerBook suspendCustomerNamed: 'John Lennon'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: 'John Lennon') ]
! !



!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 02:21:00'!
addAndSuspend: aCustomer From: customerBook
	
	customerBook addCustomerNamed: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.! !

!CustomerBookTest methodsFor: 'extraMessages' stamp: 'jms 5/1/2022 14:59:58'!
assertDataOf: customerBook with: numberOfActive with: numberOfSuspended with: totalNumber

self assert: numberOfActive equals: customerBook numberOfActiveCustomers.
self assert: numberOfSuspended equals: customerBook numberOfSuspendedCustomers.
self assert: totalNumber equals: customerBook numberOfCustomers.
! !


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
