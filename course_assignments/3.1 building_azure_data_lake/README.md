# Building an Azure Data Lake for Bike Share Data Analytics
This project is the 4th project in udacity data engineering with microsoft azure - build a azure data lake by using bike share data. <br>
The goal of designing the datalake is aiming to answer below questions: <br>
- Analyze how much time is spent per ride
- Based on date and time factors such as day of week and time of day
- Based on which station is the starting and / or ending station
- Based on age of the rider at time of the ride
- Based on whether the rider is a member or a casual rider
- Analyze how much money is spent Per month, quarter, year Per member, based on the age of the rider at account start

It contains tasks below: <br>

Design a star schema based on the business outcomes below; <br>
Import the data into Azure Databricks using Delta Lake to create a Bronze data store; <br>
Create a gold data store in Delta Lake tables; <br>
Transform the data into the star schema for a Gold data store; <br>

The steps include:
- Create databricks resource in Azure <br>
- Create cluster in databricks <br>
- Upload csv files into databricks file store by using UI <br>
- Refine tables add column names to each table <br>
- Write data into delta file system <br>
- Create delta tables <br>
- Transform data to star schema <br>
- Write star schema into delta tables <br>