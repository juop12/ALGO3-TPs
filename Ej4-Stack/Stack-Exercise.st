!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'JMS 5/14/2022 19:24:58'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'JMS 5/14/2022 19:26:10'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty
	! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'JMS 5/10/2022 21:12:10'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'JMS 5/14/2022 19:27:09'!
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

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'JMS 5/10/2022 21:12:10'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'JMS 5/14/2022 19:51:47'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test - with unlimited size' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:47:16'!
test11extraStackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack ofSize: 1.
	
	self assert: stack isEmpty
	! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:47:45'!
test12extraStackShouldReturnErrorIfSizeIsInvalid

	self 
		should: [ OOStack ofSize: -5. ] 
		raise: Error 
		withExceptionDo: [ :anError |
				 self assert: OOStack sizeInvalidErrorDescription 
					equals: anError messageText.				
				].
	! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:48:35'!
test13extraPushAddElementsToTheStack_stackShouldBeFullNotEmpty

	| stack |
	
	stack := OOStack ofSize: 1.
	stack push: 'something'.
	
	self deny: stack isEmpty.
	self assert: stack isFull.! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:47:51'!
test14extraPopRemovesElementsFromTheStack_stackShouldBeEmptyNotFull

	| stack |
	
	stack := OOStack ofSize: 1.
	stack push: 'something'.
	stack pop.
	
	self deny: stack isFull.
	self assert: stack isEmpty.! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:47:56'!
test15extraPopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack ofSize: 1.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:58:17'!
test16extraStackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack ofSize: 2.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	self assert: stack isFull.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty
	! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:48:05'!
test17extraTopReturnsLastPushedObject_stackShouldKeepBeingFullAfterTop

	| stack pushedObject |
	
	stack := OOStack ofSize: 1.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	self assert: stack isFull.! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:48:10'!
test18extraTopDoesNotRemoveObjectFromStack

	| maxSize stack pushedObject |
	
	maxSize := 1.
	stack := OOStack ofSize: maxSize .
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = maxSize .
	stack top.
	self assert: stack size = maxSize .
	! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:48:16'!
test19extraCanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack ofSize: 1.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:49:29'!
test19extraCanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack ofSize: 1.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:52:46'!
test20extraCanNotPushWhenThereIsNoSpaceInTheStack_stackShouldBeFull

	| stack |
	
	stack := OOStack ofSize: 1.
	stack push: 'something'.
	
	self
		should: [ stack push: 'something'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			 self assert: anError messageText = OOStack stackFullErrorDescription.
			 self assert: stack isFull.
			].
		
! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 19:55:58'!
test21extraIteratingCanNotPushWhenThereIsNoSpaceInTheStack

	| stack |
	
	stack := OOStack ofSize: 1.
	stack push: 'something'.
	
	self
		should: [ stack push: 'something'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			 self assert: anError messageText = OOStack stackFullErrorDescription.
			].
	
	stack pop.
	self assert: stack isEmpty.
	stack push: 'something'.
	self assert: stack isFull.	
	
	self
		should: [ stack push: 'something'. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			 self assert: anError messageText = OOStack stackFullErrorDescription.
			 self assert: stack isFull.
			].
! !

!OOStackTest methodsFor: 'extratest - with limited size' stamp: 'JMS 5/14/2022 20:02:10'!
test22extraCanNotPushWhenThereIsNoSpace_stackStaysTheSame

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack ofSize: 1.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	self assert: stack isFull.
	
	self
		should: [ stack push: secondPushedObject. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			 self assert: anError messageText = OOStack stackFullErrorDescription.
			].
	
	self deny: stack top = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty
	! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'finder prefixWithNoMatches prefixWithLowerCases prefixWithUpperCases prefixWithUpperAndLowerCases prefixWithSpace prefixBeginningWithSpace prefixEndingWithSpace emptyPrefix emptyStack stackWithManyElements expectedCollectionWithManyElements stackWithManyElementsForAsserting'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JMS 5/14/2022 17:33:08'!
setUp
	
	finder := SentenceFinderByPrefix new.	

	emptyPrefix := ''.
	prefixWithNoMatches := 'NotMatchingPrefix'.
	prefixEndingWithSpace := 'dummyprefix '.
	prefixBeginningWithSpace := ' dummyprefix'.
	prefixWithSpace := 'dummy prefix'.
	prefixWithLowerCases := 'dummyprefix'.
	prefixWithUpperCases := 'DUMMYPREFIX'.
	prefixWithUpperAndLowerCases := 'DummyPrefix'.
	
	emptyStack := OOStack new.
	stackWithManyElements := OOStack new.
	stackWithManyElementsForAsserting := OOStack new.
	expectedCollectionWithManyElements := OrderedCollection withAll: {prefixWithLowerCases. prefixWithSpace. 'dummytext'. 'dummytext'}.
	
	self initializeStackWithManyElements: stackWithManyElements.
	self initializeStackWithManyElements: stackWithManyElementsForAsserting.
	
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 18:12:01'!
test01givenAnEmptyStack_finderShouldReturnStackEmptyError
	
	self 
		should: [ finder find: prefixWithLowerCases in: emptyStack. ]
		raise: Error
		withExceptionDo: [ :anError | 
				 self assert: finder class stackEmptyErrorDescription 
					equals: anError messageText
				].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 18:12:28'!
