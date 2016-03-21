From tomcat:8-jre8
MAINTAINER gaurav.gupta2@one.verizon.com

ADD ./Account-parent/Account-service/target/Account-service.war /usr/local/tomcat/webapps/

CMD ["catalina.sh", "run"]
