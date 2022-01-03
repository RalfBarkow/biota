Class {
	#name : #BiotaIndex,
	#superclass : #Point,
	#instVars : [
		'direction',
		'biota'
	],
	#category : #Biota
}

{ #category : #accessing }
BiotaIndex >> biota: aBiota [
	biota := aBiota
]

{ #category : #accessing }
BiotaIndex >> contents [
	^biota at: self
]

{ #category : #accessing }
BiotaIndex >> contents: aCharacter [
	biota at: self put: aCharacter
]

{ #category : #accessing }
BiotaIndex >> direction [
	^direction
]

{ #category : #accessing }
BiotaIndex >> direction: anInteger [
	direction := anInteger \\ 8
]

{ #category : #accessing }
BiotaIndex >> go [
	x := x + (#(0 1 1 1 0 -1 -1 -1) at: direction + 1) \\ Biota width.
	y := y + (#(-1 -1 0 1 1 1 0 -1) at: direction + 1) \\ Biota height
]

{ #category : #accessing }
BiotaIndex >> go: anInteger [
	x := x + (anInteger * (#(0 1 1 1 0 -1 -1 -1) at: direction + 1)) \\ Biota width.
	y := y + (anInteger * (#(-1 -1 0 1 1 1 0 -1) at: direction + 1)) \\ Biota height
]

{ #category : #accessing }
BiotaIndex >> in: aBiota do: aBlock [
	#(0 1 -1 2 -2 3 -3 4) do: 
		[:each |
			self turn: each; go. 
			aBlock value: self contents.
			self go: -1; turn: each negated]
]

{ #category : #accessing }
BiotaIndex >> in: aBiota emptyDo: aBlock [
	self in: aBiota do:
		[:each | each = Biota empty ifTrue: 
			[aBlock value: each]]
]

{ #category : #accessing }
BiotaIndex >> in: aBiota fullDo: aBlock [
	self in: aBiota do:
		[:each | each = Biota empty ifFalse:
			[aBlock value: each]]
]

{ #category : #accessing }
BiotaIndex >> isEmpty [
	^ self contents = Biota empty
]

{ #category : #accessing }
BiotaIndex >> turn: anInteger [
	direction := direction + anInteger \\ 8.
]

{ #category : #accessing }
BiotaIndex >> turnAlong: aBiota [
	self in: aBiota fullDo:
		[:c | self go: -1. ^self]
]

{ #category : #accessing }
BiotaIndex >> turnAway: aBiota [
	self in: aBiota emptyDo: 
		[:c | self go: -1. ^self].
]
