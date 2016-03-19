#!/bin/zsh
# generate eclipse project

#check if we got service name from the user
if [[ -z "$1" ]]; then
  #statements
  echo "usage: ./magic.sh <service name>"
  exit 0
fi

# assign a variable to the user input
SERVICE_NAME="$1"
echo $SERVICE_NAME

first_char=${SERVICE_NAME:0:1}

LOWER_CASE_SERVICE_NAME=$(echo "$SERVICE_NAME" | awk '{print tolower($0)}')
echo $LOWER_CASE_SERVICE_NAME

if [[ ${first_char} == [a-z] ]]; then
  #statements
  echo "Service Name specified should start with uppercase"
  exit 0
fi

# generate the parent pom
mvn archetype:generate -B -DarchetypeGroupId=org.codehaus.mojo.archetypes -DarchetypeArtifactId=pom-root -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace -DartifactId="$SERVICE_NAME-parent" -Dversion=1.0.0-SNAPSHOT

cd $SERVICE_NAME-parent

#create the child projects
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-rest-if" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-rest" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-common" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-business" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-dal" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-db" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-conf" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-beanconverter" -Dversion=1.0.0-SNAPSHOT
mvn archetype:generate -B -DarchetypeGroupId=org.apache.maven.archetypes -DarchetypeArtifactId=maven-archetype-webapp -DarchetypeVersion=RELEASE -DgroupId=com.verizon.iot.thingspace."$LOWER_CASE_SERVICE_NAME"service -DartifactId="$SERVICE_NAME-service" -Dversion=1.0.0-SNAPSHOT

#remove java files
find . -name App.java -type f -delete
find . -name AppTest.java -type f -delete

#start manipulating pom files
# operate on service project
cd $SERVICE_NAME-service
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-rest-if<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-rest<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-business<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-dal<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-db<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-conf<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-beanconverter<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

cd ../$SERVICE_NAME-rest-if
#operate on rest-if
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

cd ../$SERVICE_NAME-rest
# operate on rest
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-rest-if<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-business<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-beanconverter<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>org.jboss.spec.javax.ejb<\/groupId><artifactId>jboss-ejb-api_3.1_spec<\/artifactId><version>1.0.2.Final<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>org.glassfish.jersey.containers<\/groupId><artifactId>jersey-container-servlet-core<\/artifactId><version>2.22.1<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>org.glassfish.jersey.media<\/groupId><artifactId>jersey-media-moxy<\/artifactId><version>2.17<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>io.swagger<\/groupId><artifactId>swagger-jersey2-jaxrs<\/artifactId><version>1.5.0<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>org.glassfish.jersey.core<\/groupId><artifactId>jersey-server<\/artifactId><version>2.22.2<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

cd ../$SERVICE_NAME-business
#operate on business
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-dal<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-beanconverter<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>javax.inject<\/groupId><artifactId>javax.inject<\/artifactId><version>1<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>javax.ejb<\/groupId><artifactId>ejb-api<\/artifactId><version>3.0<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

cd ../$SERVICE_NAME-dal
#operate on dal
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-db<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-conf<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>javax.inject<\/groupId><artifactId>javax.inject<\/artifactId><version>1<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

#cd ../$SERVICE_NAME-db
#operate on db
#add whatever dependencies you need for database interaction

cd ../$SERVICE_NAME-common
#operate on common
sed 's/<dependencies>/<dependencies><dependency><groupId>commons-lang<\/groupId><artifactId>commons-lang<\/artifactId><version>2.6<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.wordnik<\/groupId><artifactId>swagger-jaxrs_2.10<\/artifactId><version>1.3.13<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

cd ../$SERVICE_NAME-beanconverter
#operate on beanconverter
sed 's/<dependencies>/<dependencies><dependency><groupId>javax.ejb<\/groupId><artifactId>ejb-api<\/artifactId><version>3.0<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>javax.inject<\/groupId><artifactId>javax.inject<\/artifactId><version>1<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>net.sf.dozer<\/groupId><artifactId>dozer<\/artifactId><version>5.5.1<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

cd ../$SERVICE_NAME-conf
#operate on conf
sed 's/<dependencies>/<dependencies><dependency><groupId>com.verizon.iot.thingspace.'"$LOWER_CASE_SERVICE_NAME"'service<\/groupId><artifactId>'"$SERVICE_NAME"'-common<\/artifactId><version>${project.version}<\/version><\/dependency>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml


#manipulating the root pom
cd ..
sed 's/<\/modules>/<\/modules><properties><maven.compiler.target>1.8<\/maven.compiler.target><maven.compiler.source>1.8<\/maven.compiler.source><version.war.plugin>2.1.1<\/version.war.plugin><project.build.sourceEncoding>UTF-8<\/project.build.sourceEncoding><\/properties><build><plugins><plugin><groupId>org.apache.maven.plugins<\/groupId><artifactId>maven-compiler-plugin<\/artifactId><version>3.2<\/version><configuration><source>${maven.compiler.source}<\/source><target>${maven.compiler.target}<\/target><\/configuration><\/plugin><\/plugins><\/build>/g' pom.xml > pom2.xml
mv pom2.xml pom.xml

#move to top folder
cd ..

#copy the template Rest files
cp Rest.java ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest.java
sed 's/{Service}/'"${SERVICE_NAME}"'/g' ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest.java > ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest2.java
mv ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest2.java ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest.java

# change the import definitions
sed 's/thingspace.'"${SERVICE_NAME}"'/'"thingspace.${LOWER_CASE_SERVICE_NAME}"'/g' ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest.java > ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest2.java
mv ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest2.java ${SERVICE_NAME}-parent/${SERVICE_NAME}-rest/src/main/java/com/verizon/iot/thingspace/${SERVICE_NAME}service/${SERVICE_NAME}Rest.java


cp -rf web.xml ${SERVICE_NAME}-parent/${SERVICE_NAME}-service/src/main/webapp/WEB-INF/web.xml
sed 's/{Service}/'"${LOWER_CASE_SERVICE_NAME}"'/g' ${SERVICE_NAME}-parent/${SERVICE_NAME}-service/src/main/webapp/WEB-INF/web.xml > ${SERVICE_NAME}-parent/${SERVICE_NAME}-service/src/main/webapp/WEB-INF/web2.xml
mv ${SERVICE_NAME}-parent/${SERVICE_NAME}-service/src/main/webapp/WEB-INF/web2.xml ${SERVICE_NAME}-parent/${SERVICE_NAME}-service/src/main/webapp/WEB-INF/web.xml

cp -rf web.xml ${SERVICE_NAME}-parent/${SERVICE_NAME}-service/src/main/webapp/index.jsp
