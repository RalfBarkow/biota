Class {
	#name : #BaselineOfBiota,
	#superclass : #BaselineOf,
	#category : #BaselineOfBiota
}

{ #category : #baseline }
BaselineOfBiota >> baseline: spec [
	
	<baseline>
	spec for: #'common' do: [
	
		spec baseline: 'ExternalProject' with: [
			spec repository: 'github://<organization>/<repository>:main/src' ].
			
		spec package: 'Biota'.
		spec package: 'PackageTwo' with: [ 
			spec requires: #( 'ExternalProject' 'Biota' ) ]
	]
]
