Class {
	#name : 'BitbucketCommits',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - get' }
BitbucketCommits >> allInBranch: branchRef inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/commits"

	| endpoint params |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits'.
	
	params := { 
		#until -> branchRef
	} asDictionary.
	
	^ self getAll: endpoint withParams: params
]

{ #category : 'api - get' }
BitbucketCommits >> allSince: since until: until inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/commits"
	"There is no parameter in the API that allows us to directly get all the commits between two dates, so we have to do it manually."

	| results lastDate lastCommitterTimestamp commits endpoint |
	bitbucketApi prepareClient.
	endpoint := '/projects/' , projectKey , '/repos/'
		, repositorySlug , '/commits'.
	bitbucketApi client path: bitbucketApi basePath , endpoint.
	
	commits := OrderedCollection new.

	[
	results := bitbucketApi client get.
	results := (NeoJSONReader on: results readStream) next.
	commits addAll: (results at: #values).
	results
		at: #nextPageStart
		ifPresent: [
		bitbucketApi client queryAt: #start put: (results at: #nextPageStart) ].

	(results at: #isLastPage)
		ifTrue: [ false ]
		ifFalse: [
			lastCommitterTimestamp := commits last at: #authorTimestamp.
			lastDate := DateAndTime fromUnixTime: lastCommitterTimestamp / 1000.
			since asDate <= lastDate ] ] whileTrue.

	^ commits select: [ :commit |
		  | commitDate |
		  commitDate := DateAndTime fromUnixTime:
			                (commit at: #authorTimestamp) / 1000.
		  commitDate >= since asDate asDateAndTime and:
			  commitDate <= until asDate asDateAndTime ]
]

{ #category : 'api - get' }
BitbucketCommits >> allWithParams: paramsDictionary inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/commits"
	| endpoint |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/commits'.
	^self getAll: endpoint withParams: paramsDictionary.
]

{ #category : 'api - get' }
BitbucketCommits >> diffOf: commitId inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/commits/{commitId}/diff?autoSrcPath&contextLines&since&srcPath&whitespace&withComments"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits/' , commitId , '/diff'.

	^ self get: endpoint withParams: Dictionary new
]

{ #category : 'api - get' }
BitbucketCommits >> get: commitId inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/commits/{commitId}/diff?autoSrcPath&contextLines&since&srcPath&whitespace&withComments"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/commits/' , commitId.

	^ self get: endpoint withParams: Dictionary new
]
