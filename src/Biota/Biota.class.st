"
A two dimensional space, addressed by points, which stores the characters that are biota programs and data.  Class methods define the size of the space and a single character, called empty, that marks unused cells.
"
Class {
	#name : #Biota,
	#superclass : #Object,
	#instVars : [
		'medium'
	],
	#category : #Biota
}

{ #category : #accessing }
Biota class >> empty [
	^$ .

]

{ #category : #accessing }
Biota class >> height [
	^ 24
]

{ #category : #accessing }
Biota class >> size [
	^ Biota width * Biota height
]

{ #category : #accessing }
Biota class >> width [
	^ 40
]

{ #category : #accessing }
Biota >> at: aPoint [
	^medium at: aPoint offset
]

{ #category : #accessing }
Biota >> at: aPoint put: aCharacter [
	^medium at: aPoint offset put: aCharacter
]

{ #category : #accessing }
Biota >> initialize [
	medium := String new: Biota size.
	medium atAllPut: Biota empty.
]
