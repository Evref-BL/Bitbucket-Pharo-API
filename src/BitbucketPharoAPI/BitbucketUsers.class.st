Class {
	#name : 'BitbucketUsers',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - get' }
BitbucketUsers >> allWithParams: paramsDict [
	"GET /rest/api/1.0/users"

	| endpoint |
	endpoint := '/users'.

	^ self getAll: endpoint withParams: paramsDict
]
