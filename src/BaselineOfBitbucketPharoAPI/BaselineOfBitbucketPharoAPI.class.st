Class {
	#name : 'BaselineOfBitbucketPharoAPI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBitbucketPharoAPI',
	#package : 'BaselineOfBitbucketPharoAPI'
}

{ #category : 'baselines' }
BaselineOfBitbucketPharoAPI >> baseline: spec [
	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfBitbucketPharoAPI >> defineDependencies: spec [

	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ].
		
		spec
		baseline: 'Mocketry'
		with: [ spec repository: 'github://dionisiydk/Mocketry' ]
]

{ #category : 'baselines' }
BaselineOfBitbucketPharoAPI >> defineGroups: spec [

]

{ #category : 'baselines' }
BaselineOfBitbucketPharoAPI >> definePackages: spec [

	spec package: 'BitbucketPharoAPI'.
	
	spec
		package: 'BitbucketPharoAPI-Tests'
		with: [ spec requires: #( 'BitbucketPharoAPI' 'Mocketry' ) ].
]
