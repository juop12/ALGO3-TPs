!classDefinition: #AvispaOriana category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #AvispaOriana
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaOriana class' category: 'AvispasYAbejasParte2'!
AvispaOriana class
	instanceVariableNames: ''!

!AvispaOriana class methodsFor: 'as yet unclassified' stamp: 'JMS 4/21/2022 20:41:22'!
habitat
	^Habitat.! !

!AvispaOriana class methodsFor: 'as yet unclassified' stamp: 'JMS 4/22/2022 21:20:30'!
intentarReproducirse
	self habitat cantidadDeOrugas < 1 ifTrue: [^nil].
	self habitat sacrificarOruga.
	self habitat ponerHuevoDeAvispasDe: 'Oriana y Ornella'.! !


!classDefinition: #AvispaLara category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaLara
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaLara class' category: 'AvispasYAbejasParte2'!
AvispaLara class
	instanceVariableNames: ''!

!AvispaLara class methodsFor: 'as yet unclassified' stamp: 'JMS 4/22/2022 23:18:13'!
intentarReproducirse
	| CantidadDeHuevosDePolly CantidadDeHuevosDeOrianayOrnella |

	self habitat cantidadDeHuevosDeAvispas < 1 ifTrue: [^nil].
	
	CantidadDeHuevosDeOrianayOrnella := self habitat cantidadDeHuevosDeAvispasDe: 'Oriana y Ornella'.	
	CantidadDeHuevosDeOrianayOrnella > 0 ifTrue: [^ self habitat robarNidoYDarseloALara: 'Oriana y Ornella'].
	
	CantidadDeHuevosDePolly := self habitat cantidadDeHuevosDeAvispasDe: 'Polly'.
	CantidadDeHuevosDePolly > 0 ifTrue: [^ self habitat robarNidoYDarseloALara: 'Polly'].	
	
! !


!classDefinition: #AvispaOrnella category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaOrnella
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!


!classDefinition: #AvispaPolly category: 'AvispasYAbejasParte2'!
AvispaOriana subclass: #AvispaPolly
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvispaPolly class' category: 'AvispasYAbejasParte2'!
AvispaPolly class
	instanceVariableNames: ''!

!AvispaPolly class methodsFor: 'as yet unclassified' stamp: 'JMS 4/22/2022 21:18:34'!
intentarReproducirse
	self habitat cantidadDePolillas < 1 ifTrue: [^nil].
	self habitat sacrificarPolilla.
	self habitat ponerHuevoDeAvispasDe: 'Polly'.! !


!classDefinition: #Habitat category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #Habitat
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Habitat class' category: 'AvispasYAbejasParte2'!
Habitat class
	instanceVariableNames: 'CantidadDeHuevosDeAvispas DiccionarioDeHuevosDeAvispasConGenetica CantidadDeOrugas CantidadDePolillas'!

!Habitat class methodsFor: 'HuevosDeAvispas' stamp: 'JMS 4/22/2022 21:05:02'!
cantidadDeHuevosDeAvispas
	^CantidadDeHuevosDeAvispas.! !

!Habitat class methodsFor: 'HuevosDeAvispas' stamp: 'JMS 4/22/2022 22:02:38'!
cantidadDeHuevosDeAvispasDe: unStringFirmaGenetica
	^DiccionarioDeHuevosDeAvispasConGenetica at: unStringFirmaGenetica.! !

!Habitat class methodsFor: 'HuevosDeAvispas' stamp: 'JMS 4/22/2022 22:12:24'!
huevosAlInicioDeLosTiempos: cantidad
	CantidadDeHuevosDeAvispas := cantidad.
	DiccionarioDeHuevosDeAvispasConGenetica := Dictionary new.
	DiccionarioDeHuevosDeAvispasConGenetica at: 'Polly' put: 0.
	DiccionarioDeHuevosDeAvispasConGenetica at: 'Oriana y Ornella' put: 0.
	DiccionarioDeHuevosDeAvispasConGenetica at: 'Lara' put: 0.	! !

!Habitat class methodsFor: 'HuevosDeAvispas' stamp: 'JMS 4/22/2022 21:05:28'!
nuevoHuevoDeAvispas
	CantidadDeHuevosDeAvispas := CantidadDeHuevosDeAvispas + 1. ! !

!Habitat class methodsFor: 'HuevosDeAvispas' stamp: 'JMS 4/22/2022 22:01:11'!
ponerHuevoDeAvispasDe: unStringFirmaGenetica
	| NuevaCantidadDeHuevos | 	
	self nuevoHuevoDeAvispas. 
	
	NuevaCantidadDeHuevos := (DiccionarioDeHuevosDeAvispasConGenetica at: unStringFirmaGenetica) + 1.
	DiccionarioDeHuevosDeAvispasConGenetica at: unStringFirmaGenetica put: NuevaCantidadDeHuevos.! !

