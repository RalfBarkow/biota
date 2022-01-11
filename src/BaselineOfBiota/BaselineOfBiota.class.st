Class {
	#name : #BaselineOfBiota,
	#superclass : #BaselineOf,
	#category : #BaselineOfBiota
}

{ #category : 'accessing' }
BaselineOfBiota class >> loadLepiter [
	| currentProperties |
	currentProperties := LeDatabasesRegistry defaultLogicalDatabase properties.
	currentProperties
		addRegisteredDirectory: FileLocator imageDirectory
			/ 'pharo-local'
			/ 'iceberg'
			/ 'feenkcom'
			/ 'gt4edx'
			/ 'lepiter'.
	
	LeDatabasesRegistry default defaultLogicalDatabase reload.
]

{ #category : #baseline }
BaselineOfBiota >> baseline: spec [
	
	<baseline>
	spec for: #'common' do: [			
		spec package: 'Biota' ]
]
