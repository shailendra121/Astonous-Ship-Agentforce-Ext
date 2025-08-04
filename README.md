
=======
# Asotnous-Ship-Agentforce-Ext

# Steps to setup scratch org

# Step #1
Clone Repo and Authorize DevHub if you haven't already done with support@astonous,com
# Step #2 Create Scratch org
sf org create scratch --definition-file config/project-scratch-def.json --alias Astonous_Ship_Agent --duration-days 30 --set-default 

# Step #3 Install Astonous Ship Package and assign Astonous Shipping Manager permission set to User
sfdx force:package:install --package 04tKe000000syPV 

# Step #4 
Push Source Code -> sf project deploy start 


# Step # 5 Runn below commands to setup data in newaly created scratch org

sfdx force:data:tree:import -p data/Plan.json 



### Steps to Set Up Agentforce after installation of Astonous Agentforce Extension Pack

### Create Topics:- 

* Topic Name: SHIPMENT INFORMATION RETRIEVAL

*** Classification Description:This topic is used to retrieve shipment information based on the customer's email address. It returns the tracking number, shipment ID, shipping carrier, and current shipment status from the associated Shipment record in Salesforce. ***

*** Scope: The agent's role is to fetch shipment details from Salesforce Shipment records using the email address provided by the customer. ***

*** Instruction: Prompt the customer to enter their email address. ***

*** Topic Action: Add the action: Get shipment details ***

*** Note: If you encounter an error while adding the action during topic creation, click Finish to complete the topic setup. Afterwards, go back to the topic, click Add Action, and select Get shipment details from the asset library. ***


* Topic Name: SHIPMENT TRACKING

*** Classification Description:This topic is designed to handle customer inquiries related to tracking a shipment using a tracking number. ***

*** Scope: The agent's responsibility is to search the Shipment record and return the shipment status when the user provides a valid tracking number. ***

*** Instruction: Prompt the user to provide a **tracking number ***

*** Topic Action: Add the action: Get_Shipment_Details_Based_on_Tracking_Number ***

*** Note: If you encounter an error while adding the action during topic creation, click Finish to complete the topic setup. Afterwards, go back to the topic, click Add Action, and select Get shipment details from the asset library. ***






