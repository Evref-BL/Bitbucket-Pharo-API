Class {
	#name : 'BitbucketPullRequestComment',
	#superclass : 'Object',
	#instVars : [
		'text',
		'parentId',
		'diffType',
		'line',
		'lineType',
		'fileType',
		'fromHash',
		'path',
		'srcPath',
		'toHash'
	],
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'instance creation' }
BitbucketPullRequestComment class >> createFileCommentWithText: text filePath: path fromHash: fromHash toHash: toHash [

	^ self new
		  diffType: 'RANGE';
		  text: text;
		  path: path;
		  srcPath: path;
		  fromHash: fromHash;
		  toHash: toHash
]

{ #category : 'instance creation' }
BitbucketPullRequestComment class >> createReplyWithText: text andParentId: parentId [
	^ self new text: text; parentId: parentId.
]

{ #category : 'instance creation' }
BitbucketPullRequestComment class >> createWithText: text [

	^ self new text: text
]

{ #category : 'converting' }
BitbucketPullRequestComment >> asDictionary [
	| dict parent anchor |
	dict := Dictionary new.
	parent := Dictionary new.
	anchor := Dictionary new.
	
	dict at: #text put: text.
	
	parentId ifNotNil: [ 
		parent at: #id  put: parentId. 
		dict at: #parent put: parent.
	].
	
	diffType ifNotNil: [ 
		anchor at: #diffType put: diffType.
		anchor at: #fromHash put: fromHash.
		anchor at: #path put: path.
		anchor at: #scrPath put: srcPath.
		anchor at: #toHash put: toHash.
		
		line ifNotNil: [ 
			anchor at: #line put: line.
			anchor at: #lineType put: lineType.
			anchor at: #fileType put: fileType.	
		].
		
		dict at: #anchor put: anchor.	
	].


	^dict.
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> diffType: anObject [

	diffType := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> fileType: anObject [

	fileType := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> fromHash: anObject [

	fromHash := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> line: anObject [

	line := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> lineType: anObject [

	lineType := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> parentId: anObject [

	parentId := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> path: anObject [

	path := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> srcPath: anObject [

	srcPath := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> text: anObject [

	text := anObject
]

{ #category : 'accessing' }
BitbucketPullRequestComment >> toHash: anObject [

	toHash := anObject
]
