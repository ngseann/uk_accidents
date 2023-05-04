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
SELECT AVG(age_of_driver) FROM vehicles;

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