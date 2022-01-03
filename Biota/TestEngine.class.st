"
An experimental biota engine with twelve instructions. Class methods answer sample programs written for this engine.
"
Class {
	#name : #TestEngine,
	#superclass : #BiotaEngine,
	#category : #Biota
}

{ #category : #accessing }
TestEngine class >> example [
	<gtExample>
	TestEngine new
        initialize;
        load: TestEngine flagellum;
        run
]

{ #category : #accessing }
TestEngine class >> flagellum [
	^'

        . . c .
        . . s . .
        t   g
        t   t
        t   . t . .®d
        t   s   .     .
        b   .   b . s s .               12 3 4 5
    . s s . b   .   b
      .     .   s   t
        u d t t t   t
                t   t
                g   t
            . . s . .
              . c . .
'
]

{ #category : #accessing }
TestEngine class >> remoteGrowth [ 
 
    ^' 
 
 
        g®g 
      g     r 
      t     g 
        g g 
 
 
 
 
                                          1. 3 # 
 
'
]

{ #category : #accessing }
TestEngine class >> unlimitedGrowth [ 
 
    ^' 
 
 
 
              ð ð ð ð 
              ð g g®ð 
              ð r r ð 
              ð ð ð ð 
 
 
                                      þ 
 
 
 
 
'
]

{ #category : #accessing }
TestEngine >> again [
	^self execute: 
        (program copy go: -1) 
            contents
]

{ #category : #accessing }
TestEngine >> backup [
		data go: -1. 
    ^data isEmpty 
        ifTrue: [data go. false] 
        ifFalse: [true]
]

{ #category : #accessing }
TestEngine >> clear [
	^ data isEmpty 
        ifTrue: [false] 
        ifFalse: [data contents: Biota empty. true]
]

{ #category : #accessing }
TestEngine >> duplicate [ 
 
    | aPoint | 
    data isEmpty ifTrue: [^false]. 
    aPoint := data copy turn: -2; go. 
    ^ aPoint isEmpty 
        ifTrue: [aPoint contents: data contents. true] 
        ifFalse: [false]
]

{ #category : #accessing }
TestEngine >> execute: anObject [ 
]

{ #category : #accessing }
TestEngine >> go [ 
 
    data in: biota fullDo: 
        [:c |  ^true]. 
    ^false
]

{ #category : #accessing }
TestEngine >> home [ 
 
    data := program copy. 
    ^ true
]

{ #category : #accessing }
TestEngine >> quit [ 
 
    KeyboardSemaphore signal. 
    ^true
]

{ #category : #accessing }
TestEngine >> ruplicate [ 
 
    | aPoint | 
    aPoint := data copy turnAway: biota; go. 
    ^ aPoint isEmpty 
        ifTrue: [aPoint contents: data contents. true] 
        ifFalse: [false]
]

{ #category : #accessing }
TestEngine >> turn [
	data turn: 1. 
    ^ true
]
