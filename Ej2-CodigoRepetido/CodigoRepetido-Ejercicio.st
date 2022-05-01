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

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 01:07:21'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertTimeSpentDoing: [customerBook addCustomerNamed: 'John Lennon'.] isLessThan: 50.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 01:12:08'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	customerBook addCustomerNamed: 'Paul McCartney'.
	
	self assertTimeSpentDoing: [customerBook removeCustomerNamed: 'Paul McCartney'.] isLessThan: 100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 01:43:18'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self value: [ customerBook addCustomerNamed: ''. self fail ] do: [ :anError | self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. self assert: customerBook isEmpty ] ifError: Error

	"[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]"! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 01:37:19'!
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
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 02:35:07'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	
	self assertDataOf: customerBook From: #(0 1 1). 
	self assert: (customerBook includesCustomerNamed: 'Paul McCartney').
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jms 5/1/2022 02:35:20'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self addAndSuspend: 'Paul McCartney' From: customerBook.
	customerBook removeCustomerNamed: 'Paul McCartney'.
	
	self assertDataOf: customerBook From: #(0 0 0). 
	self deny: (customerBook includesCustomerNamed: 'Paul McCartney').


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 4/30/2020 09:08:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'Ringo Starr'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'Probando' stamp: 'jms 5/1/2022 01:42:00'!
value: aClosure do: aClosureOnError ifError: error 
	
	aClosure
		on: error 
		do: aClosureOnError! !


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


!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 01:33:03'!
addCustomerNamed: aName

	"Si es un string vacio -> Error."
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	
	""
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
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

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 02:44:39'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'jms 5/1/2022 02:44:22'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
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
