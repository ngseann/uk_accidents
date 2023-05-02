-- CREATE SCHEMA accidents;

-- USE accidents;

/* -------------------------------- */

CREATE TABLE vehicle_types(
	Vehicle_Type INT, --PRIMARY KEY
    label VARCHAR(50)
);

CREATE TABLE accident(
    Accident_Index VARCHAR(13), --PRIMARY KEY 
    Location_Easting_OSGR INT, 
    Location_Northing_OSGR INT,
    Longitude DECIMAL,
    Latitude DECIMAL,
    Police_Force INT, 
    Accident_Severity INT, 
    Number_of_Vehicles INT,	
    Number_of_Casualties INT,
    Date_acc VARCHAR(11),
    Day_of_Week INT, 
    Time_acc VARCHAR(5), 
    Local_Authority_District INT,
    Local_Authority_Highway VARCHAR(9), 
    first_Road_Class INT, 
    first_Road_Number INT,
    Road_Type INT, 
    Speed_limit INT, 
    Junction_Detail INT, 
    Junction_Control INT, 
    second_Road_Class INT,	
    second_Road_Number INT, 
    Pedestrian_Crossing_Human_Control INT,
    Pedestrian_Crossing_Physical_Facilities INT,
    Light_Conditions INT,
    Weather_Conditions INT,
    Road_Surface_Conditions INT,
    Special_Conditions_at_Site INT,
    Carriageway_Hazards INT,
    Urban_or_Rural_Area INT,
    Did_Police_Officer_Attend_Scene_of_Accident INT,
    LSOA_of_Accident_Location VARCHAR(9)
);


/* First: for vehicle types, create new csv by extracting data from Vehicle Type sheet from Road-Accident-Safety-Data-Guide.xls */
CREATE TABLE vehicles(
    Accident_Index VARCHAR(13), --REFERENCES accident (Accident_Index) 
    Vehicle_Reference INT, 
    Vehicle_Type INT, --REFERENCES vehicle_types(Vehicle_Type) 
    Towing_and_Articulation INT,
    Vehicle_Manoeuvre INT, 
    Vehicle_Location_Restricted_Lane INT,
    Junction_Location INT,
    Skidding_and_Overturning INT,
    Hit_Object_in_Carriageway INT,
    Vehicle_Leaving_Carriageway INT,
    Hit_Object_off_Carriageway INT,
    Firstst_Point_of_Impact INT,
    Was_Vehicle_Left_Hand_Drive INT,
    Journey_Purpose_of_Driver INT,
    Sex_of_Driver INT,
    Age_of_Driver INT,
    Age_Band_of_Driver INT,
    Engine_Capacity_CC INT,
    Propulsion_Code INT,
    Age_of_Vehicle INT,
    Driver_IMD_Decile INT,
    Driver_Home_Area_Type INT,
    Vehicle_IMD_Decile INT
);

/* -------------------------------- */
/* Load Data */
COPY accident 
FROM 'C:/Users/seann/projs/uk_accidents/data/Accidents_2015.csv' 
DELIMITER ',' 
CSV HEADER;

COPY vehicles 
FROM 'C:/Users/seann/projs/uk_accidents/data/Vehicles_2015.csv' 
DELIMITER ',' 
CSV HEADER;


COPY vehicle_types 
FROM 'C:/Users/seann/projs/uk_accidents/data/vehicle_types.csv' 
DELIMITER ',' 
CSV HEADER;

/* -------------------------------- */

