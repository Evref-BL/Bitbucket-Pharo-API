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

{ #category : 'api' }
BitbucketRessource >> postJson: endpoint withData: data [

	| response |
	bitbucketApi prepareClient.
	bitbucketApi client path: bitbucketApi basePath , endpoint.

	bitbucketApi client entity:
		(ZnEntity with: (NeoJSONWriter toString: data)).
	bitbucketApi client contentType: 'application/json'.

	response := bitbucketApi client post.

	^ NeoJSONReader fromString: response
]

{ #category : 'api' }
BitbucketRessource >> put: endpoint withData: data [

	| response |
	bitbucketApi prepareClient.
	bitbucketApi client path: bitbucketApi basePath , endpoint.

	data keysAndValuesDo: [ :key :value |
		bitbucketApi client addPart:
			(ZnMimePart fieldName: key value: value) ].

	response := bitbucketApi client put.
	
	^ NeoJSONReader fromString: response
]
