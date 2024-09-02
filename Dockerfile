FROM maven:3.8.5-openjdk-17-slim as stage1

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=stage1 /app/target/my-app-1.0-SNAPSHOT.jar ./my-app.jar

ENTRYPOINT ["java", "-jar", "my-app.jar"]
