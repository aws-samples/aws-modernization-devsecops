#!/usr/bin/env bash
set -e

cd ..

####################
## Security Tests ##
####################
echo "##### TruffleHog Test #####"
trufflehog --regex --max_depth 1 .

echo "##### hadolint Dockerfile #####"
docker run --rm -i hadolint/hadolint < Dockerfile