test02givenAnEmptyPrefix_finderShouldReturnPrefixEmptyError_andTheStackShouldRemainUnchanged
	
	self 
		should: [ self findAPrefixInStackWithManyElements: emptyPrefix. ]
		raise: Error
		withExceptionDo: [ :anError | 
			 	 self assert: finder class prefixEmptyErrorDescription 
					equals: anError messageText
				].
	
	self assertTheOrderOfAllElementsInTheTestingStack.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 17:50:36'!
test03givenAPrefixWithOnlyOnePossibleMatch_finderShouldReturnAListWithOneElement_andTheStackShouldRemainUnchanged
	
	| collectionWithMatchedElements expectedCollection | 
	
	expectedCollection := OrderedCollection with: prefixWithLowerCases.
	collectionWithMatchedElements := self findAPrefixInStackWithManyElements: 'dummypre'.
	
	self assertAllElementsOf: collectionWithMatchedElements areIncludedIn: expectedCollection.
	self assertTheOrderOfAllElementsInTheTestingStack.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 17:52:41'!
test04givenAPrefixWithSeveralPossibleMatches_finderShouldReturnAListWithAllMatchingElements_andTheStackShouldRemainUnchanged
	
	| collectionWithMatchedElements | 
	
	collectionWithMatchedElements := self findAPrefixInStackWithManyElements: 'dum'.
	
	self assertAllElementsOf: collectionWithMatchedElements areIncludedIn: expectedCollectionWithManyElements.
	self assertTheOrderOfAllElementsInTheTestingStack.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 17:50:55'!
test05givenAPrefixWithZeroPossibleMatches_finderShouldReturnAnEmptyList_andTheStackShouldRemainUnchanged
	
	| emptyCollection | 

	emptyCollection := self findAPrefixInStackWithManyElements: prefixWithNoMatches.
	
	self assertCollectionIsEmpty: emptyCollection.
	self assertTheOrderOfAllElementsInTheTestingStack.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 18:12:51'!
test06givenAPrefixThatContainsASpaceAndHasOnePossibleMatch_finderShouldReturnPrefixSpaceError_andTheStackShouldRemainUnchanged
	
	self should: [ self findAPrefixInStackWithManyElements: prefixWithSpace. ]
		raise: Error
		withExceptionDo: [ :anError | 
				 self assert: finder class prefixSpaceErrorDescription 
					equals: anError messageText
				].
						
	self assertTheOrderOfAllElementsInTheTestingStack.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 17:51:12'!
test07ifCaseSensitivityIsSupported_finderShouldReturnAListWithACaseSensitiveElement
	
	| collectionWithMatchedElements expectedCollection | 
	
	expectedCollection := OrderedCollection with: prefixWithUpperAndLowerCases.
	collectionWithMatchedElements := self findAPrefixInStackWithManyElements: 'DummyPre'.
	
	self assertAllElementsOf: collectionWithMatchedElements areIncludedIn: expectedCollection.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 17:51:29'!
test08givenAPrefixWithSeveralMatches_finderShouldReturnAListWithAllMatchingElements_whenMatchingElementsArePoped_finderShouldReturnAnEmptyList
	
	| collectionWithMatchedElements | 

	collectionWithMatchedElements := self findAPrefixInStackWithManyElements: 'dum'.
	
	self assertAllElementsOf: collectionWithMatchedElements areIncludedIn: expectedCollectionWithManyElements.
	
	self popThisManyElements: expectedCollectionWithManyElements size from: stackWithManyElements.
	collectionWithMatchedElements := self findAPrefixInStackWithManyElements: 'dum'.

	self assertCollectionIsEmpty: collectionWithMatchedElements.! !


!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 16:34:38'!
assertAllElementsOf: aCollectionToBeAsserted areIncludedIn: expectedCollection

	self assert: (expectedCollection includesAllOf: aCollectionToBeAsserted).! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 16:37:39'!
assertCollectionIsEmpty: aCollectionToBeAsserted

	self assert: aCollectionToBeAsserted isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 02:28:53'!
assertTheOrderOfAllElementsInTheTestingStack

	stackWithManyElements size timesRepeat: 
		[ self assert: stackWithManyElementsForAsserting pop equals: stackWithManyElements pop. ].! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 17:49:16'!
