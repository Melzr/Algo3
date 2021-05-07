!classDefinition: #Caja category: 'FactorioParte2'!
DenotativeObject subclass: #Caja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Caja class' category: 'FactorioParte2'!
Caja class
	instanceVariableNames: 'contenido'!

!Caja class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:07:37'!
agregar: unaMena
	contenido add: unaMena.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:42:38'!
agregarMenas: aCollectionOfMenas
	^contenido addAll: aCollectionOfMenas.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:08:26'!
cantidadDeMenas
	^contenido size.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'ML 5/4/2021 22:20:21'!
cantidadDeMenasDeCarbon
	^contenido count: [:cadaElemento | cadaElemento = 'una mena de carbon'].! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:22:40'!
cantidadDeMenasDeHierro
	^contenido count: [:cadaElemento | cadaElemento = 'una mena de hierro'].! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:26:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	contenido := ((OrderedCollection new) add: 'una mena de carbon'; add: 'una mena de hierro'; yourself).! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 22:52:37'!
recibirMenas: coleccionDeMenas
	self agregarMenas: coleccionDeMenas.! !

!Caja class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:09:06'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaA category: 'FactorioParte2'!
DenotativeObject subclass: #CintaA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaA class' category: 'FactorioParte2'!
CintaA class
	instanceVariableNames: 'destino contenido'!

!CintaA class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:01:30'!
cantidadDeMenas
	^contenido size.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 22:36:09'!
destino: nuevoDestino
	destino := nuevoDestino.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:26:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := Caja.
	contenido := ((OrderedCollection new)).! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:13:15'!
recibirMenas: coleccionDeMenas
	^contenido addAll: coleccionDeMenas.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:08:37'!
transportarContenido
	"Trabsporta lo almacenado en contenido"
	|contenidoActual|
	contenidoActual := contenido.
	self vaciar.
	destino recibirMenas: contenidoActual.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:07:44'!
transportarMenas: coleccionDeMenas
	"Transporta las menas recibidas directamente sin almacenarlas"
	destino recibirMenas: coleccionDeMenas.! !

!CintaA class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:04:30'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #CintaB category: 'FactorioParte2'!
DenotativeObject subclass: #CintaB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CintaB class' category: 'FactorioParte2'!
CintaB class
	instanceVariableNames: 'destino contenido'!

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:11:32'!
cantidadDeMenas
	^contenido size.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:11:32'!
destino: nuevoDestino
	destino := nuevoDestino.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:26:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	destino := CintaA.
	contenido := ((OrderedCollection new)).! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:13:29'!
recibirMenas: coleccionDeMenas
	^contenido addAll: coleccionDeMenas.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:11:32'!
transportarContenido
	"Trabsporta lo almacenado en contenido"
	|contenidoActual|
	contenidoActual := contenido.
	self vaciar.
	destino recibirMenas: contenidoActual.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:11:32'!
transportarMenas: coleccionDeMenas
	"Transporta las menas recibidas directamente sin almacenarlas"
	destino recibirMenas: coleccionDeMenas.! !

!CintaB class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:11:32'!
vaciar
	contenido := OrderedCollection new.! !


!classDefinition: #ExtractorDeCarbon category: 'FactorioParte2'!
DenotativeObject subclass: #ExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeCarbon class' category: 'FactorioParte2'!
ExtractorDeCarbon class
	instanceVariableNames: 'energiaActual destino'!

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/15/2021 21:23:04'!
agregarEnergia: energiaExtra

	energiaActual := energiaActual +	energiaExtra.
	^energiaExtra.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 5/2/2021 19:44:58'!
conjuntoDeMenasDeCarbonCantidad: cantidadDeMenas

	^ Array new: cantidadDeMenas withAll: 'una mena de carbon'! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:30:49'!
costoDeExtraccionPorMena
	^5 * joule.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 22:37:00'!
destino: nuevoDestino
	destino := nuevoDestino.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/15/2021 21:21:02'!
energiaActual

	^energiaActual.
! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:31:29'!
energiaParaExtraerTodasLasMenasPosibles
	^self menasAExtraerSegunEnergiaActual * self costoDeExtraccionPorMena.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 22:51:49'!
extraer
	| cantidadDeMenas energiaConsumida |
	cantidadDeMenas := self menasAExtraerSegunEnergiaActual.
	energiaConsumida := self energiaParaExtraerTodasLasMenasPosibles.
	self sacarEnergia: energiaConsumida.
	^destino recibirMenas: (self conjuntoDeMenasDeCarbonCantidad: cantidadDeMenas).! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:26:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energiaActual := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'joule'; instVarAt: 2 put: 'joules'; instVarAt: 3 put: 'j'; yourself); yourself).
	destino := CintaA.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:30:27'!
menasAExtraerSegunEnergiaActual
	^energiaActual // self costoDeExtraccionPorMena.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 5/2/2021 19:36:12'!
ponerEnCeroLaEnergia
	energiaActual := 0 * joule.! !

!ExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:31:57'!
sacarEnergia: energiaASacar
	energiaActual := energiaActual - energiaASacar! !


!classDefinition: #ExtractorDeHierro category: 'FactorioParte2'!
DenotativeObject subclass: #ExtractorDeHierro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ExtractorDeHierro class' category: 'FactorioParte2'!
ExtractorDeHierro class
	instanceVariableNames: 'energiaActual destino'!

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
agregarEnergia: energiaExtra

	energiaActual := energiaActual +	energiaExtra.
	^energiaExtra.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:04:07'!
conjuntoDeMenasDeHierroCantidad: cantidadDeMenas

	^ Array new: cantidadDeMenas withAll: 'una mena de hierro'! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
costoDeExtraccionPorMena
	^5 * joule.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
destino: nuevoDestino
	destino := nuevoDestino.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
energiaActual

	^energiaActual.
! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
energiaParaExtraerTodasLasMenasPosibles
	^self menasAExtraerSegunEnergiaActual * self costoDeExtraccionPorMena.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:05:56'!
extraer
	| cantidadDeMenas energiaConsumida |
	cantidadDeMenas := self menasAExtraerSegunEnergiaActual.
	energiaConsumida := self energiaParaExtraerTodasLasMenasPosibles.
	self sacarEnergia: energiaConsumida.
	^destino recibirMenas: (self conjuntoDeMenasDeHierroCantidad: cantidadDeMenas).! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:26:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energiaActual := (SimpleMeasure basicNew instVarAt: 1 put: 0; instVarAt: 2 put: (BaseUnit basicNew instVarAt: 1 put: 'joule'; instVarAt: 2 put: 'joules'; instVarAt: 3 put: 'j'; yourself); yourself).
	destino := CintaB.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
menasAExtraerSegunEnergiaActual
	^energiaActual // self costoDeExtraccionPorMena.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
ponerEnCeroLaEnergia
	energiaActual := 0 * joule.! !

!ExtractorDeHierro class methodsFor: 'as yet unclassified' stamp: 'MC 5/4/2021 23:03:25'!
sacarEnergia: energiaASacar
	energiaActual := energiaActual - energiaASacar! !


!classDefinition: #PruebasDeExtractorDeCarbon category: 'FactorioParte2'!
DenotativeObject subclass: #PruebasDeExtractorDeCarbon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasDeExtractorDeCarbon class' category: 'FactorioParte2'!
PruebasDeExtractorDeCarbon class
	instanceVariableNames: ''!

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 5/2/2021 19:37:39'!
setUp
	ExtractorDeCarbon destino: Caja.
	Caja vaciar.! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:41:43'!
test01UnExtractorSinEnergiaNoExtraeMenas
	"Cuando no cargue energia en el extractor, no saco menas"
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	Assert isTrue: ExtractorDeCarbon extraer isEmpty.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:46:54'!
test02UnExtractorConInsuficienteEnergiaNoExtraeMenas
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 1 * joule.
	Assert isTrue: ExtractorDeCarbon extraer isEmpty.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:47:56'!
