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
	instanceVariableNames: 'finder prefixWithLowerCases prefixWithUpperCases prefixWithUpperAndLowerCases prefixWithSpaces prefixBeginningWithSpace prefixEndingWithSpace emptyPrefix emptyStack stackWithOneElement stackWithManyElements stackWithManyElementsForAsserting'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'JMS 5/14/2022 00:44:48'!
setUp
	
	prefixWithLowerCases := 'dummyprefix'.
	prefixWithUpperCases := 'DUMMYPREFIX'.
	prefixWithUpperAndLowerCases := 'DummyPrefix'.
	prefixWithSpaces := 'dummy prefix'.
	prefixBeginningWithSpace := ' dummyprefix'.
	prefixEndingWithSpace := 'dummyprefix '.
	emptyPrefix := ''.
	
	emptyStack := OOStack new.
	"stackWithOneElement := OOStack new."
	stackWithManyElements := OOStack new.
	stackWithManyElementsForAsserting := OOStack new.
	
	"pensar si borrar stackWithOneElement."
	
	self initializeStackWithManyElements: stackWithManyElements.
	self initializeStackWithManyElements: stackWithManyElementsForAsserting.
	
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/13/2022 23:48:52'!
test01givenAnEmptyStack_finderShouldReturnStackEmptyError
	
	self should: [ SentenceFinderByPrefix new find: prefixWithLowerCases in: emptyStack. ]
		raise: Error
		withExceptionDo: [ :anError | self 
						assert: SentenceFinderByPrefix stackEmptyErrorDescription 
						equals: anError messageText
							].! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/13/2022 23:54:37'!
test02givenAnEmptyPrefix_finderShouldReturnPrefixEmptyError_andTheStackShouldRemainUnchanged
	
	self should: [ SentenceFinderByPrefix new find: emptyPrefix in: stackWithManyElements. ]
		raise: Error
		withExceptionDo: [ :anError | self 
						assert: SentenceFinderByPrefix prefixEmptyErrorDescription 
						equals: anError messageText
							].
	
	self assertTheOrderOfAllElementsInTheTestingStack.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/13/2022 23:25:00'!
test03givenAPrefixWithOnlyOnePossibleMatch_finderShouldReturnAListWithOneElement_andTheStackShouldRemainUnchanged
	
	| matchingCollection expectedCollection | 
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'dummyprefix'.
	
	matchingCollection := SentenceFinderByPrefix new find: 'dummypre' in: stackWithManyElements.
	
	self assert: (expectedCollection includesAllOf: matchingCollection ).
	self assertTheOrderOfAllElementsInTheTestingStack.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/13/2022 23:23:17'!
test04givenAPrefixWithSeveralPossibleMatches_finderShouldReturnAListWithAllMatchingElements_andTheStackShouldRemainUnchanged
	
	| matchingCollection expectedCollection | 
	
	expectedCollection := OrderedCollection new.
	expectedCollection addAll: #('dummyprefix' 'dummy prefix' 'dummyprefix ' 'dummytext' 'dummytext').
	"expectedCollection addAll: {prefixWithLowerCases prefixWithSpaces prefixEndingWithSpace 'dummytext' 'dummytext'}."
	
	matchingCollection := SentenceFinderByPrefix new find: 'dum' in: stackWithManyElements.
	
	self assert: (expectedCollection includesAllOf: matchingCollection ).
	self assertTheOrderOfAllElementsInTheTestingStack.
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/14/2022 00:46:12'!
test05givenAPrefixWithZeroPossibleMatches_finderShouldReturnAnEmptyList_andTheStackShouldRemainUnchanged
	
	| emptyCollection | 

	emptyCollection := SentenceFinderByPrefix new find: 'NotMatchingPrefix' in: stackWithManyElements.
	
	self assert: 0 equals: emptyCollection size.
	self assertTheOrderOfAllElementsInTheTestingStack.! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/13/2022 23:56:29'!
