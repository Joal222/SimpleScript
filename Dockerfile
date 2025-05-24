FROM maven:3.9.6-eclipse-temurin-17-alpine AS builder
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline -B || true
COPY src ./src
RUN mvn package -DskipTests
FROM openjdk:17-jdk-slim
WORKDIR /opt/app
COPY --from=builder /build/target/*.jar application.jar
ENTRYPOINT ["java", "-jar", "/opt/app/application.jar"]