Class {
	#name : 'BitbucketCommits',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - get' }
BitbucketCommits >> allWithParams: paramsDictionary inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/commits"
	| endpoint |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/commits'.
	^self getAll: endpoint withParams: paramsDictionary.
]
