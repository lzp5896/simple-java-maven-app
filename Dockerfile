# This file is a template, and might need editing before it works on your project.
FROM openjdk:8u151-jdk

COPY target/*.jar /usr/src/myapp/
WORKDIR /usr/src/myapp
CMD ['java', '-jar', 'target/my-app-1.0-SNAPSHOT.jar']