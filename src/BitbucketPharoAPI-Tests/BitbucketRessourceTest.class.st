"
A BitbucketRessourceTest is a test class for testing the behavior of BitbucketRessource
"
Class {
	#name : 'BitbucketRessourceTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketRessourceTest >> testGetWithParams [

	| hostUrl result client object endpoint params bitbucketApi bitbucketRessource |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	object := { (#id -> 1) } asDictionary.

	bitbucketRessource := BitbucketRessource new bitbucketApi: bitbucketApi.

	client stub get willReturn: (NeoJSONWriter toString: object).

	"When"
	result := bitbucketRessource get: endpoint withParams: params.

	"Then"
	self assert: result equals: object.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]
