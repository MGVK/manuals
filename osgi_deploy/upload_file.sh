#!/usr/bin/expect -f

#cd /home/erus/WS/eclipse-workspace/iot-kura-user/iot-kura-user/ws/org.eclipse.kura.example.hello_osgi/$

# HOST=30.0.3.3
 #PORT_SFTP=22
 #PORT_OSGI=5002
 #USER=pi
 #PASSWORD=9348rasp
 #FILE_NAME=$(ls | sort -r | head -n 1)
 #SOURCE_FILE=/home/erus/WS/eclipse-workspace/iot-kura-user/iot-kura-user/ws/org.eclipse.kura.example.h$

# TARGET_FILE=/opt/eclipse/kura_4.0.0_raspberry-pi-2/plugins/$FILE_NAME;


set HOST "[lrange $argv 0 0]"
set PORT "[lrange $argv 1 1]"
set USER "[lrange $argv 2 2]"
set PASSWORD "[lrange $argv 3 3]"
set SOURCE_FILE "[lrange $argv 4 4]"
set TARGET_FILE "[lrange $argv 5 5]"

spawn /usr/bin/sftp -o Port=$PORT $USER@$HOST
expect "password:"
send "$PASSWORD\r"
expect "sftp>"
send "put $SOURCE_FILE $TARGET_FILE\r"
expect "sftp>"
send "bye\r"
