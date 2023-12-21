[![Verify](https://github.com/galadrimteam/env-to-eb-with-transcrypt/actions/workflows/verify.yml/badge.svg)](https://github.com/galadrimteam/env-to-eb-with-transcrypt/actions/workflows/verify.yml)

# Add transcrypt encoded file to ElasticBeanstalk

Decrypt the file and add it to the ebconfig file. The default path for the config elasticbeanstalk is `.ebextensions/options.config`. If the file is in the folder backend, pass `backend/.ebextensions/options.config` with the eb_config_path argument.

## Requirements

- You must have your transcrypt key
- To obtain it run `transcrypt --display`, it's the PASSWORD

## Setup

Example workflow setup:

```yaml
steps:
  ...
  - uses: galadrimteam/env-to-eb-with-transcrypt@1
    with:
      env_file: backend/.env.staging
      transcrypt_key: ${{ secrets.TRANSCRYPT_KEY }}
      eb_config_path: backend/.ebextensions/options.config
```
