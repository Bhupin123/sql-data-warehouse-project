

/*
----------------------------------------------------------------------

DDL Scripts : Create silver layer
----------------------------------------------------------------------

Script Purpose:
  This scripts creates table in hter silver schemas dropping existing tables
If they already exists
RUn this scripts to re_deifne the ddl structure of bronze tables
*/





IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info (
	prd_id INT,
	cat_id NVARCHAR(50),
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
	);


INSERT INTO silver.crm_prd_info (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)

SELECT 
	prd_id,
	REPLACE(SUBSTRING(prd_key,1, 5 ), ' - ', '_') AS cat_id,  -- EXTRACT catgory ID
	SUBSTRING(prd_key, 7, LEN(prd_key)) as prd_key, -- EXTRATCT product key
	prd_nm,
	ISNULL(prd_cost, 0) AS prd_cost,
	CASE UPPER (TRIM(prd_line))
	WHEN 'M' THEN 'MOUNTAIN'
	WHEN 'R' THEN 'ROAD'
	WHEN 'O' THEN 'OTHER SALES'
	WHEN 'T' THEN 'TOURRING'
	ELSE 'n/a'
END as prd_line, -- MAP product line codes to descriptive values
	CAST (prd_start_dt as DATE) as prd_start_dt,
	CAST(LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 AS DATE) AS prd_end_dt -- calculate end dates as one day before the next start date
FROM bronze.crm_prd_info


WHERE prd_key IN('AC-HE-HL-U509-R', 'AC-HE-HL-U509')


WHERE SUBSTRING(prd_key, 7, LEN(prd_key)) IN (
SELECT sls_prd_key FROM bronze.crm_sales_details)

SELECT sls_prd_key FROM bronze.crm_sales_details

WHERE REPLACE(SUBSTRING(prd_key,1, 5 ), ' - ', '_') NOT IN
(SELECT DISTINCT id FROM bronze.erp_px_cat_g1v2)


-- CHECK FOR NULLS OR DUPLICATES IN PRIMARY KEY
-- EXPECTION: NO RESULT

SELECT DISTINCT id FROM bronze.erp_px_cat_g1v2

SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL


