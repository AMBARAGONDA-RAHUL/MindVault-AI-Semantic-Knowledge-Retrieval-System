# Use an official Minecraft server base image
FROM itzg/minecraft-server:latest

# Set environment variables
ENV EULA=TRUE
ENV VERSION=LATEST

# Expose Minecraft server port
EXPOSE 25565

# Run Minecraft server on container start
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
