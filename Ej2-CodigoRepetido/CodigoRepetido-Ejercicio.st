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

!CustomerBookTest methodsFor: 'testing' stamp: 'RB 5/1/2022 17:40:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	self should: [customerBook addCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 50 milliSeconds.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:32:13'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'.] notTakeMoreThan: 100 milliSeconds.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:24:57'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self should: [customerBook addCustomerNamed: '']
		raise: Error 
		withExceptionDo: [:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty].
		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:27:58'!
test04CanNotRemoveAnInvalidCustomer
	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'John Lennon'.

	self should: [customerBook removeCustomerNamed: 'Paul McCartney']
     	       raise: NotFound
	       withExceptionDo: [ :anError | 
			self assertOnlyCustomerIn: customerBook Is: 'John Lennon'.]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:23:57'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	
	self assertDataOf: customerBook with: 0 with: 1 with: 1. 
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:23:45'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assertDataOf: customerBook with: 0 with: 0 with: 0. 
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:28:46'!
test07CanNotSuspendAnInvalidCustomer
	| customerBook |
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'John Lennon'.
	self should: [customerBook suspendCustomerNamed: 'Ringo Starr']
		 raise: CantSuspend
		 withExceptionDo: [ :anError | 
			self assertOnlyCustomerIn: customerBook Is: 'John Lennon'.]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 20:28:50'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	| customerBook |
	customerBook := CustomerBook new.
	self addAndSuspend: 'John Lennon' From: customerBook.
	self should: [customerBook suspendCustomerNamed: 'John Lennon']
		raise: CantSuspend
		withExceptionDo: [ :anError | 
			self assertOnlyCustomerIn: customerBook Is: 'John Lennon'.]

! !


!CustomerBookTest methodsFor: 'private' stamp: 'jms 5/1/2022 20:30:36'!
addAndSuspend: aCustomer From: customerBook
	customerBook addCustomerNamed: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.! !

!CustomerBookTest methodsFor: 'private' stamp: 'jms 5/1/2022 20:31:04'!
assertDataOf: customerBook with: numberOfActive with: numberOfSuspended with: totalNumber
	self assert: numberOfActive equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspended equals: customerBook numberOfSuspendedCustomers.
	self assert: totalNumber equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'private' stamp: 'jms 5/1/2022 20:30:56'!
assertOnlyCustomerIn: customerBook Is: aCustomer

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: aCustomer).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'jms 5/1/2022 20:36:16'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'jms 5/1/2022 20:36:20'!
isEmpty

	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'jms 5/1/2022 20:36:29'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:32:43'!
addCustomerNamed: aName
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:32:52'!
numberOfActiveCustomers
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:32:58'!
numberOfCustomers
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:33:01'!
numberOfSuspendedCustomers
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:33:08'!
removeCustomerNamed: aName 
	^active remove: aName ifAbsent: 
		[suspended remove: aName ifAbsent: [^NotFound signal.]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:33:20'!
signalCustomerAlreadyExists 
	self error: self class customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:33:28'!
signalCustomerNameCannotBeEmpty 
	self error: self class customerCanNotBeEmptyErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 20:35:36'!
suspendCustomerNamed: aName 
	active detect: [:customerName | customerName = aName] 
		ifFound: [:name | active remove: name. suspended add: name] 
		ifNone: [^CantSuspend signal].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'jms 5/1/2022 20:30:13'!
customerAlreadyExistsErrorMessage
	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'jms 5/1/2022 20:30:06'!
customerCanNotBeEmptyErrorMessage
	^'Customer Name Cannot Be Empty'! !
