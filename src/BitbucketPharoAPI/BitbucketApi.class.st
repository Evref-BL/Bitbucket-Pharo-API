Class {
	#name : 'BitbucketApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'bearerToken',
		'endpoint',
		'basePath'
	],
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'accessing' }
BitbucketApi >> bearerToken: token [
	client headerAt: #Authorization put: 'Bearer ' , token.
	bearerToken := token.
	
]

{ #category : 'initialization' }
BitbucketApi >> initialize [

	client := ZnClient new
		          accept: ZnMimeType applicationJson;
		          yourself
]
