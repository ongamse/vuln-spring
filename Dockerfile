FROM maven:3-jdk-8-slim AS builder
WORKDIR /app
COPY . /app/
RUN mvn -Dmaven.test.skip=true package


FROM openjdk:8-jre-alpine AS build
WORKDIR /app
RUN echo "top secret key is here" > /app/secret
COPY --from=0 /app/target/vuln-spring*.jar vuln-spring.jar
ENTRYPOINT [ "java", "-jar", "vuln-spring.jar" ]
