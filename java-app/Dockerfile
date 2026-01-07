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

# jar ni copy qilamiz
COPY --from=build /app/target/*.jar app.jar

# logs papkasi
RUN mkdir -p /app/logs

# port ochamiz
EXPOSE 9095

# entrypoint
ENTRYPOINT ["java","-jar","/app/app.jar"]
