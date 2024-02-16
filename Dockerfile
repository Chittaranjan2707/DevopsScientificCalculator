FROM openjdk:11

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/javaCalc-with-dependencies.jar /app/

# Define the command to run the JAR file
#CMD ["java", "-jar", "minispe-1.0-SNAPSHOT.jar"]