test06givenAPrefixThatContainsASpaceAndHasOnePossibleMatch_finderShouldReturnPrefixSpaceError_andTheStackShouldRemainUnchanged
	
	self should: [ SentenceFinderByPrefix new find: 'dummy prefix' in: stackWithManyElements. ]
		raise: Error
		withExceptionDo: [ :anError | self 
						assert: SentenceFinderByPrefix prefixSpaceErrorDescription 
						equals: anError messageText
							].
						
	self assertTheOrderOfAllElementsInTheTestingStack.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'JMS 5/13/2022 23:30:54'!
test07ifCaseSensitivityIsSupported_finderShouldReturnAListWithACaseSensitiveElement
	
	| matchingCollection expectedCollection | 
	
	expectedCollection := OrderedCollection new.
	expectedCollection add: 'DummyPrefix'.
	
	matchingCollection := SentenceFinderByPrefix new find: 'DummyPre' in: stackWithManyElements.
	
	self assert: (expectedCollection includesAllOf: matchingCollection ).
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 02:28:53'!
assertTheOrderOfAllElementsInTheTestingStack

	stackWithManyElements size timesRepeat: 
		[ self assert: stackWithManyElementsForAsserting pop equals: stackWithManyElements pop. ].! !

!SentenceFinderByPrefixTest methodsFor: 'private' stamp: 'JMS 5/14/2022 00:43:44'!
initializeStackWithManyElements: aStackToBeInitialize

	aStackToBeInitialize push: prefixWithLowerCases.
	aStackToBeInitialize push: prefixWithUpperCases.
	aStackToBeInitialize push: prefixWithUpperAndLowerCases.
	aStackToBeInitialize push: 'dummytext'.
	aStackToBeInitialize push: prefixWithSpaces.
	aStackToBeInitialize push: prefixBeginningWithSpace.
	aStackToBeInitialize push: emptyPrefix.
	aStackToBeInitialize push: 'dummytext'.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/10/2022 20:25:27'!
isEmpty
	
	^stack isEmpty.! !

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/9/2022 22:32:20'!
size

	^stack size.
	! !

!OOStack methodsFor: 'accessing' stamp: 'JMS 5/14/2022 01:26:01'!
top
	
	^(OOStackState createStateFor: stack) top: self.! !


!OOStack methodsFor: 'error' stamp: 'JMS 5/14/2022 01:21:32'!
stackEmpty

	self error: self class stackEmptyErrorDescription.! !


!OOStack methodsFor: 'initialization' stamp: 'JMS 5/9/2022 22:00:05'!
initialize

	stack := OrderedCollection new.! !


!OOStack methodsFor: 'operations' stamp: 'JMS 5/14/2022 01:52:47'!
pop
	
	
	^stack remove: self top.
	
	
	"
	self top.
	^stack removeLast.
	"! !

!OOStack methodsFor: 'operations' stamp: 'JMS 5/14/2022 02:05:18'!
push: aStringToAdd

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

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackState category: 'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 02:04:34'!
top: aStack

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: 'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'instance creation' stamp: 'JMS 5/14/2022 01:57:21'!
createStateFor: anStack

	self subclasses 
		detect: [ :subclass | subclass canInstantiateAnState: anStack ]
		ifFound: [ :subclass | ^subclass new ]
		ifNone: [].
		
	"^(self subclasses detect: [ :subclass | subclass canInstantiateAnState: anStack ]) new"! !


!classDefinition: #EmptyStackState category: 'Stack-Exercise'!
OOStackState subclass: #EmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

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


!classDefinition: #NotEmptyStackState category: 'Stack-Exercise'!
OOStackState subclass: #NotEmptyStackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmptyStackState methodsFor: 'operations' stamp: 'JMS 5/14/2022 02:04:26'!
top: aStack
	
	^aStack topWhenNotEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmptyStackState class' category: 'Stack-Exercise'!
NotEmptyStackState class
	instanceVariableNames: ''!

!NotEmptyStackState class methodsFor: 'verification - private' stamp: 'JMS 5/14/2022 02:03:59'!
canInstantiateAnState: aStack
	
	^aStack isEmpty not.! !


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
