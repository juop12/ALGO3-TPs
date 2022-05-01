
Mensajes que revisar.
{
	3 y 4
	5 y 6 (Ya casi hechos.)
	7 y 8

	addCustomerNamed:
	signal...
	removeCustomerNamed:
	suspendCustomerNamed:
}

--------------------------------------------------------------------------------------
[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]

[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]

[ unClosure value. 
	self fail ]
		on: unError
		do: unClosureDistinto

---------------------------------------------------------------------------------------



