Class {
	#name : 'BitbucketProjects',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'accessing' }
BitbucketProjects >> all [
	"GET /rest/api/1.0/projects?name&permission"
	| endpoint |
	endpoint := '/projects'.

	^ self getAll: endpoint withParams: Dictionary new
]

{ #category : 'accessing' }
BitbucketProjects >> get: projectKey [
	"/rest/api/1.0/projects/{projectKey}"

	| endpoint |
	endpoint := '/projects/' , projectKey.

	^ self get: endpoint withParams: Dictionary new
]
