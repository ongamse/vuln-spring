#!/usr/bin/env bash

GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
mvn compile package -Dmaven.test.skip=true
sl analyze --wait --app vuln-spring-ai --tag branch=$GIT_BRANCH --vcs-prefix-correction "*=src/main/java" --java --cpg target/vuln-spring-0.0.1-SNAPSHOT.jar
# Compare the current scan against master branch
#sl check-analysis --v2 --app vuln-spring-ai --source tag.branch=master --target tag.branch=$GIT_BRANCH --report
# Display summary from last scan
sl check-analysis --v2 --app vuln-spring-ai --report
# Compare the current branch against the last scan from the same branch
# sl check-analysis --v2 --app vuln-spring-ai --branch=$GIT_BRANCH --report
