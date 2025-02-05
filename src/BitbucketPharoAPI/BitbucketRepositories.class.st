Class {
	#name : 'BitbucketRepositories',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - get' }
BitbucketRepositories >> allInProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos"
	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos'.

	^ self getAll: endpoint withParams: Dictionary new
]

{ #category : 'api - get' }
BitbucketRepositories >> rawFile: filePath withParams: paramsDict inRepository: repositorySlug ofProject: projectKey [
	"/rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/raw/{path:.*}?at&markup&hardwrap&htmlEscape"

	| endpoint currentOutput result |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/raw/' , filePath.

	currentOutput := bitbucketApi output.

	bitbucketApi output: 'default'.
	result := self get: endpoint withParams: paramsDict.
	bitbucketApi output: currentOutput.

	^ result
]

{ #category : 'api - put' }
BitbucketRepositories >> updateFile: filePath withParams: bitbucketUpdateFileParams inRepository: repositorySlug ofProject: projectKey [
	"PUT /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/browse/{path:.*}?at&type&blame&noContent"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/browse/' , filePath.


	^ self put: endpoint withData: bitbucketUpdateFileParams asDictionary
]
