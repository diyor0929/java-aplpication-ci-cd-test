# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

# pom va src copy qilamiz
COPY pom.xml .
COPY src ./src

# Build jar
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Bash o'rnatamiz (wait-for-it.sh ishlashi uchun)
RUN apk add --no-cache bash

# Jar va wait-for-it.sh copy qilamiz
COPY --from=build /app/target/*.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

# logs papkasi
RUN mkdir -p /app/logs

# port ochamiz
EXPOSE 9095

# entrypoint: DB tayyor bo‘lishini kutib, keyin jar ishga tushadi
ENTRYPOINT ["/bin/bash", "/app/wait-for-it.sh", "sample-java-db:5432", "--", "java", "-jar", "/app/app.jar"]
