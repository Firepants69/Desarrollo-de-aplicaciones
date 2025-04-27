FROM eclipse-temurin:17-jdk-jammy AS builder

WORKDIR /app

RUN apt-get update && \
    apt-get install -y dos2unix && \
    rm -rf /var/lib/apt/lists/*

COPY .mvn/ .mvn/
COPY mvnw pom.xml ./

RUN dos2unix mvnw && \
    chmod +x mvnw && \
    ./mvnw --version

RUN ./mvnw dependency:go-offline -DskipTests

COPY src ./src
RUN ./mvnw clean package -DskipTests -Dmaven.test.skip=true

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]