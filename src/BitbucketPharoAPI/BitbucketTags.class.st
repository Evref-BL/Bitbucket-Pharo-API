"
Api for [https://docs.atlassian.com/bitbucket-server/rest/5.9.0/bitbucket-rest.html#idm29495621024](https://docs.atlassian.com/bitbucket-server/rest/5.9.0/bitbucket-rest.html#idm29495621024)
"
Class {
	#name : 'BitbucketTags',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - get' }
BitbucketTags >> allWithParams: paramsDict inRepository: repositorySlug ofProject: projectKey [
	"GET /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/tags?filterText&orderBy"

	| endpoint |
	endpoint := '/projects/' , projectKey , '/repos/' , repositorySlug
	            , '/tags'.

	^ self getAll: endpoint withParams: paramsDict
]
