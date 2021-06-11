FROM openjdk:8u151-jdk

COPY target/*.jar /usr/src/myapp/
WORKDIR /usr/src/myapp
CMD ["/bin/sh", "-c", "/usr/bin/java -jar my-app-1.0-SNAPSHOT.jar"]