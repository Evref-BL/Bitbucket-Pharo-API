Class {
	#name : 'BitbucketApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'bearerToken',
		'host',
		'basePath',
		'output'
	],
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'accessing' }
BitbucketApi >> basePath [

	^ basePath
]

{ #category : 'accessing' }
BitbucketApi >> basePath: anObject [

	basePath := anObject
]

{ #category : 'accessing' }
BitbucketApi >> bearerToken: token [
	client headerAt: #Authorization put: 'Bearer ' , token.
	bearerToken := token.
	
]

{ #category : 'ressources' }
BitbucketApi >> branches [
	^BitbucketBranches new bitbucketApi: self.
]

{ #category : 'accessing' }
BitbucketApi >> client [

	^ client
]

{ #category : 'accessing' }
BitbucketApi >> client: anObject [

	client := anObject
]

{ #category : 'ressources' }
BitbucketApi >> commits [
	^BitbucketCommits new bitbucketApi: self.
]

{ #category : 'accessing' }
BitbucketApi >> host [

	^ host
]

{ #category : 'accessing' }
BitbucketApi >> host: anObject [

	host := anObject
]

{ #category : 'initialization' }
BitbucketApi >> initialize [

	client := ZnClient new
		          accept: ZnMimeType applicationJson;
		          yourself.

	basePath := 'rest/api/1.0'.
	
	output := 'dict'
]

{ #category : 'accessing' }
BitbucketApi >> output [

	^ output
]

{ #category : 'accessing' }
BitbucketApi >> output: anObject [

	output := anObject
]

{ #category : 'private' }
BitbucketApi >> prepareClient [
	client host: host.
	client http.
	
   bearerToken ifNotNil: [ :token |
		client headerAt: #Authorization put: 'Bearer ' , token ].
]

{ #category : 'ressources' }
BitbucketApi >> projects [
	^BitbucketProjects new bitbucketApi: self.
]

{ #category : 'ressources' }
BitbucketApi >> pullRequests [
	^ BitbucketPullRequests new bitbucketApi: self.
]

{ #category : 'ressources' }
BitbucketApi >> repositories [
	^ BitbucketRepositories new bitbucketApi: self.
]

{ #category : 'ressources' }
BitbucketApi >> users [
	^BitbucketUsers new bitbucketApi: self.
]
