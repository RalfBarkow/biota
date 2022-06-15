"
A processor that can interpret programs stored in a biota. Includes a loader and debugger. A class method constructs an instruction dispatch table from a method dictionary.

The loader expects data in odd numbered columns and control characters in the others. '$' marks the initial program counter; '#' the initial data pointer. (Use cut and paste to type these characters.)

The debugger will single step with each press of the space bar. Press and hold 'r' to run at high speed. 'q' will quit. (Collapse or frame all windows to the bottom inch of the display before running. Redraw screen when finished.)
"
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

{ #category : #accesing }
BiotaEngine class >> dispatch [ 
 
    | dispatch | 
    dispatch := Array new: 256. 
    self methodDictionary keys do: 
        [:each | 
        dispatch 
            at: each first asciiValue 
            put: each]. 
    ^ dispatch
]

{ #category : #accessing }
BiotaEngine >> debug [ 
 
    | c | 
    [self showMarks. 
    (c :=Terminal read) = $q] whileFalse: 
        [self hideMarks. 
        c = $  ifTrue: [self step]. 
        c = $r ifTrue: [[KeyboardSemaphore hasSignals not] whileTrue: [self step]]. 
        c = $c ifTrue: [self showMarks. biota capture]]
]

{ #category : #accessing }
BiotaEngine >> execute: aCharacter [ 
 
    | aSymbol | 
    aSymbol := dispatch at: aCharacter asciiValue. 
    ^ aSymbol notNil 
        ifTrue: [self perform: aSymbol] 
        ifFalse: [aCharacter = $.]
]

{ #category : #'as yet unclassified' }
BiotaEngine >> hideMarks [ 
 
    biota at: data * (2@1) + (1@0) display: $ . 
    biota at: program * (2@1) + (1@0) display: $ .
]

{ #category : #'as yet unclassified' }
BiotaEngine >> initialize [ 
 
    biota := DisplayBiota new initialize. 
    program := BiotaIndex new x: 0; y: 0; direction: 2; biota: biota. 
    data := program copy. 
    dispatch := self class dispatch
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
        (each = $?) ifTrue: 
            [program := row copy go: -1]. 
        ('/\/\' includes: each) ifTrue: 
            [data := row copy go: -1. 
            data direction: ('/\/\' indexOf: each) - 1]]
]

{ #category : #'as yet unclassified' }
BiotaEngine >> mutate [ 
 
    | s  i | 
    i := dispatch at: (biota at: program) asciiValue. 
    s := dispatch select: #notNil. 
    i := s at: (s indexOf: i) \\ s size + 1. 
    biota at: program put: i first
]

{ #category : #accessing }
BiotaEngine >> newMethod [
	"This idebug 
 
    | c | 
    [self showMarks. 
    (c :=Terminal read) = $q] whileFalse: 
        [self hideMarks. 
        c = $  ifTrue: [self step]. 
        c = $r ifTrue: [[KeyboardSemaphore hasSignals not] whileTrue: [self step]]. 
        c = $c ifTrue: [self showMarks. biota capture]]!s a new method"
]

{ #category : #'as yet unclassified' }
BiotaEngine >> run [

    [true] whileTrue:
        [self step]
]

{ #category : #accessing }
BiotaEngine >> showMarks [ 
 
    biota at: data * (2@1) + (1@0) display: ('/\/\' at: data direction + 1). 
    biota at: program * (2@1) + (1@0) display: $?
]

{ #category : #'as yet unclassified' }
BiotaEngine >> step [ 
 
    program in: biota do: 
        [:c | (self execute: c) ifTrue: [^self]]. 
    program turnAlong: biota; go
]