findAPrefixInStackWithManyElements: aPrefix

	^finder find: aPrefix in: stackWithManyElements.! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 17:34:57'!
initializeStackWithManyElements: aStackToBeInitialize


	aStackToBeInitialize push: prefixWithUpperCases.
	aStackToBeInitialize push: prefixWithUpperAndLowerCases.
	aStackToBeInitialize push: prefixBeginningWithSpace.
	aStackToBeInitialize push: emptyPrefix.
	aStackToBeInitialize push: 'dummytext'.
	aStackToBeInitialize push: prefixWithSpace.
	aStackToBeInitialize push: prefixWithLowerCases.
	aStackToBeInitialize push: 'dummytext'.! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 17:39:19'!
popThisManyElements: aSize from: aStack

	aSize timesRepeat: 
			[aStack pop].! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack maxSize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/9/2022 22:32:20'!
size

	^stack size.
	! !

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/14/2022 18:32:59'!
top
	
	^(OOStackState createStateFor: self) top: self.! !


!OOStack methodsFor: 'error' stamp: 'JMS 5/14/2022 01:21:32'!
stackEmpty

	self error: self class stackEmptyErrorDescription.! !

!OOStack methodsFor: 'error' stamp: 'JMS 5/14/2022 19:07:23'!
stackFull

	self error: self class stackFullErrorDescription.! !


!OOStack methodsFor: 'initialization' stamp: 'JMS 5/14/2022 19:14:42'!
initialize

	stack := OrderedCollection new.! !

!OOStack methodsFor: 'initialization' stamp: 'JMS 5/14/2022 19:11:03'!
initializeWith: aSize

	maxSize := aSize.! !


!OOStack methodsFor: 'operations' stamp: 'JMS 5/14/2022 18:57:34'!
pop

	self top.
	^stack removeLast.
	! !

!OOStack methodsFor: 'operations' stamp: 'JMS 5/14/2022 19:06:34'!
push: aStringToAdd

	^(OOStackState createStateFor: self) push: aStringToAdd into: self.! !


!OOStack methodsFor: 'testing' stamp: 'JMS 5/10/2022 20:25:27'!
isEmpty
	
	^stack isEmpty.! !

!OOStack methodsFor: 'testing' stamp: 'JMS 5/14/2022 19:17:35'!
isFull
	
	"maxSize = nil ifTrue: [^false]."
	^(maxSize = nil) not and: [self size >= maxSize].! !


!OOStack methodsFor: 'private' stamp: 'JMS 5/14/2022 19:08:08'!
pushWhenFull

	self stackFull.! !

!OOStack methodsFor: 'private' stamp: 'JMS 5/14/2022 18:43:54'!
pushWhenNotFull: aStringToAdd

	^stack add: aStringToAdd.! !

!OOStack methodsFor: 'private' stamp: 'JMS 5/14/2022 01:24:07'!
topWhenEmpty

	self stackEmpty.! !

!OOStack methodsFor: 'private' stamp: 'JMS 5/14/2022 01:41:14'!
topWhenNotEmpty

	^stack last.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'JMS 5/14/2022 19:32:13'!
sizeInvalidErrorDescription
	
	^ 'Size is invalid'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !

!OOStack class methodsFor: 'error descriptions' stamp: 'JMS 5/14/2022 19:07:32'!
stackFullErrorDescription
	
	^ 'Stack is full'! !


!OOStack class methodsFor: 'assert' stamp: 'JMS 5/14/2022 19:32:20'!
assertSizePositive: aSize

	aSize <= 0 ifTrue: [self error: self sizeInvalidErrorDescription].! !


!OOStack class methodsFor: 'instance creation' stamp: 'JMS 5/14/2022 19:37:09'!
ofSize: aSize
	
	self assertSizePositive: aSize.
	
	^ OOStack new initializeWith: aSize.! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 18:56:26'!
push: aStringToAdd into: aStack 

	self subclassResponsibility.! !

!OOStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 02:04:34'!
top: aStack

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'instance creation' stamp: 'JMS 5/14/2022 19:10:32'!
createStateFor: aStack

	self subclasses 
		detect: [ :subclass | subclass canInstantiateAnState: aStack ]
		ifFound: [ :subclass | ^subclass new ]
		ifNone: [].! !


!classDefinition: #EmptyStackState category: 'Stack-Exercise'!
OOStackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 19:09:39'!
push: aStringToAdd into: aStack 

	^aStack pushWhenNotFull: aStringToAdd.! !

!EmptyStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 02:04:20'!
top: aStack
	
	aStack topWhenEmpty.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyStackState class' category: 'Stack-Exercise'!
EmptyStackState class
	instanceVariableNames: ''!

!EmptyStackState class methodsFor: 'verification - private' stamp: 'JMS 5/14/2022 02:04:05'!
canInstantiateAnState: aStack
	
	^aStack isEmpty.	! !


