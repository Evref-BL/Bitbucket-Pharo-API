# Bitbucket-Pharo-API

[![Continuous](https://github.com/Evref-BL/Bitbucket-Pharo-API/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/Bitbucket-Pharo-API/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/Bitbucket-Pharo-API/badge.svg?branch=ci-add-coverage)](https://coveralls.io/github/Evref-BL/Bitbucket-Pharo-API?branch=develop)

This is a Pharo client for the [Bitbucket Server REST API](https://docs.atlassian.com/bitbucket-server/rest/5.9.0/bitbucket-rest.html)

## Installation 

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Bitbucket-Pharo-API' commitish: 'develop' path: 'src';
  baseline: 'BitbucketPharoAPI';
  onConflict: [ :ex | ex useIncoming ];
  load
```