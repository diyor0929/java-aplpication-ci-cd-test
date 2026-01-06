# Stage 1: Build
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Pom & dependencies offline
COPY pom.xml .
RUN mvn dependency:go-offline

# Source code
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app

# Copy the jar from build stage
COPY --from=build /app/target/sample-java-ci-cd-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run
ENTRYPOINT ["java","-jar","app.jar"]
