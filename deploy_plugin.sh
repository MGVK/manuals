#!/bin/bash


 PROJECT_FOLDER="/home/erus/WS/IdeaProjects/KuraGateway/ru.mgvk.kura.gateway/"
 PLUGINS_FOLDER="/home/erus/WS/IdeaProjects/KuraGateway/ru.mgvk.kura.gateway/target/"
 OUTPUT_FOLDER="/opt/eclipse/kura_4.0.0_raspberry-pi-2/plugins/"

function init () {

 cd $PLUGINS_FOLDER

 # HOSTS=(192.168.1.34 192.168.1.74)
 # HOSTS=(192.168.1.74)


 HOSTS=(30.0.3.3 30.0.3.5)
 USERS=(pi root)
 PASSWORDS=(9348rasp 9348oneplus)

 # HOSTS=(30.0.3.5) 
 # USERS=(root)
 # PASSWORDS=(9348oneplus)

 # HOSTS=(30.0.3.3)
 # USERS=(pi)
 # PASSWORDS=(9348rasp)



 PORT_SFTP=22
 PORT_OSGI=5002

 FILE_NAME=$(ls -t | grep jar | head -n 1)

 SOURCE_FILE=$(echo $PLUGINS_FOLDER$FILE_NAME)

 TARGET_FILE=$(echo $OUTPUT_FOLDER$FILE_NAME)

echo "------------SOURCE_FILE------------"

echo $SOURCE_FILE 

echo "------------TARGET_FILE------------"

echo $TARGET_FILE 

echo "------------------------"

 cd /home/erus/files/Scripts/deploy/

echo "TROLOLO" $BUNDLE_ID


}

init

for index in ${!HOSTS[*]}
do
    echo doing for ${HOSTS[$index]}

    HOST=${HOSTS[$index]}
    USER=${USERS[$index]}
    PASSWORD=${PASSWORDS[$index]}

    case "$1" in
        'i')
        
        ./upload_file.sh $HOST $PORT_SFTP \
        $USER $PASSWORD $SOURCE_FILE $TARGET_FILE;
        echo "installing..."
        declare -i BUNDLE_ID
        BUNDLE_ID=$(./osgi_install.sh $HOST $TARGET_FILE  | grep BundleId | awk '{printf("%d",$2)}')    
        echo "$BUNDLE_ID">bundle_id_$index
        ./run_bundle.sh $HOST $BUNDLE_ID

        ;;
        'r')

        declare -i BUNDLE_ID
        if [ -f bundle_id_$index ]; then
            BUNDLE_ID=$(cat bundle_id_$index);
        fi
        echo "removing..."
        ./osgi_uninstall.sh $HOST $BUNDLE_ID

        ;;
        *)

        ./upload_file.sh $HOST $PORT_SFTP \
        $USER $PASSWORD $SOURCE_FILE $TARGET_FILE;
        declare -i BUNDLE_ID
        if [ -f bundle_id_$index ]; then
            BUNDLE_ID=$(cat bundle_id_$index);
        fi
        ./osgi_update.sh $HOST $BUNDLE_ID $TARGET_FILE
        ./run_bundle.sh $HOST $BUNDLE_ID
        ;;
    esac



done







