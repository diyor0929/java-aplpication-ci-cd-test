FROM gradle:8.4-jdk17 AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
COPY src ./src
RUN gradle clean build -x test

FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
RUN apk add --no-cache bash curl
COPY --from=build /app/build/libs/*.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

EXPOSE 9095

ENTRYPOINT ["/bin/bash", "/app/wait-for-it.sh", "db:5432", "--", "java", "-jar", "/app/app.jar"]
