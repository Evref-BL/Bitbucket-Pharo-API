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
BitbucketRessourceTest >> testGetAllWithParams [
	"Given"

	| hostUrl client endpoint params objectId object bitbucketApi bitbucketRessource result response |
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	bitbucketRessource := BitbucketRessource new bitbucketApi:
		                      bitbucketApi.
		
		
	response := { #values -> { object }. #isLastPage -> true } asDictionary.
	client stub get willReturn: (NeoJSONWriter toString: response).
		

	"When"
	result := bitbucketRessource getAll: endpoint withParams: params.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: object
]

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

{ #category : 'tests' }
BitbucketRessourceTest >> testGetWithParamsJsonOutput [

	| hostUrl result client object endpoint params bitbucketApi bitbucketRessource |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client;
							output: 'json'.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	object := { (#id -> 1) } asDictionary.

	bitbucketRessource := BitbucketRessource new bitbucketApi:
		                      bitbucketApi.

	client stub get willReturn: (NeoJSONWriter toString: object).

	"When"
	result := bitbucketRessource get: endpoint withParams: params.

	"Then"
	self assert: result equals: (NeoJSONWriter toString: object).
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
BitbucketRessourceTest >> testPostJsonWithData [

	| hostUrl result client endpoint gitlabRessource data responseMessage response bitbucketApi |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabRessource := BitbucketRessource new bitbucketApi: bitbucketApi.

	client stub post willReturn: response.

	"When"
	result := gitlabRessource postJson: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	self
		assert: client request entity contentType asString
		equals: 'application/json'.
	self
		assert: client request entity string
		equals: (NeoJSONWriter toString: data)
]

{ #category : 'tests' }
BitbucketRessourceTest >> testPutWithData [

	| hostUrl result client endpoint gitlabRessource data responseMessage response bitbucketApi |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabRessource := BitbucketRessource new bitbucketApi: bitbucketApi.

	client stub put willReturn: response.

	"When"
	result := gitlabRessource put: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.

	client request entity parts doWithIndex: [ :part :index |
		self assert: part fieldName equals: (data keys at: index).

		self assert: part fieldValue equals: (data values at: index) ]
]
