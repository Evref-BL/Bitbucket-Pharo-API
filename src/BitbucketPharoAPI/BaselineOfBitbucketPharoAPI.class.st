Class {
	#name : 'BaselineOfBitbucketPharoAPI',
	#superclass : 'BaselineOf',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
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
]

{ #category : 'baselines' }
BaselineOfBitbucketPharoAPI >> defineGroups: spec [

]

{ #category : 'baselines' }
BaselineOfBitbucketPharoAPI >> definePackages: spec [
	spec
		package: 'BitbucketPharoAPI'
]
