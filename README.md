# Usar docker
### inicializar el keyloack y la base de datos
docker-compose up -d
### construir la imagen de docker para springboot
docker build -t copsboot-app . 
### Ejecutar la aplicación Spring Boot
docker run -p 8080:8080 --network host copsboot-app
