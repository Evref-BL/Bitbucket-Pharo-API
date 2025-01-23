Class {
	#name : 'BitbucketUpdateFileParams',
	#superclass : 'Object',
	#instVars : [
		'newContent',
		'commitMessage',
		'sourceCommitId',
		'branch'
	],
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'converting' }
BitbucketUpdateFileParams >> asDictionary [

	| dict |
	dict := Dictionary new.

	branch ifNotNil: [ dict at: #branch put: branch ].
	newContent ifNotNil: [ dict at: #content put: newContent ].
	commitMessage ifNotNil: [ dict at: #message put: commitMessage ].
	sourceCommitId ifNotNil: [ dict at: #sourceCommitId put: sourceCommitId ].

	^ dict
]

{ #category : 'accessing' }
BitbucketUpdateFileParams >> branch: anObject [

	branch := anObject
]

{ #category : 'accessing' }
BitbucketUpdateFileParams >> commitMessage: anObject [

	commitMessage := anObject
]

{ #category : 'accessing' }
BitbucketUpdateFileParams >> newContent: anObject [

	newContent := anObject
]

{ #category : 'accessing' }
BitbucketUpdateFileParams >> sourceCommitId: anObject [

	sourceCommitId := anObject
]
