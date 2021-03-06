"
******************************************************************************
Project : biota
Date    : Dec  4, 1991
Time    : 15:41:40

Classes : 
    BiotaIndex Biota DisplayBiota TestEngine 
    BiotaEngine 

Methods : 
    #offset defined in Point.

******************************************************************************
"!

Object subclass: #Biota
  instanceVariableNames: 
    'medium '
  classVariableNames: ''
  poolDictionaries: ''!

Biota subclass: #DisplayBiota
  instanceVariableNames: 
    'scanner '
  classVariableNames: ''
  poolDictionaries: ''!

Object subclass: #Point
  instanceVariableNames: 
    'x y '
  classVariableNames: ''
  poolDictionaries: ''!

Object subclass: #BiotaEngine
  instanceVariableNames: 
    'dispatch biota program data clock '
  classVariableNames: ''
  poolDictionaries: ''!

Point subclass: #BiotaIndex
  instanceVariableNames: 
    'direction biota '
  classVariableNames: ''
  poolDictionaries: ''!

BiotaEngine subclass: #TestEngine
  instanceVariableNames: ''
  classVariableNames: ''
  poolDictionaries: ''!


!BiotaIndex class methods ! !


!BiotaIndex methods !

biota: aBiota 
 
    biota := aBiota!

contents 
 
    ^biota at: self!

contents: aCharacter 
 
    biota at: self put: aCharacter!

direction 
 
    ^direction!

direction: anInteger 
 
    direction := anInteger \\ 8!

go 
 
    x := x + (#(0 1 1 1 0 -1 -1 -1) at: direction + 1) \\ Biota width. 
    y := y + (#(-1 -1 0 1 1 1 0 -1) at: direction + 1) \\ Biota height!

go: anInteger 
 
    x := x + (anInteger * (#(0 1 1 1 0 -1 -1 -1) at: direction + 1)) \\ Biota width. 
    y := y + (anInteger * (#(-1 -1 0 1 1 1 0 -1) at: direction + 1)) \\ Biota height!

in: aBiota do: aBlock 
 
    #(0 1 -1 2 -2 3 -3 4) do: 
        [:each | 
        self turn: each; go. 
        aBlock value: self contents. 
        self go: -1; turn: each negated]!

in: aBiota emptyDo: aBlock 
 
    self in: aBiota do: 
        [:each | each = Biota empty ifTrue: 
            [aBlock value: each]]!

in: aBiota fullDo: aBlock 
 
    self in: aBiota do: 
        [:each | each = Biota empty ifFalse: 
            [aBlock value: each]]!

isEmpty 
 
    ^ self contents = Biota empty!

turn: anInteger 
 
    direction := direction + anInteger \\ 8!

turnAlong: aBiota 
 
    self in: aBiota fullDo: 
        [:c | self go: -1. ^self]!

turnAway: aBiota 
 
    self in: aBiota emptyDo: 
        [:c | self go: -1. ^self]! !


!Biota class methods !

empty 
 
    ^$ .!

height 
 
    ^ 24!

size 
 
    ^ Biota width * Biota height!

width 
 
    ^ 40! !


!Biota methods !

at: aPoint 
 
    ^medium at: aPoint offset!

at: aPoint put: aCharacter 
 
    ^medium at: aPoint offset put: aCharacter!

initialize 
 
    medium := String new: Biota size. 
    medium atAllPut: Biota empty.! !


!DisplayBiota class methods ! !


!DisplayBiota methods !

at: aPoint display: aCharacter 
 
    scanner isNil ifTrue: 
        [scanner := CharacterScanner new 
            initialize: Display boundingBox font: SysFont; 
            setForeColor: 0 backColor: 9]. 
    scanner 
        display: (String with: aCharacter) 
        from: 1 to: 1 at: aPoint * (8@16)!

at: aPoint put: aCharacter 
 
    super at: aPoint put: aCharacter. 
    self at: aPoint * (2@1) display: aCharacter!

capture 
 
    | region | 
    region := PointDispatcher 
        rectangleFromUserOfSize: 20@20. 
    (BiColorForm foreColor: 9 backColor: 0) 
        width: region width height: region height; 
        fromDisplay: region; 
        offset: 0@0; 
        writeMacPaint: 'm:talk\ward\screen'! !


!TestEngine class methods !

example

    TestEngine new
        initialize;
        load: TestEngine flagellum;
        run!

flagellum

    ^'

        . . c .
        . . s . .
        t   g
        t   t
        t   . t . .?d
        t   s   .     .
        b   .   b . s s .               12 3 4 5
    . s s . b   .   b
      .     .   s   t
        u d t t t   t
                t   t
                g   t
            . . s . .
              . c . .
'!

remoteGrowth 
 
    ^' 
 
 
        g?g 
      g     r 
      t     g 
        g g 
 
 
 
 
                                          1. 3 # 
 
'!

unlimitedGrowth 
 
    ^' 
 
 
 
              ? ? ? ? 
              ? g g?? 
              ? r r ? 
              ? ? ? ? 
 
 
                                      ? 
 
 
 
 
'! !


!TestEngine methods !

again 
 
    ^self execute: 
        (program copy go: -1) 
            contents!

backup 
 
    data go: -1. 
    ^data isEmpty 
        ifTrue: [data go. false] 
        ifFalse: [true]!

clear 
 
    ^ data isEmpty 
        ifTrue: [false] 
        ifFalse: [data contents: Biota empty. true]!

duplicate 
 
    | aPoint | 
    data isEmpty ifTrue: [^false]. 
    aPoint := data copy turn: -2; go. 
    ^ aPoint isEmpty 
        ifTrue: [aPoint contents: data contents. true] 
        ifFalse: [false]!

face 
 
    data turnAlong: biota. 
    ^true!

go 
 
    data in: biota fullDo: 
        [:c |  ^true]. 
    ^false!

home 
 
    data := program copy. 
    ^ true!

quit 
 
    KeyboardSemaphore signal. 
    ^true!

ruplicate 
 
    | aPoint | 
    aPoint := data copy turnAway: biota; go. 
    ^ aPoint isEmpty 
        ifTrue: [aPoint contents: data contents. true] 
        ifFalse: [false]!

straight 
 
    data go. 
    ^data isEmpty 
        ifTrue: [data go: -1. false] 
        ifFalse: [true]!

turn 
 
    data turn: 1. 
    ^ true!

unturn 
 
    data turn: -1. 
    ^ true! !


!BiotaEngine class methods !

dispatch 
 
    | dispatch | 
    dispatch := Array new: 256. 
    self methodDictionary keys do: 
        [:each | 
        dispatch 
            at: each first asciiValue 
            put: each]. 
    ^ dispatch! !


!BiotaEngine methods !

debug 
 
    | c | 
    [self showMarks. 
    (c :=Terminal read) = $q] whileFalse: 
        [self hideMarks. 
        c = $  ifTrue: [self step]. 
        c = $r ifTrue: [[KeyboardSemaphore hasSignals not] whileTrue: [self step]]. 
        c = $c ifTrue: [self showMarks. biota capture]]!

execute: aCharacter 
 
    | aSymbol | 
    aSymbol := dispatch at: aCharacter asciiValue. 
    ^ aSymbol notNil 
        ifTrue: [self perform: aSymbol] 
        ifFalse: [aCharacter = $.]!

hideMarks 
 
    biota at: data * (2@1) + (1@0) display: $ . 
    biota at: program * (2@1) + (1@0) display: $ .!

initialize 
 
    biota := DisplayBiota new initialize. 
    program := BiotaIndex new x: 0; y: 0; direction: 2; biota: biota. 
    data := program copy. 
    dispatch := self class dispatch!

load: aString 
 
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
            data direction: ('/\/\' indexOf: each) - 1]]!

mutate 
 
    | s  i | 
    i := dispatch at: (biota at: program) asciiValue. 
    s := dispatch select: #notNil. 
    i := s at: (s indexOf: i) \\ s size + 1. 
    biota at: program put: i first!

run

    [true] whileTrue:
        [self step]!

showMarks 
 
    biota at: data * (2@1) + (1@0) display: ('/\/\' at: data direction + 1). 
    biota at: program * (2@1) + (1@0) display: $?!

step 
 
    program in: biota do: 
        [:c | (self execute: c) ifTrue: [^self]]. 
    program turnAlong: biota; go! !


!Point methods !
offset 
 
    ^ y * Biota width + x + 1! !
"construct application" 
((Smalltalk at: #Application ifAbsent: []) 
    isKindOf: Class) ifTrue: [ 
        ((Smalltalk at: #Application) for:'biota')
            addClass: BiotaIndex;
            addClass: Biota;
            addClass: DisplayBiota;
            addClass: TestEngine;
            addClass: BiotaEngine;
            addMethod: #offset forClass: Point;
            comments: nil;
            initCode: nil;
            finalizeCode: nil;
            startUpCode: nil]!