test03UnExtractorConSuficienteEnergiaExtrae1Mena
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	Assert that: ExtractorDeCarbon extraer size isEqualTo: 1.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:49:57'!
test04UnExtractorConservaLaEnergiaNoUtilizada
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 7 * joule.
	Assert that: ExtractorDeCarbon extraer size isEqualTo: 1.
	Assert that: ExtractorDeCarbon energiaActual isEqualTo: 2 * joule.
! !

!PruebasDeExtractorDeCarbon class methodsFor: 'as yet unclassified' stamp: 'SF 4/20/2021 18:50:53'!
test05UnExtractorPuedeExtraerMultiplesMenasConMuchaEnergia
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 50 * joule.
	Assert that: ExtractorDeCarbon extraer size isEqualTo: 10.
	Assert that: ExtractorDeCarbon energiaActual isEqualTo: 0 * joule.
! !


!classDefinition: #PruebasDeFactorio category: 'FactorioParte2'!
DenotativeObject subclass: #PruebasDeFactorio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FactorioParte2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasDeFactorio class' category: 'FactorioParte2'!
PruebasDeFactorio class
	instanceVariableNames: ''!

!PruebasDeFactorio class methodsFor: 'as yet unclassified' stamp: 'SF 5/2/2021 19:43:17'!
testEscenarioExtractorCaja
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	ExtractorDeCarbon destino: Caja.
	Caja vaciar.
	ExtractorDeCarbon extraer.
	Assert that: Caja cantidadDeMenas isEqualTo: 1.
	Assert that: Caja cantidadDeMenasDeCarbon isEqualTo: 1.! !

!PruebasDeFactorio class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:15:48'!
testEscenarioExtractorCintaCaja
	
	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeCarbon destino: CintaA.
	CintaA destino: Caja.
	Caja vaciar.
	
	ExtractorDeCarbon agregarEnergia: 5 * joule.
	ExtractorDeCarbon extraer.
	CintaA transportarContenido.
	
	Assert that: Caja cantidadDeMenas isEqualTo: 1.
	Assert that: Caja cantidadDeMenasDeCarbon isEqualTo: 1.
	Assert that: ExtractorDeCarbon energiaActual isEqualTo: 0 * joule.
	Assert that: CintaA cantidadDeMenas isEqualTo: 0.
	! !

!PruebasDeFactorio class methodsFor: 'as yet unclassified' stamp: 'ML 5/7/2021 18:24:46'!
testEscenarioExtractoresCintasCaja

	ExtractorDeCarbon ponerEnCeroLaEnergia.
	ExtractorDeHierro ponerEnCeroLaEnergia.
	ExtractorDeCarbon destino: CintaA.
	ExtractorDeHierro destino: CintaB.
	CintaB destino: CintaA.
	CintaA destino: Caja.
	Caja vaciar.	
	
	ExtractorDeCarbon agregarEnergia: 	5 * joule.
	ExtractorDeHierro agregarEnergia: 	5 * joule.
	ExtractorDeCarbon extraer.
	ExtractorDeHierro extraer.
	CintaB transportarContenido.
	
	Assert that: CintaA cantidadDeMenas isEqualTo: 2.
	Assert that: CintaB cantidadDeMenas isEqualTo: 0.
	Assert that: Caja cantidadDeMenas isEqualTo: 0.
	
	CintaA transportarContenido.
	
	Assert that: Caja cantidadDeMenas isEqualTo: 2.
	Assert that: Caja cantidadDeMenasDeCarbon isEqualTo: 1.
	Assert that: Caja cantidadDeMenasDeHierro isEqualTo: 1.
		! !

Caja initializeAfterFileIn!
CintaA initializeAfterFileIn!
CintaB initializeAfterFileIn!
ExtractorDeCarbon initializeAfterFileIn!
ExtractorDeHierro initializeAfterFileIn!