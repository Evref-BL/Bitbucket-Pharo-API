Class {
	#name : 'BitbucketBranches',
	#superclass : 'BitbucketRessource',
	#category : 'BitbucketPharoAPI',
	#package : 'BitbucketPharoAPI'
}

{ #category : 'api - post' }
BitbucketBranches >> create: branchName withStartPoint: startPoint inRepository: repositorySlug ofProject: projectKey [
	"POST /rest/api/1.0/projects/{projectKey}/repos/{repositorySlug}/branches"

	| endpoint data |
	endpoint := '/projects/', projectKey, '/repos/', repositorySlug, '/branches'.
	
	data := { 
		#name -> branchName.
		#startPoint -> startPoint
	 } asDictionary.
	
	^self postJson: endpoint withData: data.
]
