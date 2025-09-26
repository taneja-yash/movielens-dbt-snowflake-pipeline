# Movielens Data Engineering Project | Snowflake, DBT, AWS

## Project Overview
This project demonstrates end-to-end data engineering skills by designing, building, and managing a cloud-based data warehouse pipeline. The focus is on transforming raw datasets into structured, analytics-ready data models using modern tools and best practices.

## Key objectives:
- Build a scalable and maintainable data warehouse
- Implement ETL/ELT pipelines for structured data transformation
- Ensure data quality and integrity through testing and documentation
- Enable efficient reporting and analytics

## Architecture & Workflow
The workflow follows a modern data engineering pipeline:
### 1. Data Ingestion:
- Raw dataset files loaded to an AWS S3 bucket.
- Snowflake stage created to access S3 data.

### 2. Data Warehouse Setup:
- Created Snowflake warehouse, database, schema, role, and user.
- Assigned permissions to roles for secure access.

### 3. Data Modeling:
- Raw data loaded into RAW schema tables.
- Data views created for staging purposes.
- Data duplicated into DEV schema for development.
- Created dimension tables in DEV schema.
- Implemented incremental fact table (ratings) for efficient updates.
- Built ephemeral dimension table (movies with tags).

### 4. DBT Integration:
- Connected local environment to Snowflake using DBT.
- Created sources.yml and schema.yml for table documentation.
- Performed data quality testing: not_null, unique, relationships.
- Created snapshots and macros for advanced transformations.
- Generated automatic documentation using DBT.

### 5. Data Analysis

## Technologies & Tools
### Data Warehouse
- Snowflake

### ETL/ELT & Transformations
- DBT
- SQL

### Cloud Storage
- AWS S3

### Data Analysis
- SQL

## Key Skills Demonstrated
- Cloud-based data warehouse design and management
- ETL/ELT pipeline creation and optimization
- Data modeling (fact and dimension tables, incremental & ephemeral tables)
- Data quality testing and documentation
- SQL for querying, transformations, and analytics
- DBT for version control, testing, and documentation

## Author
Yash Taneja
- Master of Science in Business Analytics, University of Texas at Dallas
- [LinkedIn](https://linkedin.com/in/yash-taneja-07) | [GitHub](https://github.com/taneja-yash)
