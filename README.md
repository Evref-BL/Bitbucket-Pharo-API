# Bitbucket-Pharo-API

[![Continuous](https://github.com/Evref-BL/Bitbucket-Pharo-API/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/Bitbucket-Pharo-API/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/Bitbucket-Pharo-API/badge.svg?branch=develop)](https://coveralls.io/github/Evref-BL/Bitbucket-Pharo-API?branch=develop)

This is a Pharo client for the [Bitbucket Server REST API](https://docs.atlassian.com/bitbucket-server/rest/5.9.0/bitbucket-rest.html)

## Usage

### Installation

#### From playground

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Bitbucket-Pharo-API' commitish: 'main' path: 'src';
  baseline: 'BitbucketPharoAPI';
  onConflict: [ :ex | ex useIncoming ];
  load
```

#### Baseline dependency

```st
  spec
    baseline: 'BitbucketPharoAPI' with: [
      spec repository: 'github://Evref-BL/Bitbucket-Pharo-API:main'
    ]
```

### Client

To start using the API, you need to create a client instance with your Bitbucket host and a Bearer token for authentication. Here’s an example:

```st
bitbucketApi := BitbucketApi new
    host: 'bitbucket.org';
    bearerToken: '<your token>'.
```

Replace `<your token>` with your actual Bitbucket token.

### Ressources

The API provides different resource classes to interact with different entities in Bitbucket. These resources include:

- branches
- commits
- projects
- pullRequests
- repositories
- users

Each resource provides methods for interacting with the corresponding Bitbucket resource. You can access them like this:

```st
bitbucketApi projects <method>
```

### Example

Here are a few examples of how to interact with the API:

#### Fetch All Projects

This example retrieves all projects from Bitbucket:

```st
| projects |
projects := bitbucketApi projects all
```

#### Fetch All Commits for a Specific Branch

This example demonstrates how to fetch all commits for the dev branch within a specific repository and project, using parameters:

```st
| commits params |
params := {
  #until -> 'dev'
} asDictionary.
commits := bitbucketApi commits allWithParams: params inRepository: '<repositorySlug>' ofProject: '<projectKey>'.
```

Replace `<repositorySlug>` with the slug of the repository and `<projectKey>` with the project key.