!Habitat class methodsFor: 'HuevosDeAvispas' stamp: 'JMS 4/22/2022 23:18:13'!
robarNidoYDarseloALara: unStringFirmaGeneticaRobada
	| NuevaCantidadDeHuevos |
	
	NuevaCantidadDeHuevos := (DiccionarioDeHuevosDeAvispasConGenetica at: 'Lara') + (DiccionarioDeHuevosDeAvispasConGenetica at: unStringFirmaGeneticaRobada).
	DiccionarioDeHuevosDeAvispasConGenetica at: unStringFirmaGeneticaRobada put: 0.

	DiccionarioDeHuevosDeAvispasConGenetica at: 'Lara' put: NuevaCantidadDeHuevos.
	
	! !


!Habitat class methodsFor: 'Orugas' stamp: 'JMS 4/22/2022 21:03:07'!
cantidadDeOrugas
	^CantidadDeOrugas.! !

!Habitat class methodsFor: 'Orugas' stamp: 'JMS 4/22/2022 21:03:19'!
nacimientoDeOrugas: cantidad
	CantidadDeOrugas := CantidadDeOrugas + cantidad. 
	! !

!Habitat class methodsFor: 'Orugas' stamp: 'JMS 4/22/2022 21:03:23'!
orugasAlInicioDeLosTiempos: cantidad
	CantidadDeOrugas := cantidad.! !

!Habitat class methodsFor: 'Orugas' stamp: 'JMS 4/22/2022 21:03:29'!
sacrificarOruga
	CantidadDeOrugas := CantidadDeOrugas - 1.! !


!Habitat class methodsFor: 'Polillas' stamp: 'JMS 4/22/2022 21:03:45'!
cantidadDePolillas
	^CantidadDePolillas.! !

!Habitat class methodsFor: 'Polillas' stamp: 'JMS 4/22/2022 21:03:49'!
nacimientoDePolillas: cantidad
	CantidadDePolillas := CantidadDePolillas + cantidad. ! !

!Habitat class methodsFor: 'Polillas' stamp: 'JMS 4/22/2022 21:03:52'!
polillasAlInicioDeLosTiempos: cantidad
	CantidadDePolillas := cantidad.! !

!Habitat class methodsFor: 'Polillas' stamp: 'JMS 4/22/2022 21:03:56'!
sacrificarPolilla
	CantidadDePolillas := CantidadDePolillas - 1.! !


!Habitat class methodsFor: '--** private fileout/in **--' stamp: 'JMS 4/22/2022 23:20:17'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	CantidadDeHuevosDeAvispas := 1.
	DiccionarioDeHuevosDeAvispasConGenetica := ((Dictionary new) add: ('Lara'->1); add: ('Oriana y Ornella'->0); add: ('Polly'->0); yourself).
	CantidadDeOrugas := 1.
	CantidadDePolillas := 2.! !


!classDefinition: #PruebasReproduccionDeAvispas category: 'AvispasYAbejasParte2'!
DenotativeObject subclass: #PruebasReproduccionDeAvispas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AvispasYAbejasParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasReproduccionDeAvispas class' category: 'AvispasYAbejasParte2'!
PruebasReproduccionDeAvispas class
	instanceVariableNames: ''!

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/18/2022 18:38:11'!
test01EnElInicioDeLosTiemposNoHayHuevos	
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:44'!
test02CuandoOrianaLaAvispaSeReproducePorPrimeraVezDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:11'!
test03CadaVezQueOrianaSeReproduceDejaUnHuevoMas
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:12:53'!
test04ParaDejarUnHuevoOrianaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:43'!
test05ParaDejarUnHuevoOrianaLaAvispaDecrementaEnUnoLaPoblacionDeOrugasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosOrugasMas.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Oriana' stamp: 'JMB 4/21/2022 12:13:22'!
test06CuandoNoHayOrugasOrianaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:24'!
test07CuandoOrnellaLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:18'!
test08ParaDejarUnHuevoOrnellaLaAvispaReduceLaPoblacionDeUnaOrugaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaOrugaMas.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeOrugas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Ornella' stamp: 'JMB 4/21/2022 12:14:11'!
test09CuandoNoHayOrugasOrnellaLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:46'!
test10CuandoPollyLaAvispaSeReproduceDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:40'!
test11ParaDejarUnHuevoPollyLaAvispaReduceLaPoblacionDeUnaPolillaANinguna
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaUnaPolillaMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:36'!
test12ParaDejarUnHuevoPollyLaAvispaDecrementaEnUnoLaPoblacionDePolillasDelHabitat
	self retrocederElHabitatAlInicioDeLosTiempos.
	self queElHabitatTengaDosPolillasMas.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDePolillas isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Polly' stamp: 'JMB 4/21/2022 12:14:30'!
