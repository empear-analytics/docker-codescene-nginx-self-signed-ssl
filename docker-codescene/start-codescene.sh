#!/bin/bash
java -XshowSettings:vm $JAVA_OPTIONS -jar "/opt/codescene/codescene-enterprise-edition.standalone.jar" | tee -a /var/log/codescene.log
