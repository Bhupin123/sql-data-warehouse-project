



/*

Quality Checks

Scripts purpose:
This scripts perfomrs various qualtiy checks for data consistency, accuracy,
and standardixation across the silver schemas. It includes checks for:
-NUll or duplicate primary keys.
- data standardization and consistency.
- invalid date ranges and orders.
- datag consistency between related fields.

Usage Notes:
- Run these checks after data loading silver layer.
- investigate and resolve any discrepancies found during the checks
*/


-- QUALITY Checks
-- CHECKS FOR NULL OR DUPLICATES IN PRIMARY KEY
-- EXPECTION : NO RESULT
SELECT prd_id,COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- CHECKS FOR UNWANTED SPACES
-- EXPECTION : NO RESULT

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)


-- Checks for NULLS or Negative Numers
-- Expectation No results

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 or prd_cost IS NULL

-- DATA STANDARDIZATION & CONSISTENCY

SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- CHECKS FOR INVALID DATE ORDERS

SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT *
FROM silver.crm_prd_info




-- CHECKS FOR INVALID DATE

SELECT
NULLIF (sls_due_dt, 0) sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
OR LEN(sls_due_dt) != 8 
OR sls_due_dt > 20500101 
OR sls_due_dt < 19000101


-- CHECKS FOR INVALID DATE ORDERS

SELECT *
FROM bronze.crm_sales_details
WHERE  sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


--- CHECKS DATA CONSISTENCY : BETWEEN SALES QUANTITY AND PRICE
-- SALES = QUANTY * PRICE
-- VALUES MUST BE NOT NULL, ZERO, OR NEGATIVE

SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price as old_sls_price,

case when sls_sales IS NULL OR  sls_sales <= 0 OR sls_sales!= sls_quantity * ABS(sls_price)
THEN sls_quantity * ABS(sls_price)
ELSE sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <=0 
THEN sls_sales / NULLIF (sls_quantity,0)
ELSE sls_price
END as sls_price

FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
OR sls_sales IS NOT NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0

ORDER BY sls_sales,sls_quantity,sls_price


-- DATA STANDARIZATION & CONSISSTENCY
SELECT DISTINCT  cntry
FROM silver.erp_loc_a101
ORDER BY cntry


-- CHECK FOR NULLS OR DUPLICATES IN PRIMARY KEY
-- EXPECTION: NO RESULT

SELECT DISTINCT id FROM bronze.erp_px_cat_g1v2

SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL
