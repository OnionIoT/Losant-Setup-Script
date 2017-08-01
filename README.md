# Auto setup script for the Omega2 on Losant Cloud Platform

# Usage

```bash
wget -qP /tmp https://raw.githubusercontent.com/OnionIoT/Losant-Setup-Script/master/losant_setup.sh; sh /tmp/losant_setup.sh; rm /tmp/losant_setup.sh;
```
Enter Losant Device ID, Access Key and Access Secret when prompted


# Communicating with Losant

Update device state:

```
mosquitto_pub -t losant/[DEVICE-ID]/state -m {"data": {"varName": "OK"}}
```


Subscribe to command topic for your device: 

```
mosquitto_sub -t losant/[DEVICE-ID]/command"
```
