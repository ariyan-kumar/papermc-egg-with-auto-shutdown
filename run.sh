#!/bin/bash

# Remove the old server.jar if it exists
rm -f server.jar

# Download the latest PaperMC jar
curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/123/downloads/paper-1.20.1-123.jar

# Start the Minecraft server
java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar server.jar nogui
