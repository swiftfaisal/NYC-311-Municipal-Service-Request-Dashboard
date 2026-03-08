# NYC-311-Municipal-Service-Request-Dashboard

## Project Title / Headline
NYC 311 Municipal Service Request Analysis: Performance & Geographic Service Equity
## Short Description / Purpose
This project analyzes NYC 311 municipal service request data to evaluate operational performance across boroughs. The analysis focuses on identifying service demand patterns, response time efficiency, and geographic disparities in service delivery. By transforming raw municipal request data into structured insights, the project highlights areas where operational efficiency and resource allocation can be improved.
## Tech Stack
SQL – Data querying, aggregation, and KPI calculations
Excel / Power Query – Data cleaning, transformation, and preprocessing
Excel Dashboard (Pivot Tables & Charts) – Interactive visualization and KPI tracking
Data Analysis Techniques – Aggregations, trend analysis, performance metrics, and comparative analysis
Data Source
## Dataset: NYC 311 Service Requests Dataset
The dataset contains municipal service requests submitted by residents across New York City. Each record represents a service complaint including request type, location, and resolution details.
Key attributes include:
Complaint Type
Borough
Request Created Date
Resolution Date
Service Request Status
Agency Responsible
Dataset Size: 500,000+ service request records
Source: NYC Open Data (Public municipal dataset) from Kaggle.
# Features / Highlights
## Business Problem
1. Municipal agencies receive thousands of service requests daily. However, without structured analysis it is difficult to determine:
2. Which complaint types dominate service demand
3. Whether response time performance varies across boroughs
4. Where operational inefficiencies or service delays occur
5. Understanding these patterns is essential for efficient resource allocation and improved service delivery.
## Goal of the Dashboard
The goal of the dashboard is to provide a data-driven overview of municipal service performance, helping stakeholders:
1. Monitor service request volumes
2. Evaluate response time efficiency
3. Compare service performance across boroughs
4. Identify high-demand complaint categories
5. Detect potential service delivery gaps
# Walkthrough of Key Visuals
## 1️. KPI Overview Section
Displays key service performance metrics including:
Total Service Requests
Average Response Time
Total Closed Requests
Complaint Volume Distribution
This section provides a quick overview of overall service activity.
## 2️. Complaint Type Analysis
A visual breakdown of the most common complaint categories received across the city.
This helps identify areas where municipal resources are most heavily demanded.
## 3️. Borough-Level Performance Comparison
Compares service request volumes and response times across NYC boroughs to highlight geographic disparities in service delivery performance.
## 4️.Service Request Trend Analysis
Analyzes how service requests change over time, helping detect periods of increased service demand or operational pressure.
## Business Impact & Key Insights
The analysis reveals several operational insights:
Certain complaint categories account for a large share of total service requests, indicating priority areas for service improvement.
Service response times vary across boroughs, suggesting potential resource allocation imbalances.
Monitoring request trends allows agencies to anticipate periods of high service demand.
# Business Questions Solved Using SQL
The analysis used SQL queries to answer key operational questions related to municipal service performance and service demand patterns.
## 1️. What are the most common complaint types in NYC?
Purpose:
Identify the complaint categories generating the highest service demand so agencies can prioritize operational resources.
SQL analysis performed:
Counted total service requests by complaint type
Ranked complaint categories based on request volume
Insight:
A small number of complaint types contribute to a large share of service requests, indicating priority areas for service improvement.
## 2️. Which borough receives the highest number of service requests?
Purpose:
Understand geographic distribution of service demand across NYC boroughs.
SQL analysis performed:
Aggregated service requests by borough
Compared total request volumes across boroughs
Insight:
Some boroughs consistently generate higher complaint volumes, which may require increased operational capacity.
## 3️. Which complaint types dominate within each borough?
Purpose:
Determine the most frequent complaint types within each borough to identify location-specific service issues.
SQL analysis performed:
Grouped data by borough and complaint type
Used SQL window functions (ROW_NUMBER, RANK, DENSE_RANK) to rank complaints within each borough
Insight:
Different boroughs exhibit distinct complaint patterns, highlighting localized service challenges.
## 4️. What percentage of service requests are successfully closed?
Purpose:
Measure overall service resolution performance.
SQL analysis performed:
Calculated closed vs open request counts
Derived service closure rate KPI
Insight:
High closure rates indicate efficient service resolution processes.
## 5️. What is the average response time for service requests?
Purpose:
Evaluate how quickly municipal agencies respond to citizen complaints.
SQL analysis performed:
Calculated time difference between request creation and resolution
Computed average response time across the dataset
Insight:
Response time metrics help identify operational efficiency and potential service delays.
## 6️. How does response time vary across boroughs?
Purpose:
Identify whether certain boroughs experience slower service response times.
SQL analysis performed:
Computed average response time by borough
Compared performance across locations
Insight:
Response time disparities may indicate unequal resource allocation across boroughs.
## 7️. How do service requests vary over time?
Purpose:
Understand temporal trends in service demand.
SQL analysis performed:
Aggregated request counts by month
Analyzed request trend patterns
Insight:
Tracking request trends helps anticipate periods of increased service demand.
## 8️. Which complaint types have the longest resolution times?
Purpose:
Identify service categories that require longer resolution times.
SQL analysis performed:
Calculated average resolution time by complaint type
Ranked complaint types based on resolution duration
Insight:
Some service categories require longer operational processing time.
## 9️. What are the top complaint categories by borough?
Purpose:
Detect borough-specific service demand patterns.
SQL analysis performed:
Aggregated complaint counts by borough and complaint type
Ranked complaints using SQL window functions
Insight:
Understanding local complaint patterns helps agencies design targeted service strategies.
