#!/bin/bash
#Create directory and download transport
mkdir abap_sdk_transport
cd abap_sdk_transport
wget "https://storage.googleapis.com/sap-hana-lab/sap-installers/abap-sdk/abap-sdk-for-google-cloud-1.11.zip"

#Unzip the transport files
unzip "abap-sdk-for-google-cloud-1.11.zip"

# Copy transport files into the Docker container
sudo docker cp K900457.GM1 a4h:/usr/sap/trans/cofiles/K900457.GM1
sudo docker cp R900457.GM1 a4h:/usr/sap/trans/data/R900457.GM1
sudo docker cp K900459.GM1 a4h:/usr/sap/trans/cofiles/K900459.GM1
sudo docker cp R900459.GM1 a4h:/usr/sap/trans/data/R900459.GM1
sudo docker cp K900461.GM1 a4h:/usr/sap/trans/cofiles/K900461.GM1
sudo docker cp R900461.GM1 a4h:/usr/sap/trans/data/R900461.GM1

# Set correct permissions for the copied files within the container
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900457.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900457.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900459.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900459.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900461.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900461.GM1

# Add transports to buffer and import them
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900457 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900457 A4H U128 client=001'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900459 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900459 A4H U128 client=001'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900461 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900461 A4H U128 client=001'
