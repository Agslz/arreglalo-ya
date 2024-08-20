# Usar una imagen base de Maven para compilar la aplicación
FROM maven:3.8.4-openjdk-17-slim AS build

# Establecer el directorio de trabajo para el proceso de construcción
WORKDIR /app

# Copiar el archivo pom.xml y el código fuente al contenedor
COPY pom.xml /app/
COPY src /app/src

# Ejecutar el comando para compilar el proyecto y empaquetarlo en un archivo JAR
RUN mvn clean package -DskipTests

# Usar una imagen base de Java para ejecutar la aplicación
FROM openjdk:17-jdk-alpine

# Establecer el directorio de trabajo para la aplicación
WORKDIR /app

# Copiar el archivo JAR generado desde la imagen de construcción
COPY --from=build /app/target/sp-0.0.1-SNAPSHOT.jar /app/arreglalo-ya.jar

# Exponer el puerto en el que la aplicación corre
EXPOSE 8080

# Establecer las variables de entorno desde el archivo .env
ENV DB_USERNAME=${DB_USERNAME}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_URL=${DB_URL}
ENV MAIL_HOST=${MAIL_HOST}
ENV MAIL_PASSWORD=${MAIL_PASSWORD}
ENV MAIL_PORT=${MAIL_PORT}
ENV MAIL_USERNAME=${MAIL_USERNAME}
ENV GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}
ENV GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}

# Ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app/arreglalo-ya.jar"]
