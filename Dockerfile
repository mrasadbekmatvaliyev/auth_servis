# Java 17 base image
FROM openjdk:17-jdk-slim

# Working directory
WORKDIR /app

# Copy gradle wrapper and build files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Copy source code
COPY src src

# Make gradlew executable
RUN chmod +x gradlew

# Build the application
RUN ./gradlew build -x test

# Expose port
EXPOSE 8080

# Run the application
CMD ["java", "-Dspring.profiles.active=prod", "-jar", "build/libs/user-auth-0.0.1-SNAPSHOT.jar"]
