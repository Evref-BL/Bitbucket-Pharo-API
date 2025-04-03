"
A BitbucketProjectsTest is a test class for testing the behavior of BitbucketProjects
"
Class {
	#name : 'BitbucketProjectsTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketProjectsTest >> testAll [

	| hostUrl client bitbucketApi endpoint response result bitbucketProjects |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketProjects := BitbucketProjects new bitbucketApi: bitbucketApi.


	endpoint := '/projects'.

	response := { (#project -> '1') } asDictionary.

	(bitbucketProjects stub getAll: endpoint withParams: Dictionary new)
		willReturn: response.

	"When"
	result := bitbucketProjects all.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
BitbucketProjectsTest >> testGet [

	| hostUrl client bitbucketApi endpoint response result bitbucketProjects |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketProjects := BitbucketProjects new bitbucketApi: bitbucketApi.


	endpoint := '/projects' , '/hello'.

	response := {(#key -> 'hello')} asDictionary.

	(bitbucketProjects stub get: endpoint withParams: Dictionary new)
		willReturn: {
				(#key -> 'hello').
				(#id -> 1).
				(#name -> 'My Cool Project').
				(#description -> 'The description for my cool project.').
				(#public -> true).
				(#type -> #NORMAL).
				(#links
				 ->
					 {#self
					  -> { { (#href -> 'http://link/to/project') } asDictionary }}
						 asDictionary) } asDictionary.

	"When"
	result := bitbucketProjects get: 'hello'.

	"Then"
	self assert: (result at: #key) equals: (response at: #key)
]
