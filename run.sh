:: Remove the existing server.jar file
del /f server.jar

:: Download the new server.jar file
curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.20.1/builds/123/downloads/paper-1.20.1-123.jar

:: Run the server.jar file with Java
java -Xms128M -XX:MaxRAMPercentage=95.0 -Dterminal.jline=false -Dterminal.ansi=true -jar server.jar
