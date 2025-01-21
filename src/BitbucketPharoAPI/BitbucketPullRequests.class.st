Class {
	#name : 'BitbucketPullRequests',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - get' }
BitbucketPullRequests >> get: pullRequestId inRepository: repositorySlug ofProject: projectKey [
	"/rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/pull-requests/{pullRequestId}"
	
	| endpoint |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/pull-requests/', pullRequestId asString.
	
	^self get: endpoint withParams: Dictionary new. 
]
