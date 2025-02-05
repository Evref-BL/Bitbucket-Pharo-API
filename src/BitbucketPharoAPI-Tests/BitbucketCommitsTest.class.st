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
BitbucketCommitsTest >> testAllInBranchInRepositoryOfProject [

	| hostUrl client bitbucketApi projectKey repositorySlug endpoint response result params bitbucketCommits branch |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketCommits := BitbucketCommits new bitbucketApi: bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	branch := 'dev'.

	params := { (#until -> branch) } asDictionary.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits'.

	response := { (#commitId -> '1') } asDictionary.

	(bitbucketCommits stub getAll: endpoint withParams: params)
		willReturn: response.

	"When"
	result := bitbucketCommits
		          allInBranch: branch 
		          inRepository: repositorySlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
BitbucketCommitsTest >> testAllSinceUntilInRepositoryOfProject [

	| hostUrl client endpoint bitbucketApi result response bitbucketCommits projectKey repositorySlug since until commit1 commit2 sinceAsTimestamp untilPlusOneDayAsTimestamp |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketCommits := BitbucketCommits new bitbucketApi: bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	since := '02-05-2025'.
	until := '02-06-2025'.
	
	sinceAsTimestamp := (since asDate asDateAndTime) asUnixTime * 1000. 
	untilPlusOneDayAsTimestamp := (until asDate asDateAndTime + 1day) asUnixTime * 1000.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits'.

	commit1 := { #authorTimestamp
	            -> sinceAsTimestamp }
		           asDictionary.
	commit2 := { #authorTimestamp
	            -> untilPlusOneDayAsTimestamp }
		           asDictionary.


	response := {
		            (#values -> {
			             commit1.
			             commit2 }).
		            (#isLastPage -> true) } asDictionary.
		
	client stub get willReturn: (NeoJSONWriter toString: response).


	"When"
	result := bitbucketCommits
		          allSince: since
		          until: until
		          inRepository: repositorySlug
		          ofProject: projectKey.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: commit1
]

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

{ #category : 'tests' }
BitbucketCommitsTest >> testDiffOfInRepositoryOfProject [

	| hostUrl client bitbucketApi projectKey repositorySlug endpoint response result bitbucketCommits commitId |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketApi new
		                bearerToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketCommits := BitbucketCommits new bitbucketApi: bitbucketApi.

	projectKey := 'OOO'.
	repositorySlug := 'my project'.
	commitId := 'aaezf1'.

	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits/' , commitId , '/diff'.

	response := { (#diff -> '1') } asDictionary.

	(bitbucketCommits stub get: endpoint withParams: Dictionary new)
		willReturn: response.

	"When"
	result := bitbucketCommits diffOf: commitId inRepository: repositorySlug ofProject: projectKey.
	
	"Then"
	self assert: result equals: response
]
