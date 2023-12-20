[![Verify](https://github.com/galadrimteam/trancrypt-env-file-to-eb/actions/workflows/verify.yml/badge.svg)](https://github.com/galadrimteam/trancrypt-env-file-to-eb/actions/workflows/verify.yml)

# Add transcrypt encoded file to ElasticBeanstalk

Decrypt the file and add it to the ebconfig file. The default path for the config elasticbeanstalk is `.ebextensions/options.config`. If the file is in the folder backend, pass `backend/.ebextensions/options.config` with the eb_config_path argument.

## Requirements

- You must have your transcrypt key
- To obtain it run `transcrypt --display`, it's the PASSWORD

## Setup

Example workflow setup:

```yaml
name: Add env to ElasticBeanstalk

on:
  pull_request:
    branches:
      - staging
jobs:
  add-env:
    runs-on: ubuntu-latest
    steps:
      - uses: galadrimteam/transcrypt-env-file-to-eb@1
        with:
          env_file: backend/.staging.env
          transcrypt_key: s07Fjs/lwSJs+tpOZf2s9z0e0Ak6wpen/F3TqXPu
          eb_config_path: backend/.ebextensions/options.config
```
