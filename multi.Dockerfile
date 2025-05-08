FROM gradle AS build

WORKDIR /app

COPY . .

RUN gradle build

FROM openjdk:17-jdk-slim-buster AS run
WORKDIR /bin
COPY --from=build /app/build/libs/spring-petclinic-3.4.0.jar .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-petclinic-3.4.0.jar"]

