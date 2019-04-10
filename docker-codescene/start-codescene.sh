#!/bin/bash
mkdir -p $CODESCENE_ANALYSIS_RESULTS_ROOT
mkdir -p $CODESCENE_CLONED_REPOSITORIES_ROOT
java -XshowSettings:vm $JAVA_OPTIONS -XX:MaxRAMPercentage=60 -jar "/opt/codescene/codescene-enterprise-edition.standalone.jar" | tee -a ${CODESCENE_DIR}/codescene.log
