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