test13CuandoNoHayPolillasPollyLaAvispaNoPuedeDejarHuevos
	self retrocederElHabitatAlInicioDeLosTiempos.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self habitat cantidadDeHuevosDeAvispas isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:06'!
test14CuandoOrianaLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:15:02'!
test15CuandoOrianaLaAvispaAunNoSeReprodujoNoTieneHuevosConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	
	self laAvispaOriana intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:58'!
test16CuandoPollyLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaPolly intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 1.
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - firma genetica' stamp: 'JMB 4/21/2022 12:14:54'!
test17CuandoOrnellaLaAvispaSeReproduceDejaUnHuevoConLaMismaFirmaGeneticaQueOriana
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	
	self laAvispaOrnella intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella isEqualTo: 1.
	Assert 
		that: self cantidadDeHuevosConLaFirmaGeneticaDeOrnella  
		isEqualTo: self cantidadDeHuevosConLaFirmaGeneticaDeOriana! !


!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:27'!
test18CuandoLaraLaAvispaSeReproduceDejaUnHuevoConSuFirmaGenetica
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOrnella intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:22'!
test19CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAOtraAvispa
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaOriana intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeOriana isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:18'!
test20CuandoLaraLaAvispaSeReproduceLeSacaElHuevoAPolly
	self retrocederElHabitatAlInicioDeLosTiempos. 
	self hacerQueElHabitatTengaLosRecursosSuficientes.
	self laAvispaPolly intentarReproducirse.
	
	self laAvispaLara intentarReproducirse.
	
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDePolly isEqualTo: 0.! !

!PruebasReproduccionDeAvispas class methodsFor: 'tests - Lara la ladrona' stamp: 'JMB 4/21/2022 12:15:12'!
test21CuandoLaraLaAvispaNoTieneRecursosNoDejaUnHuevo
	self retrocederElHabitatAlInicioDeLosTiempos. 
		
	self laAvispaLara intentarReproducirse.
		
	Assert that: self cantidadDeHuevosConLaFirmaGeneticaDeLara isEqualTo: 0.! !


!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 23:01:50'!
cantidadDeHuevosConLaFirmaGeneticaDeLara
	^self habitat cantidadDeHuevosDeAvispasDe: 'Lara'.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 22:04:01'!
cantidadDeHuevosConLaFirmaGeneticaDeOriana
	^self habitat cantidadDeHuevosDeAvispasDe: 'Oriana y Ornella'.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 22:04:44'!
cantidadDeHuevosConLaFirmaGeneticaDeOrnella
	^self habitat cantidadDeHuevosDeAvispasDe: 'Oriana y Ornella'.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 22:04:53'!
cantidadDeHuevosConLaFirmaGeneticaDePolly
	^self habitat cantidadDeHuevosDeAvispasDe: 'Polly'.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 19:25:14'!
habitat
	^Habitat.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 23:19:01'!
hacerQueElHabitatTengaLosRecursosSuficientes
	self habitat nacimientoDeOrugas: 2.
	self habitat nacimientoDePolillas: 2.
	! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 22:13:23'!
laAvispaLara
	^AvispaLara.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 19:30:51'!
laAvispaOriana
	^AvispaOriana.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 20:49:09'!
laAvispaOrnella
	^AvispaOrnella.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 20:56:40'!
laAvispaPolly
	^AvispaPolly.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 20:31:33'!
queElHabitatTengaDosOrugasMas
	self habitat nacimientoDeOrugas: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 21:20:08'!
queElHabitatTengaDosPolillasMas
	self habitat nacimientoDePolillas: 2.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 20:32:55'!
queElHabitatTengaUnaOrugaMas
	self habitat nacimientoDeOrugas: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/21/2022 21:20:29'!
queElHabitatTengaUnaPolillaMas
	self habitat nacimientoDePolillas: 1.! !

!PruebasReproduccionDeAvispas class methodsFor: 'Para completar' stamp: 'JMS 4/22/2022 23:19:10'!
retrocederElHabitatAlInicioDeLosTiempos
	self habitat huevosAlInicioDeLosTiempos: 0.
	self habitat orugasAlInicioDeLosTiempos: 0.
	self habitat polillasAlInicioDeLosTiempos: 0.
	! !

Habitat initializeAfterFileIn!