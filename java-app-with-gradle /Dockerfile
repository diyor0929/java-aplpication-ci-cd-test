FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Bash va curl o'rnatish (wait-for-it.sh uchun)
RUN apk add --no-cache bash curl

# Jar va wait-for-it.sh copy qilamiz
COPY --from=build /app/target/*.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

EXPOSE 9095

ENTRYPOINT ["/bin/bash", "/app/wait-for-it.sh", "sample-java-db:5432", "--", "java", "-jar", "/app/app.jar"]
