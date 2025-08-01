#!/bin/bash
#Create directory and download transport
mkdir abap_sdk_transport
cd abap_sdk_transport
gcloud storage cp gs://sap-hana-lab/sap-installers/abap-sdk/abap-sdk-for-google-cloud-1.10.zip .

# Copy code genie
wget -c https://raw.githubusercontent.com/google/genie-for-sap-abap-ai-assistant-sample/refs/heads/main/transport_files/K900112.A4H
wget -c https://raw.githubusercontent.com/google/genie-for-sap-abap-ai-assistant-sample/refs/heads/main/transport_files/R900112.A4H
#wget -c https://raw.githubusercontent.com/google/genie-for-sap-abap-ai-assistant-sample/refs/heads/main/transport_files/Code%20Genie%20-%20Prompts.XLSX

#Unzip the transport files
unzip abap-sdk-for-google-cloud-1.10.zip

# Copy transport files into the Docker container
sudo docker cp K900451.GM1 a4h:/usr/sap/trans/cofiles/K900451.GM1
sudo docker cp R900451.GM1 a4h:/usr/sap/trans/data/R900451.GM1
sudo docker cp K900453.GM1 a4h:/usr/sap/trans/cofiles/K900453.GM1
sudo docker cp R900453.GM1 a4h:/usr/sap/trans/data/R900453.GM1
sudo docker cp K900455.GM1 a4h:/usr/sap/trans/cofiles/K900455.GM1
sudo docker cp R900455.GM1 a4h:/usr/sap/trans/data/R900455.GM1

# Copy transport file code genie into Docker container
sudo docker cp K900112.A4H a4h:/usr/sap/trans/cofiles/K900112.A4H
sudo docker cp R900112.A4H a4h:/usr/sap/trans/data/R900112.A4H

# Set correct permissions for the copied files within the container
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900451.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900451.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900453.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900453.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900455.GM1
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900455.GM1

# Set correct permissions for the copied GENIE files within the container
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/cofiles/K900112.A4H
sudo docker exec -it a4h chown a4hadm:sapsys /usr/sap/trans/data/R900112.A4H

# Add transports to buffer and import them
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900451 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900451 A4H U128 client=001'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900453 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900453 A4H U128 client=001'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer GM1K900455 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import GM1K900455 A4H U128 client=001'

# Add GENIE transports to buffer and import them
sudo docker exec -it a4h runuser -l a4hadm -c 'tp addtobuffer A4HK900112 A4H client=001 pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL'
sudo docker exec -it a4h runuser -l a4hadm -c 'tp pf=/usr/sap/trans/bin/TP_DOMAIN_A4H.PFL import A4HK900112 A4H U128 client=001'


