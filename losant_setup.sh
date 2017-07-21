#!/bin/sh

echo "Installing MQTT tools..."
opkg update
opkg install mosquitto-ssl mosquitto-client-ssl libmosquitto-ssl

echo "Setup Losant Access..."
read -p "Losant Device ID: " deviceId
read -p "Losant Access Key: " accessKey
read -p "Losant Access Secret: " accessSecret

echo "Downloading Losant Root Certificate..."
mkdir -p /etc/losant/
wget https://raw.githubusercontent.com/Losant/losant-mqtt-ruby/master/lib/losant_mqtt/RootCA.crt -P /etc/losant/

echo "# For debugging
log_type all

# Bridge to Losant
connection bridge-to-losant
address broker.losant.com:8883
bridge_cafile /etc/losant/RootCA.crt
cleansession true
try_private false
bridge_attempt_unsubscribe false
notifications false
remote_clientid $deviceId
remote_username $accessKey
remote_password $accessSecret
topic losant/$deviceId/state out 0
topic losant/$deviceId/command in 0
" > /etc/mosquitto/mosquitto.conf

/etc/init.d/mosquitto restart

echo "All Done!"
echo ""
echo "Subscribe to commands with:
    mosquitto_sub -t losant/$deviceId/command"
echo "Update state with:
    mosquitto_pub -t losant/$deviceId/state -m {\"data\": {\"varName\": \"OK\"}}"
