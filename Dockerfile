FROM maven:3.8.5-openjdk-17-slim as stage1

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package
RUN JAR_FILE=$(ls target/*.jar) && mv $JAR_FILE /app/app.jar

FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=stage1 /app/app.jar ./app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
