# ------------ STAGE 1: Build ------------
FROM gradle:8.4.0-jdk17 AS builder

# Setează directorul de lucru
WORKDIR /app

# Copiază fișierele proiectului în container
COPY . .

RUN gradle build --no-daemon --project-cache-dir=/app/.gradle


FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
