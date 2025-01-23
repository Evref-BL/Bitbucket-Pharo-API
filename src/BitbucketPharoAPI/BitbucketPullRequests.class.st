Class {
	#name : 'BitbucketPullRequests',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - post' }
BitbucketPullRequests >> create: title fromRef: fromRefId toRef: toRefId inRepository: repositorySlug ofProject: projectKey [
	"POST /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests"

	| endpoint data |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/pull-requests'.
	
	data := { 
		#title -> title.
		#fromRef -> { #id -> fromRefId } asDictionary.
		#toRef -> { #id -> toRefId } asDictionary. 		
	} asDictionary.
	
	^ self postJson: endpoint withData: data. 
]

{ #category : 'api - get' }
BitbucketPullRequests >> diffOf: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"/rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}/diff"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests/' , pullRequestId asString, '/diff'.

	^ self get: endpoint withParams: Dictionary new
]

{ #category : 'api - get' }
BitbucketPullRequests >> get: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"/rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}"
	
	| endpoint |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/pull-requests/', pullRequestId asString.
	
	^self get: endpoint withParams: Dictionary new. 
]

{ #category : 'api - post' }
BitbucketPullRequests >> postComment: bitbucketPullRequestComment inPullRequest: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"/rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}/comments"

	| endpoint data |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests/' , pullRequestId asString , '/comments'.

	data := bitbucketPullRequestComment asDictionary.

	^ self postJson: endpoint withData: data
]
