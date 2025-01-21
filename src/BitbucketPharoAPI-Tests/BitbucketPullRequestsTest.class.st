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
