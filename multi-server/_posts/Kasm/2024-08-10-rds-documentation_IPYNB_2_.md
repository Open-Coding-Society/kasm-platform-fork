---
layout: post
title: Relational Database Service (RDS) Setup
permalink: /kasm/database/rds
menu: nav/kasm_cloud.html
categories: ['Kasm']
author: Tanisha Patil
toc: True
comments: True
---

## Introduction
Amazon Web Services (AWS) Provides a Relational Database Service (RDS).  For our Kasm project we use RDS as the primary database for users and group definitions.  By so doing, the RDS doubles as be a classroom management database.

This document describes RDS setup and management.

## RDS Security Group

A database starts with security.  This process sets up Inbound and Outbound access.

### Step 1: Login to AWS Management Console
1. Go to the [AWS Management Console](https://aws.amazon.com/console/).
2. Log in with AWS credentials.

### Step 2: Navigate to EC2 Security Groups
1. In the AWS Management Console, navigate to the **EC2 Dashboard**.
2. In the left-hand menu, scroll down and select **Security Groups** under **Network & Security**.

### Step 3: Create a New Security Group
1. Click on the **Create security group** button.
2. Enter a name for security group. Name it something that reflects purpose ex. 'rds_access' or `RDS_Security_Group`.
3. Select the **VPC**  : vpc-faea2491 (tester)

_This is the screen you should see_
![Create Security Group](https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/cad4d218-51ac-4345-ab90-3355dabc2cb8)


### Step 4: Configure Inbound and Outbound Rules
_Note : Apply the rules that match YOUR requirements_
- Inbound Rules: These rules define the incoming traffic allowed to reach your AWS resource. ex. if you have a web server, you might allow inbound HTTP and HTTPS traffic from the internet.
- Outbound Rules: These rules specify the outgoing traffic allowed from your AWS resource to other destinations. ex.  if your web server needs to access an external API, you would set up outbound rules to permit this traffic.

**Inbound :**
1. Click on the **Inbound rules** tab.
2. Click on **Add Rule** to add the necessary inbound rules for your RDS instance:
  - **Type**: Custom TCP
  - **Protocol**: TCP
  - **Port range**: 3306
  - **Source Type**: Custom
  - **Source** : Specify the IP range that will be allowed to connect.
   
OR     

   - **Type**: Custom TCP
   - **Protocol**: TCP
   - **Port range**: 3306
   - **Source Type**: My IP
  
**Outbound :**
1. Click on the **Outbound rules** tab.
2. Click on **Add Rule**
3. Add outbound rule that allows all traffic (or restrict as per your requirement).


### Step 6: Review and Create
1. Review security group settings.
2. Click on the **Create security group** button to finalize.

##  RDS Instance

A database instance is the endpoint of all transactions to store and retrieve data.

### Step 1: Navigate to RDS Dashboard
1. In the AWS Management Console, navigate to the **RDS Dashboard** by selecting **RDS** from the services menu.

### Step 2: Launch DB Instance
1. Click on the **Create database** button.
2. Select the **Standard Create** option.
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/a0d49433-f5a8-4cee-bbd5-c8aabfff1551">

### Step 3: Choose a Database Engine
1. Select the database engine you want to use : MySQL
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/6fdf8877-433e-442d-8b5c-7fb9eda9c7fe">

### Step 4: Configure Database Settings
1. Specify the template as Free teir
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/e26a110a-9333-49b0-936b-00cf8cd80670">

2. **DB instance identifier**, **Master username**, and **Master password**.
_NOTE : SAVE THE USERNAME AND PASSWORD INFORMATION FOR A LATER STEP_
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/9b0c1d14-2f3a-410c-a696-c1ca20e25e84">

3. Choose the **DB instance size**  : db.t3.micro
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/599b87ed-a1a9-41d3-b8a3-6af2d7b96487">

### Step 5: Configure Storage
1. Choose the allocated storage size for your database.
2. Enable **storage auto-scaling** if needed.
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/12ed298f-4f62-4d06-941b-9f2a095c4dce">

### Step 6: Configure Connectivity
1. In the **Connectivity** section, choose the **VPC** default.
2. Select the **Subnet group** default
5. Under **Public access**, choose YES.
6. For **VPC security group**, choose the security group you created earlier (`RDS_Security_Group`).
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/5a6d4816-5da7-40a3-8c5a-1279b8c8179c">

### Step 7: Authentication Configuration
1. Configure database authentication as password only 
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/10c40e38-2a62-44a9-b8cd-f70605f68794">

### Step 8: Review and Launch
1. Review all your settings.
2. Click on the **Create database** button to launch your RDS instance.

Once your RDS instance is created, it will appear in the RDS dashboard, and you can connect to it using the endpoint provided.

##  RDS Connection

A connection to a database is how all the relational database transactions occur.

### Step 1: Obtain the Endpoint
1. In the RDS Dashboard, click on your database instance to view its details.
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/e52144d7-b245-4644-a405-fde8fa787a2f">

2. Copy the **Endpoint** and **Port** information.
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/0cc9400c-23fa-4985-b022-bea4f71bcadf">

### Step 2. **Connect to RDS**
1. Use SQL client or use terminal to connect to RDS instance. You will be asked for the password set earlier for authentication. 
`mysql -h your-rds-endpoint -P 3306 -u your-master-username -p`
<img width="400" alt="image" src="https://github.com/nighthawkcoders/kasmv2_flask/assets/111611921/d7a4143a-1934-474b-8532-5add049e8f8a">

2. Optional.  Perform SQL operations directly on your RDS instance.  Through connection you typically perform adminstrative commands like Creating a database or Reviewing Schema.  For our Kasm project these elements have been built into Python.  

## RDS Python usage

The Kasm project is using Python with the Flask framework to manage the database.  The GitHub project `nighthawkcoders/flask_2005` contains all the model definitions for the RDS instance defined above.

### Python Requirements
1. Observe the requirements.txt file, it requires: 
`pymysql`

2. Update python environment to include pymysql: 
`pip install -r requirements.txt`

### Python Database Connecton 
1. Navigate to `__init__.py` file 
2. Review or adjust the following configuration (for RDS use) : 

    ```python
    # Database settings 
    dbName = 'user_management'
    DB_ENDPOINT = os.environ.get('DB_ENDPOINT') or None
    DB_USERNAME = os.environ.get('DB_USERNAME') or None
    DB_PASSWORD = os.environ.get('DB_PASSWORD') or None
    if DB_ENDPOINT and DB_USERNAME and DB_PASSWORD:
        # Production - Use MySQL
        DB_PORT = '3306'
        DB_NAME = dbName
        dbString = f'mysql+pymysql://{DB_USERNAME}:{DB_PASSWORD}@{DB_ENDPOINT}:{DB_PORT}'
        dbURI =  dbString + '/' + dbName
        backupURI = None  # MySQL backup would require a different approach
    else:
        # Development - Use SQLite
        dbString = 'sqlite:///volumes/'
        dbURI = dbString + dbName + '.db'
        backupURI = dbString + dbName + '_bak.db'
    ```

#### RDS vs SQLite connection

By default, the developer will use an SQLite connection for adjusting and managing schema.  The RDS (production) schema is only activated by defining DB environment variables.

Create a `.env` in your project directory with environment variables as shown to activate production database.

```shell
# Sample Database configuration, REPLACE with VALID strings
DB_ENDPOINT='users-database.ckvjXXXXXXXX.us-west-2.rds.amazonaws.com'
DB_USERNAME='admin'
DB_PASSWORD='z7JgA8zUXXXXXXXX'
```

#### RDS migration

The `fask_2025` project contains `scripts` in python to enable the setup and migration of data.   These scripts can and will destroy data.

1. `scripts/db_init.py:`  used to create database schema and add couple of test records to the users tables.
2. `scripts/db_migrate.py`:  used to create database schema and migrate data from existing or previous instance.

### Adminstrator Notes 

Notes for database adminstrators.  

1. `Initializing schema is destructive`.  Great care should be taken to make sure schema initialization is reviewed.  When developing scripts for schema initialization make sure the come with warning and confirmation.

2. `Data migration requires business logic`.  Bulk uploading data into a system requires the information to pass through the buiness logic that is performed for CRUD through the  application.  It is near impossible to think that you can create appropriate data validation and relations through standard SQL.

