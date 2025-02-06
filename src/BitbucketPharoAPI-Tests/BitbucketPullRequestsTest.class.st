"
A BitbucketPullRequestsTest is a test class for testing the behavior of BitbucketPullRequests
"
Class {
	#name : 'BitbucketPullRequestsTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketPullRequestsTest >> testActivitiesOfInRepositoryOfProject [

	| hostUrl gitlabApi result client path bitbucketPullRequests pullRequestID projectKey repoSlug  pullRequestActivity |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.

	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         gitlabApi.

	pullRequestID := 24.
	projectKey := 'AAA'.
	repoSlug := 'project'.

	pullRequestActivity := { (#pullRequestActivity -> pullRequestID) } asDictionary.

	path := '/projects/' , projectKey , '/repos/' , repoSlug
	        , '/pull-requests/' , pullRequestID asString , '/activities'.
	
	(bitbucketPullRequests stub getAll: path withParams: Dictionary new)
		willReturn: pullRequestActivity.

	"When"
	result := bitbucketPullRequests
		          activitiesOf: pullRequestID 
		          inRepository: repoSlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: pullRequestActivity
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testCommitsOfInRepositoryOfProject [

	| hostUrl gitlabApi result client path bitbucketPullRequests pullRequestID projectKey repoSlug commit |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.

	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         gitlabApi.

	pullRequestID := 24.
	projectKey := 'AAA'.
	repoSlug := 'project'.

	commit := { (#commitId -> 'id') }
		                       asDictionary.

	path := '/projects/' , projectKey , '/repos/' , repoSlug
	        , '/pull-requests/' , pullRequestID asString , '/commits'.

	(bitbucketPullRequests stub getAll: path withParams: Dictionary new)
		willReturn: commit.

	"When"
	result := bitbucketPullRequests
		          commitsOf: pullRequestID
		          inRepository: repoSlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: commit
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testCreateFromRefToRefInRepositoryOfProject [

	| hostUrl result client endpoint response bitbucketApi bitbucketPullRequests projectKey repositorySlug fromRef toRef title data |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.
	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	
	fromRef := 'test'.
	toRef := 'dev'.
	title := 'a title'.
	
	data := {
		        (#title -> title).
		        (#fromRef -> { (#id -> fromRef) } asDictionary).
		        (#toRef -> { (#id -> toRef) } asDictionary) } asDictionary.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests'.

	response := { (#message -> 'message') } asDictionary.

	(bitbucketPullRequests stub
		 postJson: endpoint
		 withData: data) willReturn: response.

	"When"
	result := bitbucketPullRequests
		          create: title fromRef: fromRef  toRef: toRef inRepository: repositorySlug ofProject: projectKey. 
	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testDiffOfInRepositoryOfProject [

	| hostUrl gitlabApi result client path bitbucketPullRequests pullRequestID projectKey repoSlug pullRequestDiff |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.
		
	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         gitlabApi.

	pullRequestID := 24.
	projectKey := 'AAA'.
	repoSlug := 'project'.

	pullRequestDiff := { (#diff -> pullRequestID) } asDictionary.

	path := '/projects/' , projectKey , '/repos/' , repoSlug
	        , '/pull-requests/' , pullRequestID asString, '/diff'.
	(bitbucketPullRequests stub get: path withParams: Dictionary new)
		willReturn: pullRequestDiff.

	"When"
	result := bitbucketPullRequests
		          diffOf: pullRequestID
		          inRepository: repoSlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: pullRequestDiff
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testGetInRepositoryOfProject [

	| hostUrl gitlabApi result client path bitbucketPullRequests pullRequestID projectKey repoSlug pullRequest |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi: gitlabApi.

	pullRequestID := 24.
	projectKey := 'AAA'.
	repoSlug := 'project'.

	pullRequest := { (#id -> pullRequestID) } asDictionary.

	path := '/projects/' , projectKey , '/repos/', repoSlug, '/pull-requests/', pullRequestID asString.
	(bitbucketPullRequests stub get: path withParams: Dictionary new)
		willReturn: pullRequest.

	"When"
	result := bitbucketPullRequests
		          get: pullRequestID
		          inRepository: repoSlug ofProject: projectKey.

	"Then"
	self assert: result equals: pullRequest
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testPostCommentInPullRequestInRepositoryOfProject [

	| hostUrl result client endpoint response bitbucketApi bitbucketPullRequests projectKey repositorySlug pullRequestId comment |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi: bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	pullRequestId := 4.
	
	comment := BitbucketPullRequestComment createWithText: 'test'.
	
	endpoint := '/projects/' , projectKey , '/repos/', repositorySlug, '/pull-requests/', pullRequestId asString, '/comments'.

	response := { (#message -> 'message') } asDictionary.

	(bitbucketPullRequests stub postJson: endpoint withData: comment asDictionary) willReturn:
		response.

	"When"
	result := bitbucketPullRequests postComment: comment inPullRequest: pullRequestId inRepository: repositorySlug  ofProject: projectKey. 

	"Then"
	self assert: result equals: response
]
