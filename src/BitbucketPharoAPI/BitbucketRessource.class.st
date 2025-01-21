Class {
	#name : 'BitbucketRessource',
	#superclass : 'Object',
	#instVars : [
		'bitbucketApi'
	],
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'accessing' }
BitbucketRessource >> bitbucketApi: anObject [

	bitbucketApi := anObject
]

{ #category : 'api' }
BitbucketRessource >> get: path withParams: paramsDict [

	| response |
	bitbucketApi prepareClient.
	bitbucketApi client path: bitbucketApi basePath , path.

	paramsDict keysAndValuesDo: [ :key :value |
		bitbucketApi client queryAt: key put: value ].

	response := bitbucketApi client get.

	bitbucketApi output = 'dict' ifTrue: [
		^ NeoJSONReader fromString: response ].

	^ response
]
