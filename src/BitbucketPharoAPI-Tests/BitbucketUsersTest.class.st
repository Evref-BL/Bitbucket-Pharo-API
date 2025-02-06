"
A BitbucketUsersTest is a test class for testing the behavior of BitbucketUsers
"
Class {
	#name : 'BitbucketUsersTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketUsersTest >> testAllWithParams [

	| hostUrl client bitbucketApi endpoint response result params bitbucketUsers |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketUsers := BitbucketUsers new bitbucketApi: bitbucketApi.

	params := { (#filter -> 'email') } asDictionary.

	endpoint := '/users'.

	response := { (#user -> '1') } asDictionary.

	(bitbucketUsers stub getAll: endpoint withParams: params)
		willReturn: response.

	"When"
	result := bitbucketUsers allWithParams: params.

	"Then"
	self assert: result equals: response
]
