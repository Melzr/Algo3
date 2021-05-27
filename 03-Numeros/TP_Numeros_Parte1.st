!classDefinition: #NumeroTest category: 'Numeros-Parte1-Ejercicio'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:40'!
test01isZeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'LL 9/13/2020 15:15:53'!
test02isZeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:15:37'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:16:19'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:44:24'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: (Numero with: negativeOne over: two)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/8/2019 21:09:34'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	! !


!classDefinition: #Numero category: 'Numeros-Parte1-Ejercicio'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Numero methodsFor: 'arithmetic operations' stamp: 'LL 9/13/2020 16:33:53'!
* aMultiplier 

	type = #Entero ifTrue:	
		[ ^self class with: value * aMultiplier integerValue ].
		
	type = #Fraccion ifTrue:
		[ ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) ].
		
	self error: 'Tipo de número no soportado'
	! !

!Numero methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:18:42'!
+ anAdder 

	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:57:43'!
negated

	self subclassResponsibility.! !


!Numero methodsFor: 'testing' stamp: 'MC 5/26/2021 23:56:53'!
isNegative

	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'MC 5/26/2021 23:56:38'!
isOne

	self subclassResponsibility.! !

!Numero methodsFor: 'testing' stamp: 'MC 5/26/2021 23:12:15'!
isZero
	self subclassResponsibility.! !


!Numero methodsFor: 'initialization' stamp: 'MC 5/27/2021 00:44:01'!
initializeWith: aValue

	self subclassResponsibility.! !

!Numero methodsFor: 'initialization' stamp: 'MC 5/26/2021 23:01:46'!
initializeWith: aNumerator over: aDenominator

	self subclassResponsibility.! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 21:55:04'!
type
	
	^type! !


!Numero methodsFor: 'printing' stamp: 'NR 9/8/2019 21:59:58'!
printOn: aStream
	
	type = #Entero ifTrue:
		[ aStream print: value ].
	
	type = #Fraccion ifTrue:
		[ aStream 
			print: numerator;
			nextPut: $/;
			print: denominator ].! !


!Numero methodsFor: 'comparing' stamp: 'MC 5/27/2021 00:24:50'!
= anObject

	self subclassResponsibility.! !

!Numero methodsFor: 'comparing' stamp: 'NR 9/8/2019 22:00:49'!
hash
	type = #Entero ifTrue:
		[ ^value hash ].
	type = #Fraccion ifTrue:
		[ ^(numerator hash / denominator hash) hash ].! !


!Numero methodsFor: 'arithmetic operations - private' stamp: 'MC 5/26/2021 23:59:16'!
// aDivisor

	self subclassResponsibility.! !

!Numero methodsFor: 'arithmetic operations - private' stamp: 'MC 5/26/2021 23:53:36'!
greatestCommonDivisorWith: anEntero 

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numeros-Parte1-Ejercicio'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !


!Numero class methodsFor: 'instance creation' stamp: 'MC 5/26/2021 23:07:07'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^(Entero new) initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'MC 5/27/2021 01:11:33'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^ (Fraccion new) initializeWith: numerator over: denominator.! !


!classDefinition: #Entero category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Entero methodsFor: 'as yet unclassified' stamp: 'MC 5/26/2021 23:30:20'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'testing' stamp: 'MC 5/26/2021 23:14:03'!
isNegative
	
	^ value < 0.
	! !

!Entero methodsFor: 'testing' stamp: 'MC 5/26/2021 23:55:32'!
isOne

	^ value = 1.
	! !

!Entero methodsFor: 'testing' stamp: 'MC 5/26/2021 23:14:08'!
isZero

 	^ value = 0.
	! !


!Entero methodsFor: 'initialization' stamp: 'MC 5/26/2021 22:59:36'!
initializeWith: aValue

	value := aValue.! !


!Entero methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:19:06'!
* aMultiplier 

	^ self class with: value * aMultiplier integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:14:06'!
+ anAdder 
	
	^ self class with: value + anAdder integerValue.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:56:56'!
negated
	
	^ self * (self class with: -1).! !


!Entero methodsFor: 'arithmetic operations - private' stamp: 'MC 5/26/2021 23:58:36'!
// aDivisor 
	
	^ self class with: value // aDivisor integerValue.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'MC 5/26/2021 23:27:04'!
greatestCommonDivisorWith: anEntero 
	
	^ self class with: (value gcd: anEntero integerValue).
! !


!Entero methodsFor: 'comparing' stamp: 'MC 5/27/2021 00:23:43'!
= anObject

	(anObject isKindOf: self class) ifTrue: [ ^value = anObject integerValue ].
	^ false.
! !


!classDefinition: #Fraccion category: 'Numeros-Parte1-Ejercicio'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Parte1-Ejercicio'!

!Fraccion methodsFor: 'testing' stamp: 'MC 5/26/2021 23:14:28'!
isNegative
	
	^ denominator < 0.! !

!Fraccion methodsFor: 'testing' stamp: 'MC 5/26/2021 23:55:54'!
isOne
		
	^ false.! !

!Fraccion methodsFor: 'testing' stamp: 'MC 5/26/2021 23:11:58'!
isZero
		
	^ false.! !


!Fraccion methodsFor: 'initialization' stamp: 'MC 5/27/2021 00:55:18'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:19:52'!
* aMultiplier 

	^ self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator).! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:14:52'!
+ anAdder 

	| newNumerator newDenominator |
		
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
		
	^ self class with: newNumerator over: newDenominator.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'MC 5/27/2021 00:57:13'!
negated
	
	^ self class with: numerator * (self class with: -1) over: denominator.! !


!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MC 5/26/2021 23:58:52'!
// aDivisor 

	self error: 'Tipo de número no soportado'.! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'MC 5/26/2021 23:27:45'!
greatestCommonDivisorWith: aFraccion 
		
	self error: 'Tipo de número no soportado'.! !


!Fraccion methodsFor: 'comparing' stamp: 'MC 5/27/2021 00:24:38'!
= anObject

	(anObject isKindOf: self class) ifTrue: [ ^(numerator * anObject denominator) = (denominator * anObject numerator) ].
	^ false.
! !