!classDefinition: #FullStackState category: 'Stack-Exercise'!
OOStackState subclass: #FullStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!FullStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 18:45:42'!
push: aStringToAdd into: aStack 

	aStack pushWhenFull.! !

!FullStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 18:56:07'!
top: aStack
	
	^aStack topWhenNotEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FullStackState class' category: 'Stack-Exercise'!
FullStackState class
	instanceVariableNames: ''!

!FullStackState class methodsFor: 'verification - private' stamp: 'JMS 5/14/2022 18:34:04'!
canInstantiateAnState: aStack
	
	^aStack isFull.! !


!classDefinition: #NotEmptyStackState category: 'Stack-Exercise'!
OOStackState subclass: #NotEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 19:10:05'!
push: aStringToAdd into: aStack 

	^aStack pushWhenNotFull: aStringToAdd.! !

!NotEmptyStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 02:04:26'!
top: aStack
	
	^aStack topWhenNotEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStackState class' category: 'Stack-Exercise'!
NotEmptyStackState class
	instanceVariableNames: ''!

!NotEmptyStackState class methodsFor: 'verification - private' stamp: 'JMS 5/14/2022 19:01:03'!
canInstantiateAnState: aStack
	
	^ aStack isEmpty not and: [aStack isFull not].! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'error' stamp: 'JMS 5/14/2022 02:20:17'!
prefixEmpty

	self error: self class prefixEmptyErrorDescription.! !

!SentenceFinderByPrefix methodsFor: 'error' stamp: 'JMS 5/14/2022 02:19:48'!
prefixSpace

	self error: self class prefixSpaceErrorDescription.! !

!SentenceFinderByPrefix methodsFor: 'error' stamp: 'JMS 5/14/2022 02:21:04'!
stackEmpty

	self error: self class stackEmptyErrorDescription.! !


!SentenceFinderByPrefix methodsFor: 'operation' stamp: 'JMS 5/14/2022 02:39:43'!
find: aPrefix in: aStack
	
	| collectionWithMatchedElements auxiliarStack |
	
	auxiliarStack := OOStack new.
	collectionWithMatchedElements  := OrderedCollection new.
	
	self assertPrefixDoesNotIncludeSpaces: aPrefix.
	self assertPrefixIsNotEmpty: aPrefix.
	self assertStackIsNotEmpty: aStack.
	
	self unstack: aStack 
		into: auxiliarStack 
		andForEachElementDo: [ :anElement | 
				self add: anElement to: collectionWithMatchedElements ifItBeginsWith: aPrefix. ].
	
	self unstack: auxiliarStack into: aStack.

	^collectionWithMatchedElements.! !


!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'JMS 5/14/2022 02:21:37'!
assertPrefixDoesNotIncludeSpaces: aPrefix

	(aPrefix includesSubString: ' ') ifTrue: [ self prefixSpace. ].! !

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'JMS 5/14/2022 02:21:30'!
assertPrefixIsNotEmpty: aPrefix

	aPrefix = '' ifTrue: [ self prefixEmpty. ].! !

!SentenceFinderByPrefix methodsFor: 'testing' stamp: 'JMS 5/14/2022 02:21:22'!
assertStackIsNotEmpty: aStack

	aStack size = 0 ifTrue: [ self stackEmpty. ].! !


!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JMS 5/14/2022 02:25:26'!
add: aStringToBeCompared to: aCollection ifItBeginsWith: aPrefix

	self do: [ aCollection add: aStringToBeCompared ] 
		ifAnElement: aStringToBeCompared 
		beginsWith: aPrefix.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JMS 5/14/2022 00:31:38'!
do: aBlockToBeEvaluated ifAnElement: aStringToBeCompared beginsWith: aPrefix 

	(aStringToBeCompared beginsWith: aPrefix) ifTrue: aBlockToBeEvaluated.! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JMS 5/14/2022 02:37:06'!
unstack: aStackToGetEmptied into: aStackToGetFilled

	self unstack: aStackToGetEmptied into: aStackToGetFilled andForEachElementDo: [ :anElement | ].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'JMS 5/14/2022 02:37:18'!
unstack: aStackToGetEmptied into: aStackToGetFilled andForEachElementDo: aBlockToBeEvaluated

	aStackToGetEmptied size timesRepeat: [
		aStackToGetFilled push: aStackToGetEmptied pop.
		aBlockToBeEvaluated value: aStackToGetFilled top.	
		].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JMS 5/13/2022 23:38:59'!
prefixEmptyErrorDescription
	
	^ 'Prefix is empty'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JMS 5/13/2022 23:41:13'!
prefixSpaceErrorDescription
	
	^ 'Prefix contains a space'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'JMS 5/13/2022 23:38:15'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !
