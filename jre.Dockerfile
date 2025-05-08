FROM openjdk:17-jdk-slim-buster
WORKDIR /app

# COPY /target/*.jar ./java.jar
COPY build/libs/* build/

EXPOSE 8080

WORKDIR /app/build
ENTRYPOINT java -jar spring-petclinic-*.0.jar
