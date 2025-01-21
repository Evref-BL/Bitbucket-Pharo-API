"
A BitbucketRepositoriesTest is a test class for testing the behavior of BitbucketRepositories
"
Class {
	#name : 'BitbucketRepositoriesTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketRepositoriesTest >> testRawFileWithParamsInRepositoryOfProject [

	| hostUrl gitlabApi result client filePath response params bitbucketRepositories projectKey repoSlug |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketRepositories := BitbucketRepositories new bitbucketApi: gitlabApi.

	filePath := 'file.txt'.
	projectKey := 'BBB'.
	repoSlug := 'project'.
	params := { (#at -> 'ref') } asDictionary.

	response := 'content'.

	client stub get willReturn: response.

	"When"
	result := bitbucketRepositories rawFile: filePath withParams: params inRepository: repoSlug  ofProject: projectKey. 

	"Then"
	self assert: result equals: response.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]
