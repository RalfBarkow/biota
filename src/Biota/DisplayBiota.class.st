"
A kind of biota that echos it's modifications the computer display.
"
Class {
	#name : #DisplayBiota,
	#superclass : #Biota,
	#instVars : [
		'scanner'
	],
	#category : #Biota
}

{ #category : #accessing }
DisplayBiota >> at: aPoint display: aCharacter [ 
 
    scanner isNil ifTrue: 
        [scanner := CharacterScanner new 
            initialize: Display boundingBox font: SysFont; 
            setForeColor: 0 backColor: 9]. 
    scanner 
        display: (String with: aCharacter) 
        from: 1 to: 1 at: aPoint * (8@16)
]

{ #category : #accessing }
DisplayBiota >> at: aPoint put: aCharacter [ 
 
    super at: aPoint put: aCharacter. 
    self at: aPoint * (2@1) display: aCharacter
]

{ #category : #accessing }
DisplayBiota >> capture [ 
 
    | region | 
    region := PointDispatcher 
        rectangleFromUserOfSize: 20@20. 
    (BiColorForm foreColor: 9 backColor: 0) 
        width: region width height: region height; 
        fromDisplay: region; 
        offset: 0@0; 
        writeMacPaint: 'm:talk\ward\screen'
]
