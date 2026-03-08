create database nyc;
use nyc;
CREATE TABLE service_requests (
   Agency_Name VARCHAR(100),
    unique_key BIGINT,
    Request_Day_of_Week VARCHAR(15),
    Closed_date DATE,
    Agency VARCHAR(50),
    Problem_Complaint_Type VARCHAR(100),
    Borough VARCHAR(50),
    Incident_Zip VARCHAR(20),
    Status VARCHAR(20),
    Request_month VARCHAR(15),
    Is_Closed varchar(10),
    Response_Days int,
    Day_Name varchar(20)
    );
    
    alter table service_requests modify Response_Days int null;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.5/Uploads/NYC_311_2025_Cleaned.csv'
INTO TABLE service_requests
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Agency_Name, unique_key, Request_Day_of_Week, @Closed_date, Agency, Problem_Complaint_Type, Borough, Incident_Zip, Status, Request_month, Is_Closed, @Response_Days, Day_Name)
SET 
    Closed_date = IF(@Closed_date = '', NULL, STR_TO_DATE(@Closed_date, '%m/%d/%Y')),
    Response_Days = IF(@Response_Days = '', NULL, @Response_Days);
    
 ALTER TABLE service_requests
MODIFY Closed_date DATE NULL,
MODIFY Response_Days INT NULL;
    
SELECT COUNT(*) FROM service_requests;
SELECT * FROM service_requests WHERE Closed_date IS NULL OR Response_Days IS NULL LIMIT 10;


-- Queries for Pivot Tables

-- Query 1: Key metrics
-- Total requests, closed/open counts, % closed, avg response days, first & last requests
SELECT
    COUNT(*) AS total_requests,
    COUNT(CASE WHEN Is_Closed = 'Yes' THEN 1 END) AS closed_requests,
    COUNT(CASE WHEN Is_Closed = 'No' THEN 1 END) AS open_requests,
    ROUND(COUNT(CASE WHEN Is_Closed = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_closed,
    ROUND(AVG(CASE WHEN Is_Closed = 'Yes' THEN Response_Days END), 2) AS avg_response_days,
    MIN(Closed_date) AS first_request,
    MAX(Closed_date) AS last_request
FROM service_requests;

-- Query 2: Top 5 complaint types
SELECT Problem_Complaint_Type,
       COUNT(*) AS total_requests
FROM service_requests
GROUP BY Problem_Complaint_Type
ORDER BY total_requests DESC
LIMIT 5;

-- Query 3: Complaints by borough (% of total)
SELECT Borough,
       COUNT(*) AS total_requests,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM service_requests), 2) AS pct_of_total
FROM service_requests
GROUP BY Borough
ORDER BY total_requests DESC;

-- Query 4: Monthly trend
-- Requests per month in calendar order
SELECT 
    MONTHNAME(Closed_Date) AS Month,
    COUNT(*) AS Total_Closed_Requests
FROM service_requests
WHERE Is_closed = 'Yes'
GROUP BY MONTH(Closed_Date), MONTHNAME(Closed_Date)
ORDER BY MONTH(Closed_Date);

-- Query 5: Avg response time by complaint type (top 10 slowest)
SELECT Problem_Complaint_Type,
       COUNT(*) AS total_requests,
       ROUND(AVG(Response_Days), 2) AS avg_response_days
FROM service_requests
WHERE Is_Closed = 'Yes'
GROUP BY Problem_Complaint_Type
ORDER BY avg_response_days DESC
LIMIT 10;

-- Query 6: Borough performance
-- Avg response days and closure rate
SELECT 
    IF(Borough IS NULL OR Borough = '', 'Unknown', Borough) AS Borough,
    COUNT(*) AS total_requests,
    ROUND(AVG(CASE WHEN Is_Closed = 'Yes' THEN Response_Days END), 2) AS avg_response_days,
    ROUND(COUNT(CASE WHEN Is_Closed = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_closed
FROM service_requests
GROUP BY Borough
ORDER BY avg_response_days DESC;

-- Query 7: Agency workload & efficiency
-- Agencies with significant workload (>1000 requests)
SELECT Agency,
       COUNT(*) AS total_requests,
       COUNT(CASE WHEN Is_Closed = 'Yes' THEN 1 END) AS closed_requests,
       ROUND(COUNT(CASE WHEN Is_Closed = 'Yes' THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_closed,
       ROUND(AVG(CASE WHEN Is_Closed = 'Yes' THEN Response_Days END), 2) AS avg_response_days
FROM service_requests
GROUP BY Agency
HAVING total_requests > 1000
ORDER BY avg_response_days DESC;

-- Query 8: High-volume, slow response
-- Identify Borough + complaint type combinations that are slow & frequent
SELECT Borough,
       Problem_Complaint_Type,
       COUNT(*) AS total_requests,
       ROUND(AVG(Response_Days), 2) AS avg_response_days
FROM service_requests
WHERE Is_Closed = 'Yes'
GROUP BY Borough, Problem_Complaint_Type
HAVING total_requests > 100 AND AVG(Response_Days) > 10
ORDER BY avg_response_days DESC;

-- Query 9: Backlog risk by agency
-- Agencies with more than 5% open requests
SELECT Agency,
       COUNT(*) AS total_requests,
       COUNT(CASE WHEN Is_Closed = 'No' THEN 1 END) AS open_requests,
       ROUND(COUNT(CASE WHEN Is_Closed = 'No' THEN 1 END) * 100.0 / COUNT(*), 2) AS pct_open
FROM service_requests
GROUP BY Agency
HAVING pct_open > 5
ORDER BY pct_open DESC;

-- Query 10 Month over month change 
SELECT 
    month_number,
    month_name,
    total_requests,
    LAG(total_requests) OVER (ORDER BY month_number) AS previous_month_requests,
    total_requests - LAG(total_requests) OVER (ORDER BY month_number) AS month_over_month_change
FROM (
    SELECT 
        MONTH(Closed_Date) AS month_number,
        MONTHNAME(Closed_Date) AS month_name,
        COUNT(*) AS total_requests
    FROM service_requests
    WHERE is_closed = 'Yes'
    GROUP BY MONTH(Closed_Date), MONTHNAME(Closed_Date)
) AS monthly_data
ORDER BY month_number;

-- Query 11 Borough level complaint ranking
SELECT 
    borough,
    problem_complaint_type,
    COUNT(*) AS total_requests,

    ROW_NUMBER() OVER (
        PARTITION BY borough
        ORDER BY COUNT(*) DESC
    ) AS row_number_rank,

    RANK() OVER (
        PARTITION BY borough
        ORDER BY COUNT(*) DESC
    ) AS rank_value,

    DENSE_RANK() OVER (
        PARTITION BY borough
        ORDER BY COUNT(*) DESC
    ) AS dense_rank_value

FROM service_requests
WHERE is_closed = 'Yes'
AND borough IS NOT NULL
AND borough <> ''
GROUP BY borough, problem_complaint_type;

