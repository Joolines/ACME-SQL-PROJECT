-- Delete all rows with any null values in any column
DELETE FROM smartphone.dbo.smartphone_cleaned_v2
WHERE 
    brand_name IS NULL OR
    model IS NULL OR
    price IS NULL OR
    rating IS NULL OR
    has_5g IS NULL OR
    has_nfc IS NULL OR
    has_ir_blaster IS NULL OR
    processor_name IS NULL OR
    processor_brand IS NULL OR
    num_cores IS NULL OR
    processor_speed IS NULL OR
    battery_capacity IS NULL OR
    fast_charging IS NULL OR
    ram_capacity IS NULL OR
    internal_memory IS NULL OR
    refresh_rate IS NULL OR
    resolution IS NULL OR
    num_rear_cameras IS NULL OR
    num_front_cameras IS NULL OR
    os IS NULL OR
    primary_camera_rear IS NULL OR
    primary_camera_front IS NULL OR
    extended_memory IS NULL;


-- To check for duplicates, re run the query

	With SmartPhoneduplicate AS (
Select *,
ROW_NUMBER() OVER(
	PARTITION BY model
	ORDER BY 
	brand_name) row_num
from smartphone_cleaned_v2
)
SELECT *
from SmartPhoneduplicate
where row_num > 1;

--Data analysis

--data manipulation operations such as filtering, sorting, and aggregating using SQL functions and clauses.

--Filtering using the WHERE function

SELECT brand_name, model, rating
FROM  smartphone_cleaned_v2
WHERE brand_name = 'oppo';


--Sorting using ORDER BY function

SELECT brand_name, model, rating
FROM  smartphone_cleaned_v2
WHERE brand_name = 'oppo' 
ORDER BY rating DESC;


--Performing Aggretate using SUM and AVERAGE function

SELECT TOP 10 brand_name, AVG (rating) AS avg_rating,  SUM (price)  AS sum_price
FROM  smartphone_cleaned_v2
GROUP BY brand_name
ORDER BY avg_rating DESC


-- Using aggregate function, the average rating of each phone brand and sum of by sum of price

SELECT TOP 10 brand_name, AVG (rating) AS avg_rating,  SUM (price)  AS sum_price
FROM  smartphone_cleaned_v2
GROUP BY brand_name
ORDER BY sum_price DESC;


-- counting the number of observations for each brand_name to ensure a fair comparison in futher analysis when needed
SELECT brand_name, COUNT (brand_name) AS count_of_brand
FROM smartphone_cleaned_v2
GROUP BY brand_name
ORDER BY count_of_brand DESC



--caulating the average battery capacity based on the number of cores
SELECT  num_cores, AVG (battery_capacity) AS Average_battery_capacity
FROM smartphone_cleaned_v2
GROUP BY num_cores
ORDER BY Average_battery_capacity DESC


-- Questions answered using this data are

--Checking to see the top 5 brands with the fastest charging rate
SELECT TOP 5 brand_name, MAX(fast_charging) as fastest_charging_brand
FROM smartphone_cleaned_v2
GROUP BY brand_name
ORDER BY fastest_charging_brand DESC;


--Checking for brands with battery capacity greater than '5500' and has fast charging < '200'

SELECT brand_name, COUNT (battery_capacity) AS count_of_brands
FROM smartphone_cleaned_v2
WHERE fast_charging < 200 and battery_capacity > 5500
GROUP BY brand_name
ORDER BY count_of_brands DESC;


--Find smartphones with a refresh rate of at least 120 Hz and a ram capacity of 8 GB or more.

Select brand_name, model, refresh_rate, ram_capacity
From smartphone_cleaned_v2
Where refresh_rate >= 120 AND ram_capacity >= 8;