/*
Project: Uber Demand-Supply Analysis

Objective:
- Identify demand-supply gaps
- Improve trip success rate
- Highlight revenue leakage areas
- Analyze driver utilization

Dataset: Uber ride request data
Author: Bhavesh
*/

CREATE TABLE IF NOT EXISTS Uber (
	request_id INT PRIMARY KEY,
	pickup_point VARCHAR(20),
	driver_id INT,
	request_date DATE,
	request_time TIME,
	drop_date DATE,
	drop_time TIME,
	status VARCHAR(50),
	request_day VARCHAR(20),
	hour INT,
	Trip_completed INT
);

-- Quick sanity check: total records
SELECT COUNT(*) AS total_records FROM uber;

SELECT request_day, COUNT(request_id) AS "No_of_requests"
FROM Uber
GROUP BY request_day
ORDER BY "No_of_requests" DESC;

SELECT pickup_point,COUNT(*) AS "requests"
FROM Uber
GROUP BY pickup_point;

SELECT pickup_point,COUNT(*) AS "requests cancelled"
FROM Uber
WHERE status = 'Cancelled'
GROUP BY pickup_point;

SELECT pickup_point,COUNT(*) AS "No_cars"
FROM Uber
WHERE status = 'No Cars Available'
GROUP BY pickup_point;
--------------------------------------------------------------

-------- 1.Overall Trip Success Rate -------------------------

SELECT 
    COUNT(*) AS total_requests,
    SUM(CASE WHEN Status = 'Trip Completed' THEN 1 ELSE 0 END) AS completed_trips,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 'Trip Completed' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS success_rate
FROM Uber;

-------- 2.Demand–Supply Gap (Unfulfilled Trips) -------------

SELECT 
    Status,
    COUNT(*) AS total_requests
FROM Uber
GROUP BY Status;

------ 3.Hourly demand vs supply to identify peak revenue leakage periods 
SELECT
    hour,
    COUNT(*) AS total_requests,
    SUM(CASE WHEN status = 'Trip Completed' THEN 1 ELSE 0 END) AS completed_trips,
    COUNT(*) - SUM(CASE WHEN status = 'Trip Completed' THEN 1 ELSE 0 END) AS unmet_demand
FROM uber
GROUP BY hour
ORDER BY unmet_demand DESC;

--------- 4.Day-Wise Success Rate------------------------------

SELECT
    request_day,
    COUNT(*) AS total_requests,
    SUM(Trip_completed) AS completed_trips,
    ROUND(100.0 * SUM(Trip_completed) / COUNT(*), 2) AS success_rate
FROM Uber
GROUP BY request_day
ORDER BY success_rate;

--------- 5.Pickup Point Demand–Supply Gap---------------------

SELECT
    Pickup_point,
    COUNT(*) AS total_requests,
    SUM(Trip_completed) AS completed_trips,
    COUNT(*) - SUM(Trip_completed) AS unmet_demand
FROM Uber
GROUP BY Pickup_point;

----------- 6.Hour + Pickup Point Demand & Supply--------------

SELECT
    Pickup_point,
    Hour,
    COUNT(*) AS total_requests,
    SUM(Trip_completed) AS completed_trips,
    COUNT(*) - SUM(Trip_completed) AS unmet_demand
FROM Uber
GROUP BY Pickup_point, Hour
ORDER BY unmet_demand DESC;

----------- 7.Trips per Driver---------------------------------

SELECT
    Driver_id,
    COUNT(*) AS total_trips
FROM Uber
WHERE Status = 'Trip Completed'
GROUP BY Driver_id
ORDER BY total_trips DESC;

----- 8.Which hours lose the most revenue due to unmet demand? -----

WITH hourly_stats AS (
    SELECT
        Hour,
        COUNT(*) AS total_requests,
        SUM(Trip_completed) AS completed_trips,
        COUNT(*) - SUM(Trip_completed) AS unmet_demand
    FROM Uber
    GROUP BY Hour
)
SELECT
    Hour,
    total_requests,
    completed_trips,
    unmet_demand,
    RANK() OVER (ORDER BY unmet_demand DESC) AS demand_gap_rank
FROM hourly_stats
ORDER BY demand_gap_rank;

---- 9.Which pickup point and hour contribute most to overall demand–supply gap?
WITH location_hour_gap AS (
    SELECT
        Pickup_point,
        Hour,
        COUNT(*) - SUM(Trip_completed) AS unmet_demand
    FROM Uber
    GROUP BY Pickup_point, Hour
)
SELECT
    Pickup_point,
    Hour,
    unmet_demand,
    ROUND(
        100.0 * unmet_demand / SUM(unmet_demand) OVER (),
        2
    ) AS pct_of_total_unmet_demand
FROM location_hour_gap
ORDER BY pct_of_total_unmet_demand DESC;

----- 10.Are a few drivers handling most completed trips? --------
WITH driver_trips AS (
    SELECT
        Driver_id,
        COUNT(*) AS completed_trips
    FROM Uber
    WHERE Status = 'Trip Completed'
    GROUP BY Driver_id
)
SELECT
    Driver_id,
    completed_trips,
    ROW_NUMBER() OVER (ORDER BY completed_trips DESC) AS driver_rank,
    SUM(completed_trips) OVER (
        ORDER BY completed_trips DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_trips
FROM driver_trips;
