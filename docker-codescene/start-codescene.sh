#!/bin/bash
set -x

mkdir -p $CODESCENE_ANALYSIS_RESULTS_ROOT
mkdir -p $CODESCENE_CLONED_REPOSITORIES_ROOT
# don't quote "$JAVA_OPTIONS" because you wouldn't be able to use it for multiple properties/settings in docker-compose.yml
java -XshowSettings:vm $JAVA_OPTIONS -XX:MaxRAMPercentage=75 -Duser.timezone="$CODESCENE_TIMEZONE" -jar "/opt/codescene/codescene-enterprise-edition.standalone.jar" | tee -a ${CODESCENE_DIR}/codescene.log
