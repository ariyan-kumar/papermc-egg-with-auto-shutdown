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

# Check if Java is installed
if ! command -v java &> /dev/null; then
  echo "Error: Java is not installed or not in PATH. Please install Java 17 or higher."
  exit 1
fi

# Run the server
if [ -f "$SERVER_JAR" ] && [ -s "$SERVER_JAR" ]; then
  echo "Starting the server..."
  java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar "$SERVER_JAR"
else
  echo "Error: Server JAR not found or is empty. Please ensure the file exists at $SERVER_JAR and is not corrupted."
  exit 1
fi
