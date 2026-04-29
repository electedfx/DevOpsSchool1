FROM alpine:latest AS build
RUN apk update && apk install mvn git -f
RUN cd /src/ && git clone https://github.com/99North/Sample-Web-App.git && cd Sample-Web-App/
RUN mvn package 
FROM tomcat:latest
COPY --from=build /src/Sample-Web-App/target/WebApp.war /var/lib/tomcat/webapps
EXPOSE 8080