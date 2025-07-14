"
A BitbucketTagsTest is a test class for testing the behavior of BitbucketTags
"
Class {
	#name : 'BitbucketTagsTest',
	#superclass : 'TestCase',
	#category : 'BitbucketPharoAPI-Tests',
	#package : 'BitbucketPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketTagsTest >> testAllWithParamsInRepositoryOfProject [

	| hostUrl gitlabApi result client path bitbucketTags projectKey repoSlug params tags |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketApi new
		             bearerToken: 'token';
		             host: hostUrl;
		             client: client.

	bitbucketTags := BitbucketTags new bitbucketApi: gitlabApi.

	projectKey := 'AAA'.
	repoSlug := 'project'.
	params := { (#state -> 'all') } asDictionary.

	tags := {
		        (#latestCommit -> #f940d1d59d4314f0c8b17d878de9b21028c68de1).
		        (#displayId -> #'7.4/7.4.0/milestone/M11') } asDictionary.

	path := '/projects/' , projectKey , '/repos/' , repoSlug , '/tags'.

	(bitbucketTags stub getAll: path withParams: params) willReturn: tags.

	"When"
	result := bitbucketTags
		          allWithParams: params
		          inRepository: repoSlug
		          ofProject: projectKey.

	"Then"
	self assert: result equals: tags
]
