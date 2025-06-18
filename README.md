<<<<<<< HEAD
# Steps to setup scratch org

Clone Repo
Authorize DevHub with support@astonous.com

Commands to Create New Scratch Org :- sf org create scratch --definition-file config/project-scratch-def.json --alias Astonous_Ship_Agent --duration-days 30 --set-default 
Push Source Code -> sf project deploy start 
=======
# Asotnous-Ship-Agentforce-Ext

# Step #1
Authorize DevHub if you haven't already done with support@astonous,com
# Step #2 Create Scratch org
sf org create scratch --definition-file config/project-scratch-def.json --alias Astonous_Ship_Agent --duration-days 30 --set-default 
# Step #3 
Push Source Code -> sf project deploy start 

# Step #4  
Install Latest version of Astonous Shipping App in newaly created org

# Step # 5 Runn bewlo commands to setup data in newaly created scratch org

sfdx force:data:tree:import -p data/Plan.json 

>>>>>>> b595cd30553897160ddef9dfaa09e169979bb90f
