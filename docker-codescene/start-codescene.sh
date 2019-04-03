#!/bin/bash
java -XshowSettings:vm $JAVA_OPTIONS -XX:MaxRAMPercentage=60 -jar "/opt/codescene/codescene-enterprise-edition.standalone.jar" | tee -a /codescene/codescene.log
