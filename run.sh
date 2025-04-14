#!/bin/bash

clear

# Define paths
JAR_DIR="../jar-files"
SERVER_JAR="$JAR_DIR/server-${MC_VERSION}.jar"

# Display Arcade Alliance banner and free plan message
echo "#############################################"
echo "#                                           #"
echo "#              Arcade Alliance              #"
echo "#                                           #"
echo "#############################################"
echo ""
echo "You are using our free plans. Your server will stop in 15 minutes if no player joins after starting the server."
echo ""
sleep 10

# Run the server
if [ -f "$SERVER_JAR" ] && [ -s "$SERVER_JAR" ]; then
  echo "Starting the server..."
  java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar "$SERVER_JAR"
else
  echo "Error: Server JAR not found or is empty. Please contact Arcade Alliance admin team!!!"
  exit 1
fi
