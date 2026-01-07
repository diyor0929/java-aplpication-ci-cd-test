# Stage 1: Build
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# jar ni copy qilamiz
COPY --from=build /app/target/*.jar app.jar

# wait-for-it skriptini qo'shamiz
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

# logs papkasi
RUN mkdir -p /app/logs

# port ochamiz
EXPOSE 9095

# entrypoint: DB tayyor bo‘lishini kutish
ENTRYPOINT ["/app/wait-for-it.sh", "sample-java-db:5432", "--", "java", "-jar", "/app/app.jar"]
