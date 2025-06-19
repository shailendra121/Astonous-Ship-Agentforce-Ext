
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
