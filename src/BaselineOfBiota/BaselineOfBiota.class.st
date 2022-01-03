Class {
	#name : #BaselineOfBiota,
	#superclass : #BaselineOf,
	#category : #BaselineOfBiota
}

{ #category : #baseline }
BaselineOfBiota >> baseline: spec [
	
	<baseline>
	spec for: #'common' do: [			
		spec package: 'Biota' ]
]
