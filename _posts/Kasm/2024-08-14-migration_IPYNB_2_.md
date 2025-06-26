---
layout: post
title: Migration Scripts
permalink: /kasm/database/migration
menu: nav/kasm_cloud.html
categories: ['Kasm']
author: Tanisha Patil
toc: True
comments: True
---

# Database Migration Scripts 

Every time the database schema is updated, a data migration is required.  

This documentation provides details on the two primary scripts used for updating schema and migrating data.  Data migration is particulary important for the RDS data as it contains data that is considered production, it should not be lost.

The `db_init.py` and `db_migrate.py` scripts have roles in development and productions.  They are designed to initialize the database schema and setup data.   The init script is focused on developers and their desire to quickly change.   The migrate script pulls data from the old database to a new one (with new schema).

---

## `db_init.py`

### Description
The `db_init.py` script is responsible for initializing the database schema. It performs the following steps:

1. **Warning the User:** Alerts the user about potential data loss.
2. **Database Backup:** Backs up the current database to a specified location.
3. **Schema Initialization:** Drops any existing tables and creates new ones based on the defined schema.
4. **Data Loading:** Adds default test data to the newly created tables.

### Usage

Run the script from the terminal :

```bash
cd scripts; ./db_init.py
```
### Functions

- backup_database(db_uri, backup_uri)
     - Backs up the current database to the specified backup location.
     - Supports SQLite and other production databases
- main()
      - Main function that coordinates the schema initialization process.
      - Drops existing tables, creates new ones, and loads test data.


### Important Notes
- The script will drop all existing tables, resulting in data loss. Ensure you consider backup needs before running this script.

## `db_migrate.py`

### Description
The db_migrate.py script is responsible for migrating data from an old database to a new one. It follows these steps:

1. Warning the User: Alerts the user about potential data loss.
2. Database Backup: Backs up the current database to a specified location.
3. Schema Initialization: Drops existing tables and creates new ones based on the defined schema.
4. Data Migration: Authenticates with the old database, extracts data, and loads it into the new database.

### Usage
Run the script from the terminal :

```bash
cd scripts; ./db_migrate.py
```

### Functions

`backup_database(db_uri, backup_uri, db_string)`
- Backs up the current database to the specified location.
- Supports both MySQL and SQLite databases.

`create_database(engine, db_name)`
- Creates the database if it does not exist.
authenticate(uid, password)
- Authenticates with the old database and returns an authentication token.

`extract_data(cookies)`
- Extracts data from the old database using the provided authentication token.

`write_data_to_json(data, json_file)`
- Writes extracted data to a JSON file, with a backup if the file already exists.

`read_data_from_json(json_file)`
- Reads data from a JSON file.

`main()`
- Main function that coordinates the entire migration process.
- Authenticates with the old database, extracts data, and loads it into the new database.

### Important Notes
- The script provides fallback mechanisms. If authentication with the old database fails, it uses a local JSON file to load data.
- The script supports MySQL and SQLite for database backup and restoration.
