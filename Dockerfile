# Stage 1: Build
FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app

# Pom faylni ko‘chirib dependencies offline yuklash
COPY pom.xml .
RUN mvn dependency:go-offline

# Source code ni copy qilish va build qilish
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app

# Fat jar ni copy qilish
COPY --from=build /app/target/*.jar app.jar

# Docker konteyner ichidagi port
EXPOSE 9095

# Entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]
