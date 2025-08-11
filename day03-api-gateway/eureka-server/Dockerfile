# syntax=docker/dockerfile:1
FROM eclipse-temurin:17-jre
ARG JAR_FILE=target/*.jar
WORKDIR /app
COPY ${JAR_FILE} app.jar
EXPOSE 8761
ENTRYPOINT ["java","-jar","/app/app.jar"]
