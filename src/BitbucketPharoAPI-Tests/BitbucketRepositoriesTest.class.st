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
BitbucketRepositoriesTest >> testAllInProject [

	| hostUrl client bitbucketApi projectKey endpoint response result bitbucketRepos |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketRepositories new bitbucketApi:
		                  bitbucketApi.

	projectKey := 'OOO'.

	endpoint := '/projects/' , projectKey , '/repos'.

	response := { (#repo -> '1') } asDictionary.

	(bitbucketRepos stub getAll: endpoint withParams: Dictionary new)
		willReturn: response.

	"When"
	result := bitbucketRepos allInProject: projectKey.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
BitbucketRepositoriesTest >> testGetOfProject [

	| hostUrl client bitbucketApi projectKey endpoint response result bitbucketRepos repoKey |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketRepositories new bitbucketApi:
		                  bitbucketApi.

	projectKey := 'OOO'.
	repoKey := 'rep'.
	endpoint := '/projects/' , projectKey , '/repos/' , repoKey.

	response := {
		            (#slug -> repoKey).
		            (#id -> 1) } asDictionary.

	(bitbucketRepos stub get: endpoint withParams: Dictionary new)
		willReturn: response.

	"When"
	result := bitbucketRepos get: 'rep' ofProject: 'OOO'.

	"Then"
	self assert: result equals: response
]

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

{ #category : 'tests' }
BitbucketRepositoriesTest >> testUpdateFileWithParamsInRepositoryOfProject [

	| hostUrl gitlabApi result client filePath response bitbucketRepositories projectKey repoSlug bitbucketUpdateFileParams endpoint |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketRepositories := BitbucketRepositories new bitbucketApi:
		                         gitlabApi.

	filePath := 'file.txt'.
	projectKey := 'BBB'.
	repoSlug := 'project'.

	bitbucketUpdateFileParams := BitbucketUpdateFileParams new
		                             newContent: 'new content';
		                             commitMessage: 'message';
		                             sourceCommitId: 'ez21rferg31';
		                             branch: 'test'.

	response := { (#message -> 'success') } asDictionary.

	endpoint := '/projects/' , projectKey , '/repos/' , repoSlug
	            , '/browse/' , filePath.
	(bitbucketRepositories stub
		 put: endpoint
		 withData: bitbucketUpdateFileParams asDictionary) willReturn:
		response.

	"When"
	result := bitbucketRepositories
		          updateFile: filePath
		          withParams: bitbucketUpdateFileParams
		          inRepository: repoSlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: response.
]
