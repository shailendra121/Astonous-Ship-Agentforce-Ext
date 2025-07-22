
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


Here’s a well-structured and professionally rephrased version of your instructions using numbered steps and improved formatting:a

### Steps to Set Up Agentforce

### Step 1: Enable Agentforce Agents**

* Go to **Setup** in Salesforce.
* In the **Quick Find** box, search for **Agentforce Agents**.
* Click on it and **enable Agentforce Agents**.


### Step 2: Activate Required Flows**

* In **Quick Find**, search for **Flows**.
* Activate the following flows:

  * `Get shipment details based on tracking number`
  * `Get shipment details`


### Step 3: Create or Update an Agent and Topics**

* Create a new **Agent**, or update an existing one by adding the relevant topic(s).

####  Topic 1: SHIPMENT INFORMATION RETRIEVAL

**Classification Description:**
This topic retrieves shipment information using the customer’s email address. It returns the **tracking number**, **shipment ID**, **shipping carrier**, and **current shipment status** from the Shipment record.

**Scope:**
The agent's task is to fetch shipment details from Salesforce Shipment records using the customer's email and return the relevant shipment details.

**Instruction:**
Prompt the user to provide their email address.

**Topic Action:**
Add the action: **Get shipment details**

### Agent Action Setup: Get Shipment Details**

* **Agent Action Label:** `Get Shipment Details`

* **Agent Action Instructions:**
  The agent will prompt the user for an email address, pass it to the action, and return shipment details including tracking number.

* **Require user confirmation:** `false`

* **Show loading text:** `true`

* **Loading Text:** `"Getting shipment details..."`a

### 🔽 Inputs

1. **Email**

   * **Instructions:** Prompt the user to provide their email address.
   * **Data Type:** `lightning__textType`
   * **Require Input:** `false`
   * **Collect Data from User:** `true`a

### 🔼 Outputs

1. **Shipping Carrier**

   * **Instructions:** Fetch the shipping carrier from the action result.
   * **Data Type:** `lightning__textType`
   * **Show in Conversation:** `true`
   * **Output Rendering:** `Text`

2. **Status**

   * **Instructions:** Fetch the shipment status from the action result.
   * **Data Type:** `lightning__textType`
   * **Show in Conversation:** `true`
   * **Output Rendering:** `Text`

3. **Tracking Number**

   * **Instructions:** Fetch the tracking number from the action result.
   * **Data Type:** `lightning__textType`
   * **Show in Conversation:** `true`
   * **Output Rendering:** `Text`

###  Topic 2: SHIPMENT TRACKING

* Classification Description:
This topic is designed to handle customer inquiries related to tracking a shipment using a tracking number.

* Scope:
The agent's responsibility is to search the Shipment record and return the shipment status when the user provides a valid tracking number.

* Instructions:

* Prompt the user to provide a **tracking number.
* If the tracking number is **not found**, ask the user to verify it or provide additional information (such as their email).
* In such cases, switch to the **"Shipment Information Retrieval"** topic to retrieve full shipment details.

### Topic Action Configuration

* Topic Action:
Add the action: `Get_Shipment_Details_Based_on_Tracking_Number`

###  Agent Action Configuration

* Agent Action Label: 
`Get Shipment Details - Based on Tracking Number`

* Agent Action Instructions: 
Ask the user to provide a **shipment tracking number**. This action will return the **shipping carrier** and **shipment status** based on the tracking number.

* Require User Confirmation: `false`
* Show Loading Text: `true`
* Loading Text: `"Getting shipment details..."`

### Inputs

1. Tracking Number

   * Instructions:** Ask the user to share the tracking number.
   * Data Type: `lightning__textType`
   * Require Input: `false`
   * Collect Data from User: `true`

### Outputs

1. Expected Delivery Date

   * Instructions: Retrieve the **expected delivery date** from the shipment record based on the tracking number.
   * Data Type: `lightning__textType`
   * Show in Conversation: `true`
   * Output Rendering: `Text`

2. Shipping Carrier

   * Instructions: Retrieve the **shipping carrier** from the shipment record using the tracking number.
   * Data Type: `lightning__textType`
   * Show in Conversation: `true`
   * Output Rendering: `Text`

3. Shipment Status

   * Instructions:** Retrieve the **shipment status** using the tracking number.
   * Data Type: `lightning__textType`
   * Show in Conversation: `true`
   * Output Rendering: `Text`

### Grant Read Access to the Astonous Shipment Object in the Agentforce Permission Set




