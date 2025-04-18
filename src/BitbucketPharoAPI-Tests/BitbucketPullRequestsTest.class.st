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
BitbucketPullRequestsTest >> testAllSinceUntilWithParamsInRepositoryOfProject [

	| hostUrl client endpoint bitbucketApi result response projectKey repositorySlug since until sinceAsTimestamp untilPlusOneDayAsTimestamp bitbucketPullRequests pullRequest1 pullRequest2 params |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	since := '02-05-2025'.
	until := '02-06-2025'.
	params := { (#state -> 'all') } asDictionary.

	sinceAsTimestamp := since asDate asDateAndTime asUnixTime * 1000.
	untilPlusOneDayAsTimestamp := (until asDate asDateAndTime + 1 day)
		                              asUnixTime * 1000.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests'.

	pullRequest1 := {
		                (#createdDate -> sinceAsTimestamp).
		                (#updatedDate -> sinceAsTimestamp) } asDictionary.
	pullRequest2 := {
		                (#createdDate -> untilPlusOneDayAsTimestamp).
		                (#updatedDate -> untilPlusOneDayAsTimestamp) } asDictionary.


	response := {
		            (#values -> {
			             pullRequest1.
			             pullRequest2 }).
		            (#isLastPage -> true) } asDictionary.

	client stub get willReturn: (NeoJSONWriter toString: response).


	"When"
	result := bitbucketPullRequests
		          allSince: since
		          until: until
		          withParams: params
		          inRepository: repositorySlug
		          ofProject: projectKey.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: pullRequest1.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testAllSinceUntilWithParamsInRepositoryOfProjectInCreatedButUpdatedSince [

	| hostUrl client endpoint bitbucketApi result response projectKey repositorySlug since until updatedDateAsTimestamp bitbucketPullRequests pullRequest1 params createdDateAsTimestamp |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	since := '02-02-2025'.
	until := '02-09-2025'.
	params := { (#state -> 'all') } asDictionary.

	createdDateAsTimestamp := '02-08-2025' asDate asDateAndTime asUnixTime * 1000.
	updatedDateAsTimestamp := ('02-17-2025' asDate asDateAndTime + 1 day)
		                              asUnixTime * 1000.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests'.

	pullRequest1 := {
		                (#createdDate -> createdDateAsTimestamp).
		                (#updatedDate -> updatedDateAsTimestamp) } asDictionary.

	response := {
		            (#values -> {
			             pullRequest1.
 }).
		            (#isLastPage -> true) } asDictionary.

	client stub get willReturn: (NeoJSONWriter toString: response).


	"When"
	result := bitbucketPullRequests
		          allSince: since
		          until: until
		          withParams: params
		          inRepository: repositorySlug
		          ofProject: projectKey.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: pullRequest1.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
BitbucketPullRequestsTest >> testAllWithParamsInRepositoryOfProject [

	| hostUrl gitlabApi result client path bitbucketPullRequests projectKey repoSlug params pullRequest |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.

	bitbucketPullRequests := BitbucketPullRequests new bitbucketApi:
		                         gitlabApi.

	projectKey := 'AAA'.
	repoSlug := 'project'.
	params := { #state -> 'all' } asDictionary.

	pullRequest := { (#pr -> 'id') } asDictionary.

	path := '/projects/' , projectKey , '/repos/' , repoSlug
	        , '/pull-requests'.

	(bitbucketPullRequests stub getAll: path withParams: params)
		willReturn: pullRequest.

	"When"
	result := bitbucketPullRequests
		          allWithParams: params
		          inRepository: repoSlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: pullRequest
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
