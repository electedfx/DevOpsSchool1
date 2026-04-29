FROM alpine:latest AS build
RUN apk update && apk add openjdk11 maven git
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV MAVEN_HOME=/usr/share/maven
ENV PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH
RUN mkdir /src && cd /src && git clone https://github.com/99North/Sample-Web-App.git
WORKDIR /src/Sample-Web-App/
RUN mvn package
FROM tomcat:latest
COPY --from=build /src/Sample-Web-App/target/*.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]