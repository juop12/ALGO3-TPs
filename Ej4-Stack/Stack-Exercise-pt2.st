!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMS 5/10/2022 21:12:10'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMS 5/10/2022 21:12:10'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'JMS 5/10/2022 21:12:10'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMS 5/10/2022 21:12:10'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMS 5/10/2022 21:12:10'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder prefixWithLowerCases prefixWithUpperCases prefixWithUpperAndLowerCases prefixWithSpaces prefixBeginningWithSpace prefixEndingWithSpace emptyPrefix emptyStack stackWithOneElement stackWithManyElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'RB 5/13/2022 18:49:06'!
setUp
	
	prefixWithLowerCases := 'dummyprefix'.
	prefixWithUpperCases := 'DUMMYPREFIX'.
	prefixWithUpperAndLowerCases := 'DummyPrefix'.
	prefixWithSpaces := 'dummy prefix'.
	prefixBeginningWithSpace := ' dummyprefix'.
	prefixEndingWithSpace := 'dummyprefix '.
	emptyPrefix := ''.
	
	emptyStack := OOStack new.
	stackWithOneElement := OOStack new.
	stackWithManyElements := OOStack new.
	
	"pensar si borrar stackWithOneElement."
		
	"Si testeas estos 3 te tienen que tirar True"
	stackWithManyElements push: prefixWithLowerCases.
	stackWithManyElements push: prefixWithUpperCases.
	stackWithManyElements push: prefixWithUpperAndLowerCases.
	stackWithManyElements push: 'dummytext'.
	
	"Si testeas estos 4 te tienen que tirar False"
	stackWithManyElements push: prefixWithSpaces.
	stackWithManyElements push: prefixBeginningWithSpace.
	"stackWithManyElements push: prefixEndingWithSpace."
	stackWithManyElements push: emptyPrefix.
	stackWithManyElements push: 'dummytext'.
	
	
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'RB 5/13/2022 18:08:07'!
test01FinderShouldReturnAnEmptyListIfTheStackIsEmpty
	
	| emptyCollection | 
	
	emptyCollection := SentenceFinderByPrefix new find: prefixWithLowerCases in: emptyStack.
	
	self assert: emptyCollection size equals: 0.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'RB 5/13/2022 18:48:43'!
test02FinderShouldReturnAListWithOneElementIfThereIsOnlyOneMatchInTheStack
	
	| matchingCollection expectedCollection | 
	
	
	matchingCollection := SentenceFinderByPrefix new find: 'dummypre' in: stackWithManyElements.
	
	expectedCollection := OrderedCollection new.
	
	expectedCollection add: 'dummyprefix'.
	"expectedCollection add: 'dummyprefix '."
	
	self assert: (expectedCollection includesAllOf: matchingCollection ).
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'JMS 5/12/2022 20:38:52'!
checkHowToBehave

	"switch dinamico"
	OOStack subclasses 
		detect: [ :subclass | subclass canInstantiateAnState: stack]
		ifFound: [ :subclass | ^subclass new]
		ifNone: [self].
	
	"
	| temp |
	
	temp := OOStack subclasses
				detect: [ :subclass | subclass includes: stack].
	
	^temp new.	
	"
	
	"
	stack isEmpty ifTrue: [^Empty new].
	^Real new.
	"! !


!OOStack methodsFor: 'initialization' stamp: 'JMS 5/9/2022 22:00:05'!
initialize

	stack := OrderedCollection new.! !


!OOStack methodsFor: 'accessing' stamp: 'JMS 5/10/2022 20:25:27'!
isEmpty
	
	^stack isEmpty.! !

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/9/2022 22:32:20'!
size

	^stack size.
	! !

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/10/2022 21:13:32'!
top

	^self checkHowToBehave top: stack.
	! !



!OOStack methodsFor: 'operations' stamp: 'JMS 5/10/2022 21:13:32'!
pop
	
	^self checkHowToBehave pop: stack.! !

!OOStack methodsFor: 'operations' stamp: 'JMS 5/9/2022 22:08:35'!
push: aString 

	^stack add: aString.! !


!OOStack methodsFor: 'error' stamp: 'JMS 5/10/2022 20:17:50'!
stackEmpty

	self error: self class stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #ErrorStack category: 'Stack-Exercise'!
OOStack subclass: #ErrorStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ErrorStack methodsFor: 'initialization' stamp: 'JMS 5/10/2022 20:30:08'!
initialize

	self
	! !


!ErrorStack methodsFor: 'operations' stamp: 'JMS 5/10/2022 20:33:31'!
pop: anStack
	
	self stackEmpty.! !

!ErrorStack methodsFor: 'operations' stamp: 'JMS 5/10/2022 20:33:13'!
top: anStack
	
	self stackEmpty.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErrorStack class' category: 'Stack-Exercise'!
ErrorStack class
	instanceVariableNames: ''!

!ErrorStack class methodsFor: 'verification - private' stamp: 'JMS 5/12/2022 20:38:52'!
canInstantiateAnState: anStack
	
	^anStack isEmpty.	! !


!classDefinition: #RealStack category: 'Stack-Exercise'!
OOStack subclass: #RealStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!RealStack methodsFor: 'initialization' stamp: 'JMS 5/10/2022 20:30:17'!
initialize
	
	self! !


!RealStack methodsFor: 'operations' stamp: 'JMS 5/10/2022 20:34:01'!
pop: anStack
	
	^anStack removeLast.! !

!RealStack methodsFor: 'operations' stamp: 'JMS 5/10/2022 20:33:50'!
top: anStack
	
	^anStack last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RealStack class' category: 'Stack-Exercise'!
RealStack class
	instanceVariableNames: ''!

!RealStack class methodsFor: 'verification - private' stamp: 'JMS 5/12/2022 20:38:52'!
canInstantiateAnState: anStack
	
	^anStack isEmpty not	.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'operation' stamp: 'RB 5/13/2022 18:17:52'!
find: aPrefix in: aStack
	| matchesCollection auxiliarStack |
	
	auxiliarStack := OOStack new.
	matchesCollection  := OrderedCollection new.
	
	aStack size timesRepeat: [
		auxiliarStack push: aStack pop.
		(auxiliarStack top beginsWith: aPrefix) ifTrue: [matchesCollection add: auxiliarStack top].
		].
	
	auxiliarStack size timesRepeat: 
		[aStack push: auxiliarStack pop.].
	
	^matchesCollection.
	
	! !
