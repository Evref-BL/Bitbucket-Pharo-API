# Bitbucket-Pharo-API

This is a Pharo client for the [Bitbucket Server REST API](https://docs.atlassian.com/bitbucket-server/rest/5.9.0/bitbucket-rest.html)

## Installation 

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Bitbucket-Pharo-API' commitish: 'develop' path: 'src';
  baseline: 'Bitbucket-Pharo-API';
  onConflict: [ :ex | ex useIncoming ];
  load
```