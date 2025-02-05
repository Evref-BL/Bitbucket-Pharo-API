"
A BitbucketCommitsTest is a test class for testing the behavior of BitbucketCommits
"
Class {
	#name : 'BitbucketCommitsTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketCommitsTest >> testAllWithParamsInRepositoryOfProject [

	"Given"

	| hostUrl client bitbucketApi projectKey repositorySlug endpoint response result params bitbucketCommits |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketCommits := BitbucketCommits new bitbucketApi: bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.

	params := { (#until -> 'dev') } asDictionary.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits'.

	response := { (#commitId -> '1') } asDictionary.

	(bitbucketCommits stub getAll: endpoint withParams: params)
		willReturn: response.

	"When"
	result := bitbucketCommits
		          allWithParams: params
		          inRepository: repositorySlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: response
]
