Class {
	#name : #BiotaEngine,
	#superclass : #Object,
	#instVars : [
		'dispatch',
		'biota',
		'program',
		'data',
		'clock'
	],
	#category : #Biota
}

{ #category : #accessing }
BiotaEngine >> execute: aCharacter [
	| aSymbol | 
    aSymbol := dispatch at: aCharacter asciiValue. 
    ^ aSymbol notNil 
        ifTrue: [self perform: aSymbol] 
        ifFalse: [aCharacter = $.]
]

{ #category : #accessing }
BiotaEngine >> load: aString [
	| column  row  pos | 
    row := data copy. 
    column := data copy turn: 2. 
    pos := 0. 
     aString do: 
        [:each | pos := pos + 1. 
        (each asciiValue = 10) ifTrue: 
            [row := column go copy turn: -2.  pos := 0]. 
        (pos odd) ifTrue: 
            [biota at: row put: each. row go]. 
        (each = $®) ifTrue: 
            [program := row copy go: -1]. 
        ('/\/\' includes: each) ifTrue: 
            [data := row copy go: -1. 
            data direction: ('/\/\' indexOf: each) - 1]]
]

{ #category : #accessing }
BiotaEngine >> newMethod [
	"This is a new method"
]
