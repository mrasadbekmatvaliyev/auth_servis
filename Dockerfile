# Base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy Gradle wrapper and build files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Copy source code
COPY src src

# Make Gradle wrapper executable
RUN chmod +x ./gradlew

# Build the project (skip tests to make it faster)
RUN ./gradlew clean build -x test

# Expose the app port
EXPOSE 8080

# Run the application
CMD ["java", "-Dspring.profiles.active=prod", "-jar", "build/libs/user-auth-0.0.1-SNAPSHOT.jar"]
