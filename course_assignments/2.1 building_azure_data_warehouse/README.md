# building_azure_data_warehouse
This project is the 3rd project in udacity data engineering with microsoft azure - build a azure data warehouse. <br>
It contains tasks below: <br>

Task 1: Create your Azure resources <br>
Create an Azure PostgreSQL database <br>
Create an Azure Synapse workspace <br>
Create a Dedicated SQL Pool and database within the Synapse workspace <br>

Task 2: Design a star schema <br>

Task 3: Create the data in PostgreSQL <br>
Use existing repo to create the data in PostgreSQL. <br>

Task 4: EXTRACT the data from PostgreSQL <br>
In your Azure Synapse workspace, you will use the ingest wizard to create a one-time pipeline that ingests the data from PostgreSQL into Azure Blob Storage. <br>
This will result in all four tables being represented as text files in Blob Storage, ready for loading into the data warehouse. <br>

Task 5: LOAD the data into external tables in the data warehouse <br>
Once in Blob storage, the files will be shown in the data lake node in the Synapse Workspace. <br>
From here, you can use the script generating function to load the data from blob storage into external staging tables in the data warehouse you created using the Dedicated SQL Pool.

Task 6: TRANSFORM the data to the star schema
You will write SQL scripts to transform the data from the staging tables to the final star schema you designed.
