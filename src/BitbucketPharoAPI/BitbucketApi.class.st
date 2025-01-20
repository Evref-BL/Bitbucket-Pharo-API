Class {
	#name : 'BitbucketApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'bearerToken',
		'host',
		'basePath'
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

{ #category : 'accessing' }
BitbucketApi >> client [

	^ client
]

{ #category : 'accessing' }
BitbucketApi >> client: anObject [

	client := anObject
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

	basePath := 'rest/api/1.0'
]

{ #category : 'private' }
BitbucketApi >> prepareClient [
	client host: host.
	client http.
	
   bearerToken ifNotNil: [ :token |
		client headerAt: #Authorization put: 'Bearer ' , token ].
]
