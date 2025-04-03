Class {
	#name : 'BitbucketPullRequests',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - post' }
BitbucketPullRequests >> activitiesInPullRequest: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"/rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}/comments"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests/' , pullRequestId asString , '/activities'.

	^ self getAll: endpoint withParams: Dictionary new
]

{ #category : 'api - get' }
BitbucketPullRequests >> activitiesOf: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}/activities"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests/' , pullRequestId asString , '/activities'.

	^ self getAll: endpoint withParams: Dictionary new.
]

{ #category : 'api - get' }
BitbucketPullRequests >> allSince: since until: until withParams: paramsDictionary inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests?direction&at&state&order&withAttributes&withProperties"

	"There is no parameter in the API that allows us to directly get all the commits between two dates, so we have to do it manually."
	| results lastDate endpoint pullRequests createdDateTimestamp |
	bitbucketApi prepareClient.
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/pull-requests'.
	bitbucketApi client path: bitbucketApi basePath , endpoint.

	paramsDictionary keysAndValuesDo: [ :key :value |
		bitbucketApi client queryAt: key put: value ].

	pullRequests := OrderedCollection new.

	[
	results := bitbucketApi client get.
	results := (NeoJSONReader on: results readStream) next.
	pullRequests addAll: (results at: #values).
	results at: #nextPageStart ifPresent: [
		bitbucketApi client
			queryAt: #start
			put: (results at: #nextPageStart) ].

	(results at: #isLastPage)
		ifTrue: [ false ]
		ifFalse: [
			createdDateTimestamp := pullRequests last at: #createdDate.
			lastDate := DateAndTime fromUnixTime: createdDateTimestamp / 1000.
			since asDate <= lastDate ] ] whileTrue.

	^ pullRequests select: [ :pullRequest |
		  | createdDate |
		  createdDate := DateAndTime fromUnixTime:
			                 (pullRequest at: #createdDate) / 1000.
		  createdDate >= since asDate asDateAndTime and:
			  createdDate <= until asDate asDateAndTime ]
]

{ #category : 'api - get' }
BitbucketPullRequests >> allWithParams: paramsDictionary inRepository: repositorySlug  ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests?direction&at&state&order&withAttributes&withProperties"

	| endpoint |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/pull-requests'.
	
	^self getAll: endpoint withParams: paramsDictionary. 
]

{ #category : 'api - get' }
BitbucketPullRequests >> commitsOf: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}/commits"

	| endpoint |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/pull-requests/', pullRequestId asString, '/commits'.
	
	^self getAll: endpoint withParams: Dictionary new. 
]

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
