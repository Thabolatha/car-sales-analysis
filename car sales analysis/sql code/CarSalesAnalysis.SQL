SELECT 
  *
FROM
  "CARS"."PUBLIC"."DEALERSHIP"
LIMIT
  10;

SHOW COLUMNS IN TABLE "CARS"."PUBLIC"."DEALERSHIP";
---------------------------------------------------------------------------------------------------------------------------------
  --Revenue by Car Make & Model body
SELECT
    state,
    body,
    COUNT(*) AS total_cars_sold,
    SUM(sellingprice) AS total_revenue,
    ROUND(AVG(sellingprice), 2) AS avg_selling_price
FROM "CARS"."PUBLIC"."DEALERSHIP"
GROUP BY state,body
ORDER BY total_cars_sold DESC;

--average selling price trend over time monthly
SELECT
    TO_VARCHAR(DATE_TRUNC('month', TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS')), 'YYYY-MM') AS sale_month,
    ROUND(AVG(sellingprice), 2) AS avg_selling_price
FROM "CARS"."PUBLIC"."DEALERSHIP"
GROUP BY DATE_TRUNC('month', TO_TIMESTAMP(saledate, 'DY MON DD YYYY HH24:MI:SS'))
ORDER BY sale_month;


--Sales Distribution by Year 
SELECT 
    YEAR,
    BODY,
    COUNT(*) AS cars_sold,
    SUM(SELLINGPRICE) AS total_revenue
FROM "CARS"."PUBLIC"."DEALERSHIP"
GROUP BY YEAR, BODY
ORDER BY YEAR, cars_sold DESC;


SELECT 
    CASE 
        WHEN ((SELLINGPRICE - MMR) / MMR * 100) < 0 THEN 'Loss'
        WHEN ((SELLINGPRICE - MMR) / MMR * 100) BETWEEN 0 AND 10 THEN 'Low Margin (0-10%)'
        WHEN ((SELLINGPRICE - MMR) / MMR * 100) BETWEEN 10 AND 20 THEN 'Medium Margin (10-20%)'
        WHEN ((SELLINGPRICE - MMR) / MMR * 100) > 20 THEN 'High Margin (>20%)'
        ELSE 'Unknown'
    END AS margin_tier,
    COUNT(*) AS cars_sold,
    ROUND(AVG((SELLINGPRICE - MMR) / MMR * 100), 2) AS avg_margin
FROM "CARS"."PUBLIC"."DEALERSHIP"
WHERE MMR IS NOT NULL AND SELLINGPRICE IS NOT NULL
GROUP BY margin_tier
ORDER BY avg_margin DESC;



-- Regional Sales Performance
SELECT 
    STATE,
    COUNT(*) AS total_cars_sold,
    SUM(SELLINGPRICE) AS total_revenue,
    ROUND(AVG(SELLINGPRICE), 2) AS avg_selling_price
FROM "CARS"."PUBLIC"."DEALERSHIP"
WHERE SELLINGPRICE IS NOT NULL
GROUP BY STATE
ORDER BY total_cars_sold DESC;









