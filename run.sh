#!/bin/bash

# Define variables
MC_VERSION="1.20.4"
BUILD_NUMBER="499"
JAR_NAME="paper-${MC_VERSION}-${BUILD_NUMBER}.jar"
DOWNLOAD_URL="https://api.papermc.io/v2/projects/paper/versions/${MC_VERSION}/builds/${BUILD_NUMBER}/downloads/${JAR_NAME}"
JAR_PATH="./${JAR_NAME}"
PLUGIN_DIR="./plugins"
PLUGIN_JAR="$PLUGIN_DIR/AutoStop-1.0-SNAPSHOT.jar"
CONFIG_FILE="$PLUGIN_DIR/config.yml"
AUTOSTOP_JAR_URL="https://github.com/pmdevita/AutoStop/releases/download/1.0/AutoStop-1.0-SNAPSHOT.jar"
AUTOSTOP_CONFIG_URL="https://raw.githubusercontent.com/pmdevita/AutoStop/refs/heads/master/src/main/resources/config.yml"

# Ensure necessary directories exist
mkdir -p "$PLUGIN_DIR"

# Delete existing server JAR file
if [ -f "$JAR_PATH" ]; then
  echo "Deleting existing JAR file..."
  rm "$JAR_PATH"
fi

# Download the latest server JAR file
echo "Downloading the latest server JAR file..."
wget -q -O "$JAR_PATH" "$DOWNLOAD_URL"
if [ ! -f "$JAR_PATH" ] || [ ! -s "$JAR_PATH" ]; then
  echo "#############################################"
  echo "# You ran into a problem!                   #"
  echo "# Please contact an Arcade Alliance admin   #"
  echo "# and send this error log:                  #"
  echo "#############################################"
  echo "Error: Failed to download the server JAR file from $DOWNLOAD_URL."
  exit 1
fi

# Delete existing AutoStop plugin
if [ -f "$PLUGIN_JAR" ]; then
  echo "Deleting existing AutoStop plugin..."
  rm "$PLUGIN_JAR"
fi

# Download the AutoStop plugin
echo "Downloading AutoStop plugin..."
wget -q -O "$PLUGIN_JAR" "$AUTOSTOP_JAR_URL"
if [ ! -f "$PLUGIN_JAR" ] || [ ! -s "$PLUGIN_JAR" ]; then
  echo "#############################################"
  echo "# You ran into a problem!                   #"
  echo "# Please contact an Arcade Alliance admin   #"
  echo "# and send this error log:                  #"
  echo "#############################################"
  echo "Error: Failed to download the AutoStop plugin from $AUTOSTOP_JAR_URL."
  exit 1
fi

# Delete existing AutoStop config.yml
if [ -f "$CONFIG_FILE" ]; then
  echo "Deleting existing AutoStop config.yml..."
  rm "$CONFIG_FILE"
fi

# Download the AutoStop config.yml
echo "Downloading AutoStop config.yml..."
wget -q -O "$CONFIG_FILE" "$AUTOSTOP_CONFIG_URL"
if [ ! -f "$CONFIG_FILE" ] || [ ! -s "$CONFIG_FILE" ]; then
  echo "#############################################"
  echo "# You ran into a problem!                   #"
  echo "# Please contact an Arcade Alliance admin   #"
  echo "# and send this error log:                  #"
  echo "#############################################"
  echo "Error: Failed to download the AutoStop config.yml from $AUTOSTOP_CONFIG_URL."
  exit 1
fi

# Clear the screen and display the banner
clear
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
  echo "#############################################"
  echo "# You ran into a problem!                   #"
  echo "# Please contact an Arcade Alliance admin   #"
  echo "# and send this error log:                  #"
  echo "#############################################"
  echo "Error: Java is not installed or not in PATH. Please install Java 17 or higher."
  exit 1
fi

# Start the server with auto-shutdown functionality
echo "Starting the server..."
timeout 15m java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar "$JAR_PATH"

# Check if the server stopped due to timeout
if [ $? -eq 124 ]; then
  echo "Server stopped automatically after 15 minutes due to inactivity."
else
  echo "Server stopped."
fi
