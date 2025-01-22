"
A BitbucketBranchesTest is a test class for testing the behavior of BitbucketBranches
"
Class {
	#name : 'BitbucketBranchesTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketBranchesTest >> testCreateWithStartPointInRepositoryOfProject [

	"Given"
	| hostUrl client bitbucketApi projectKey repositorySlug endpoint response result bitbucketBranches branchName startPoint data |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.
		
	bitbucketBranches := BitbucketBranches new bitbucketApi:
		                         bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	
	branchName := 'test'.
	startPoint := 'dev'.
	
	data := { 
		#name -> branchName.
		#startPoint -> startPoint
	 } asDictionary.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/branches'.

	response := { (#message -> 'message') } asDictionary.

	(bitbucketBranches stub
		 postJson: endpoint
		 withData: data) willReturn: response.

	"When"
	result := bitbucketBranches create: branchName withStartPoint: startPoint inRepository: repositorySlug  ofProject: projectKey.

	"Then"
	self assert: result equals: response
]
