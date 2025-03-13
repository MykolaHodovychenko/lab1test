# Використання офіційного Maven-образу для зборки
FROM maven:3.8.6-openjdk-17 AS build

# Встановлюємо робочу директорію
WORKDIR /app

# Копіюємо файли проєкту в контейнер
COPY . .

# Будуємо Spring Boot-додаток
RUN mvn clean package -DskipTests

# Використання OpenJDK для запуску фінального контейнера
FROM openjdk:17-jdk-slim

# Встановлюємо робочу директорію
WORKDIR /app

# Копіюємо JAR-файл із попереднього контейнера
COPY --from=build /app/target/*.jar app.jar

# Відкриваємо порт (Render автоматично визначає його)
EXPOSE 8080

# Запускаємо Spring Boot-додаток
ENTRYPOINT ["java", "-jar", "app.jar"]
