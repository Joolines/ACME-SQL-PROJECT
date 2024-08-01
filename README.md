# ACME-SQL-PROJECT


# **DOCUMENTATION OF SQL QUERIES AND EXPLANATION OF LOGICS USED**

## **Description of the database schema and tables used**

This database schema comprises of a table designed to store and manage smartphone data. The table in the schema contains columns that represent different properties of the data being stored. This table stores detailed information about various smartphone models.

 Below is a description of the table and it’s columns:
 
### **Table name : Smartphone_cleaned**

### **Columns:**

• **brand_name (varchar)** : The brand name of the smartphone.(e.g Apple, Samsung)

 • **model (varchar)**: The model name or number of the smartphone. 
 
• **price (int)**: The price of the smartphone in RUPEES. 

• **rating (float)**: The rating of the smartphone out of 100. 

• **has_5g (Bit)** : Indicates whether the smartphone supports 5G connectivity (TRUE/FALSE). 

• **has_nfc (Bit)**: Indicates whether the smartphone has NFC capability (TRUE/FALSE). 

• **has_ir_blaster (Bit)**: Indicates whether the smartphone has an IR blaster (TRUE/FALSE). 

• **processor_name (varchar)**: The name of the processor used in the smartphone. 

• **processor_brand (varchar)**: The brand of the processor used in the smartphone. 

• **num_cores (varchar)**: The number of cores in the processor. 

• **processor_speed (float)**: The speed of the processor in GHz. 

• **battery_capacity (int)**: The battery capacity of the smartphone in mAh. 

• **fast_charging (int)**: The fast-charging capability of the smartphone in watts. 

• **ram_capacity (int)**: The RAM capacity of the smartphone in GB. 

• **internal_memory (int)**: The internal storage capacity of the smartphone in GB. 

• **refresh_rate (int)**: The refresh rate of the smartphone display in Hz.

 • **resolution (int)**: The resolution of the smartphone display. 
 
• **num_rear_cameras (int)**: The number of rear cameras on the smartphone.

 • **num_front_cameras (int)**: The number of front cameras on the smartphone. 
 
•**os (varchar)**: The operating system used in the smartphone. 

**primary_camera_rear (varchar)**: The resolution of the primary rear camera in megapixels.

 • **primary_camera_front (varchar)**: The resolution of the primary front camera in megapixels.
 
 • **extended_memory (bit)**: The capacity of extended memory (e.g., microSD card support) in the smartphone, if applicable

# **Explanation of SQL query logic and any data transformations performed**

1.	## **Data cleaning**
   
**a) A copy of the table was made and named “smartphone_cleaned_v2” to avoid tampering with the original table, it was done using the query below :**

	Select *
	into Smartphone_cleaned_v2
	from smartphone_cleaned_v2;


**b) A check was conducted to get rid of duplicates**

	With SmartPhoneCTE AS (
	Select *,
	ROW_NUMBER() OVER(
	PARTITION BY model
	ORDER BY 
	brand_name) row_num
	from Smartphone_cleaned_v2 
	)
	SELECT *
	from SmartPhoneCTE
	where row_num > 1

The dataset contained no duplicate 

The nulls were taken care of by removing the nulls contained in every column. 

**NOTE:**  This is a self-decided way of dealing with the nulls


**c) Checking for and deletion of nulls**

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
     
2) ## **DATA MANIPULTION**
   
data manipulation operations such as filtering, sorting, and aggregating using SQL functions and clauses.

**Filtering**

To perform the Filtering operation, the WHERE function was used

	SELECT brand_name, model, rating
	FROM  smartphone_cleaned_v2
	WHERE brand_name = 'oppo';

**Sorting**

Sorting was performed using the ORDER BY function

	SELECT brand_name, model, rating
	FROM  smartphone_cleaned_v2
	WHERE brand_name = 'oppo' 
	ORDER BY rating DESC;

**Aggregate function**

Several aggregate functions were performed to help prepare the data for data analysis to generate key insights

i)	 Using aggregate function, the average rating of each phone brand and sum of by sum of price
	
	SELECT TOP 10 brand_name, AVG (rating) AS avg_rating,  SUM (price)  AS sum_price
	FROM  smartphone_cleaned_v2
	GROUP BY brand_name
	ORDER BY sum_price DESC;


ii) Counting the number of observations for each brand_name to ensure a fair comparison in futher analysis when needed

	SELECT brand_name, COUNT (brand_name) AS count_of_brand
	FROM smartphone_cleaned_v2
	GROUP BY brand_name
	ORDER BY count_of_brand DESC

iii) Caulating the average battery capacity based on the number of cores

	SELECT  num_cores, AVG (battery_capacity) AS Average_battery_capacity
	FROM smartphone_cleaned_v2
	GROUP BY num_cores
	ORDER BY Average_battery_capacity DESC

3) ## **DATA ANALYSIS**

**a) The  top 5 phone brands with the fastest charging rate**

	SELECT TOP 5 brand_name, MAX(fast_charging) as fastest_charging_brand
	FROM smartphone_cleaned_v2
	GROUP BY brand_name
	ORDER BY fastest_charging_brand DESC;


**b) The top brands with battery capacity greater than '5500' and has fast charging < '200'**

	SELECT brand_name, COUNT (battery_capacity) AS count_of_brands
	FROM smartphone_cleaned_v2
	WHERE fast_charging < 200 and battery_capacity > 5500
	GROUP BY brand_name
	ORDER BY count_of_brands DESC;


**c) The  smartphones with a refresh rate of at least 120 Hz and a ram capacity of 8 GB or more.**

	Select brand_name, model, refresh_rate, ram_capacity
	From smartphone_cleaned_v2
	Where refresh_rate >= 120 AND ram_capacity >= 8;

Select – Allows you select the columns to return

From – specifies the database and table to generate the result from.

Where – filters the data to return from the database. In the above query, the mobile phones with refresh rate greater than or equal to. 120 and ream 		greater than or equal to 8

Group by – groups the brand uniquely.

