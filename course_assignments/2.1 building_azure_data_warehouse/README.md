# building_azure_data_warehouse
This project is the 3rd project in udacity data engineering with microsoft azure - build a azure data warehouse by using bike share data. <br>
The goal of designing the data warehouse is aiming to answer below questions: <br>
- Analyze how much time is spent per ride
- Based on date and time factors such as day of week and time of day
- Based on which station is the starting and / or ending station
- Based on age of the rider at time of the ride
- Based on whether the rider is a member or a casual rider
- Analyze how much money is spent Per month, quarter, year Per member, based on the age of the rider at account start

It contains tasks below: <br>

Task 1: Create Azure resources <br>
Create an Azure PostgreSQL database <br>
Create an Azure Synapse workspace <br>
Create a Dedicated SQL Pool and database within the Synapse workspace <br>

Task 2: Design a star schema in dbdiagram<br>

Task 3: Create the data in Azure PostgreSQL <br>
Use existing repo to create the data in PostgreSQL. <br>
repo: https://github.com/udacity/Azure-Data-Warehouse-Project/tree/main/starter <br>

Task 4: EXTRACT the data from PostgreSQL <br>
Use ingest wizard in Azure Synapse to create a one-time pipeline that ingests the data from Azure PostgreSQL into Azure Blob Storage. <br>

Task 5: LOAD the data into external tables in the data warehouse <br>

Task 6: TRANSFORM the data to the star schema
Write SQL scripts to transform the data from the staging tables to the final star schema designed.
