Class {
	#name : 'BitbucketRepositories',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

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
