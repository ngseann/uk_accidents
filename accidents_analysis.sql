/* max number of casualities and vehicles */
SELECT MAX(number_of_vehicles) AS max_vehicles, 
        MAX(number_of_casualties) AS max_casualities 
FROM accident;

/* looking at accident involving 37 vehicles
interestingly number of casualties isn't the max */
SELECT * FROM accident WHERE number_of_vehicles = 37;

/*  most common day of week
Saturday most common
interestingly, Sunday is pretty low in terms of number of accidents */
%sql SELECT day_of_week, COUNT(1) AS accident_count 
FROM accident 
GROUP BY day_of_week 
ORDER BY accident_count DESC;

/* most frequent times by hour */
WITH temp_hr AS 
    (SELECT *, EXTRACT(HOUR FROM to_timestamp(time_acc, 'HH24')) AS Hour FROM accident) 
    SELECT Hour, COUNT(1) AS Count 
FROM temp_hr 
GROUP BY Hour 
ORDER BY Count DESC;


/* Looking at vehicles_table */


/* average age of driver in accident */
SELECT AVG(age_of_driver) AS avg_age FROM vehicles;

/* looking at sums and normalized sums of the different types of accidents*/

SELECT SUM(skidding_and_overturning) AS sum_skidding_and_overturning, 
SUM(hit_object_in_carriageway) AS sum_hit_object_in_carriageway, 
SUM(vehicle_leaving_carriageway) AS sum_vehicle_leaving_carriageway, 
SUM(hit_object_off_carriageway) AS sum_hit_object_off_carriageway 
FROM vehicles;

WITH sums AS (SELECT (SUM(skidding_and_overturning)) AS sum_skidding_and_overturning, 
            SUM(hit_object_in_carriageway) AS sum_hit_object_in_carriageway, 
            SUM(vehicle_leaving_carriageway) AS sum_vehicle_leaving_carriageway, 
            SUM(hit_object_off_carriageway) AS sum_hit_object_off_carriageway, 
            (sum(skidding_and_overturning) + sum(hit_object_in_carriageway) + sum(vehicle_leaving_carriageway) + sum(hit_object_off_carriageway)) AS total 
            FROM vehicles) 
SELECT (CAST(sum_skidding_and_overturning AS float) / total) AS norm_skidding_and_overturning, 
        (CAST(sum_hit_object_in_carriageway AS float) / total) AS norm_hit_object_in_carriageway,  
        (CAST(sum_vehicle_leaving_carriageway AS float) / total) AS norm_vehicle_leaving_carriageway, 
        (CAST(sum_hit_object_off_carriageway AS float) / total) AS norm_hit_object_off_carriageway 
FROM sums;

/* average and median accident severity by vehicle type */
SELECT vt.Vehicle_type, vt.label, AVG(accident_severity) AS avg_severity,
PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY accident_severity) 
                AS median_severity
FROM vehicles AS v
INNER JOIN accident AS a
    ON v.Accident_Index = a.Accident_Index
INNER JOIN vehicle_types AS vt
    ON v.Vehicle_Type = vt.Vehicle_Type
GROUP BY vt.Vehicle_Type, vt.label
ORDER BY avg_severity;

/* average accident severity, median accident severity and total number of accidents of motorcyle types */
SELECT vt.Vehicle_type, vt.label, AVG(accident_severity) AS avg_severity, 
    PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY accident_severity) 
                AS median_severity,    
    COUNT(1) AS total_accidents
FROM vehicles AS v
INNER JOIN accident AS a
    ON v.Accident_Index = a.Accident_Index
INNER JOIN vehicle_types AS vt
    ON v.Vehicle_Type = vt.Vehicle_Type
WHERE vt.label LIKE '%motorcycle%'
    OR vt.label LIKE '%Motorcycle%'
GROUP BY vt.Vehicle_Type, vt.label
ORDER BY avg_severity ASC;

/* number of accidents by age band
1	0 - 5
2	6 - 10
3	11 - 15
4	16 - 20
5	21 - 25
6	26 - 35
7	36 - 45
8	46 - 55
9	56 - 65
10	66 - 75
11	Over 75
-1	Data missing or out of range */
SELECT v.Age_Band_of_Driver, COUNT(*) AS no_of_accidents 
FROM vehicles AS v
INNER JOIN accident AS a
    ON v.Accident_Index = a.Accident_Index
GROUP BY v.Age_Band_of_Driver
ORDER BY no_of_accidents DESC;