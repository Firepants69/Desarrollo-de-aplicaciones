FROM openjdk:17-slim

WORKDIR /app

# Instala curl para healthchecks y otras dependencias necesarias
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Copia el script de espera (asegúrate de que el script esté en el mismo directorio que el Dockerfile)
COPY wait-for-keycloak.sh /wait-for-keycloak.sh
RUN chmod +x /wait-for-keycloak.sh

# Copia el archivo JAR de la aplicación
ARG JAR_FILE=target/copsboot-*.jar
COPY ${JAR_FILE} app.jar

# Expón el puerto que tu aplicación usará
EXPOSE 8080

# Comando modificado para esperar a Keycloak y luego iniciar la aplicación
ENTRYPOINT ["/wait-for-keycloak.sh", "keycloak", "java", "-jar", "app.jar"]
