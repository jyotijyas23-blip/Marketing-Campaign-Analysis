
CREATE DATABASE MARKETING_COMPAIGN_DB;
GO

USE MARKETING_COMPAIGN_DB;
GO

SELECT *
FROM [Cust_review.csv];

SELECT *
FROM [Engagement_data.csv];

 SELECT *
FROM [Countries.csv]
WHERE countryID IS NULL
   OR Country IS NULL
   OR City IS NULL;

SELECT countryID, Country, City,
 Count(*) AS Duplicate_Count 
 From [Countries.csv]
 GROUP BY countryID, country, city
  HAVING COUNT(*) > 1 ; 
  
SELECT 
    Custid,
    CustName,
    Email,
    Gender,
    Age,
    Locid,
    COUNT(*) AS Duplicate_Count
FROM [Customers.csv]
GROUP BY 
    Custid,
    CustName,
    Email,
    Gender,
    Age,
    Locid
HAVING COUNT(*) > 1;

-- ---------- checking unique value_______

SELECT DISTINCT Gender
From [customers.csv]

SELECT MIN(Age) AS Minimum_Age,
Max(Age) AS Maximum_Age
FROM [customers.csv];

SELECT countryID,
COUNT(*) AS Count_of_ID
FROM [countries.csv]
GROUP BY countryID
HAVING COUNT(*) > 1;

SELECT Custid,
COUNT(*) AS Count_of_ID
FROM [Customers.csv]
GROUP BY Custid
HAVING COUNT(*) > 1;

SELECT * FROM [Cust_review.csv]
WHERE Reviewid IS NULL
OR Custid IS NULL
OR Productid IS NULL
OR ReviewDate IS NULL
OR Rating IS NULL
OR Review_text IS NULL;

SELECT Reviewid, Custid, Productid,ReviewDate, Rating, Review_text,
COUNT(*) AS Duplicate_Count
FROM [Cust_review.csv]
GROUP BY Reviewid,Custid,Productid,ReviewDate, Rating,Review_text
HAVING COUNT(*) > 1;

-- CHECK NULL VALUES IN CUSTOMERS TABLE
-- =============================================

SELECT * FROM [Customers.csv]
WHERE Custid IS NULL
   OR CustName IS NULL
   OR Email IS NULL
   OR Gender IS NULL
   OR Age IS NULL
   OR Locid IS NULL;

-- CHECK UNIQUE  GENDER VALUE ---

   SELECT DISTINCT Gender
FROM [Customers.csv];


SELECT TOP 10 *
FROM [Engagement_data.csv];

-- CHECK NULL VALUES IN ENGAGEMENT DATA
-- =============================================

SELECT * FROM [Engagement_data.csv]
WHERE EngagementID IS NULL
   OR ContentID IS NULL
   OR ContentType IS NULL
   OR Likes IS NULL
   OR Eng_date IS NULL
   OR CampaignID IS NULL
   OR ProductID IS NULL
   OR [View] IS NULL
   OR Clicks IS NULL;

-- COUNT THE NULL VALUE--

SELECT COUNT(*) AS Null_View_Count
FROM [Engagement_data.csv]
WHERE [View] IS NULL;

UPDATE [Engagement_data.csv]
SET [View] = 0
WHERE [View] IS NULL;

SELECT COUNT(*) AS Remaining_Null_Views
FROM [Engagement_data.csv]
WHERE [View] IS NULL;

--- CHEKING DUBLICATES RECORDS---

SELECT EngagementID,ContentID,ContentType, Likes,
Eng_date,CampaignID,ProductID,[View],Clicks,
COUNT(*) AS Duplicate_Count
FROM [Engagement_data.csv]
GROUP BY EngagementID,ContentID,ContentType,Likes,Eng_date,CampaignID,ProductID,[View],Clicks
HAVING COUNT(*) > 1;

--Cheking unique value---
SELECT DISTINCT ContentType
FROM [Engagement_data.csv];

---Checking Date Range -----

SELECT MIN(Eng_date) AS First_Engagement_Date,
MAX(Eng_date) AS Last_Engagement_Date
FROM [Engagement_data.csv];

SELECT TOP 10 *
FROM [Products.csv];

-- CHECK NULL VALUES IN PRODUCTS TABLE

SELECT * FROM [Products.csv]
WHERE Product_id IS NULL
OR Prd_name IS NULL
OR Category IS NULL
OR Price IS NULL;

-- =============================================
-- CHECK DUPLICATE RECORDS IN PRODUCTS TABLE
-- =============================================

SELECT Product_id,Prd_name,Category,Price,
COUNT(*) AS Duplicate_Count
FROM [Products.csv]
GROUP By Product_id,Prd_name,Category,Price
HAVING COUNT(*) > 1;

-- Cheking Unique cat. ---

SELECT DISTINCT Category
FROM [Products.csv]
ORDER BY Category;

 -- checking prosuct price range----

 SELECT 
    MIN(Price) AS Minimum_Price,
    MAX(Price) AS Maximum_Price,
    AVG(Price) AS Average_Price
FROM [Products.csv];

-- CHECK DUPLICATE PRODUCT IDs---

SELECT 
    Product_id,
    COUNT(*) AS Count_of_Product_ID
FROM [Products.csv]
GROUP BY Product_id
HAVING COUNT(*) > 1;

---- CHECK ALL THE TABLE RELATIONSHIP --

SELECT 
    TABLE_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN (
    'Countries.csv',
    'Customers.csv',
    'Cust_review.csv',
    'Engagement_data.csv',
    'Products.csv'
)
ORDER BY TABLE_NAME, ORDINAL_POSITION;


SELECT TOP 10
    c.Custid,
    c.CustName,
    c.Gender,
    c.Age,
    co.Country,
    co.City
FROM [Customers.csv] AS c
INNER JOIN [Countries.csv] AS co
    ON c.Locid = co.countryID;

-- CHECK RELATIONSHIP: CUSTOMERS + CUSTOMER REVIEWS

SELECT TOP 10
    c.Custid,
    c.CustName,
    cr.Reviewid,
    cr.Productid,
    cr.ReviewDate,
    cr.Rating,
    cr.Review_text
FROM [Customers.csv] AS c
INNER JOIN [Cust_review.csv] AS cr
ON c.Custid = cr.Custid;

-- CHECK RELATIONSHIP: CUSTOMER REVIEWS + PRODUCTS

SELECT TOP 10
    cr.Reviewid,
    cr.Custid,
    cr.Productid,
    p.Prd_name,
    p.Category,
    p.Price,
    cr.Rating,
    cr.Review_text
FROM [Cust_review.csv] AS cr
INNER JOIN [Products.csv] AS p
ON cr.Productid = p.Product_id;


-- CHECK RELATIONSHIP: ENGAGEMENT DATA + PRODUCTS

SELECT TOP 10
    e.EngagementID,
    e.ContentID,
    e.ContentType,
    e.CampaignID,
    e.ProductID,
    p.Prd_name,
    p.Price,
    e.Likes,
    e.[View],
    e.Clicks,
    e.Eng_date
FROM [Engagement_data.csv] AS e
INNER JOIN [Products.csv] AS p
ON e.ProductID = p.Product_id;

---Total customers ---

SELECT COUNT(*) AS Total_customers
FROM [Customers.csv]

----TOTAL PRODUCTS---

SELECT COUNT(*) AS Total_Products
FROM [Products.csv];

---- Engagement Records---

SELECT COUNT(*) AS Total_Engagements
FROM [Engagement_data.csv];

----Total Customer Review--

SELECT COUNT(*) AS Total_Reviews
FROM [Cust_review.csv];


-- CUSTOMER ANALYSIS----

SELECT Gender,COUNT(*) AS Total_Customers
FROM [Customers.csv]
GROUP BY Gender
ORDER BY Total_Customers DESC;

---- AGE Analysis---

SELECT CASE
WHEN Age < 25 THEN 'Under 25'
WHEN Age BETWEEN 25 AND 34 THEN '25-34'
WHEN Age BETWEEN 35 AND 44 THEN '35-44'
WHEN Age BETWEEN 45 AND 54 THEN '45-54'
ELSE '55+'
END AS Age_Group,
COUNT(*) AS Total_Customers
FROM [Customers.csv]
GROUP BY CASE
 WHEN Age < 25 THEN 'Under 25'
 WHEN Age BETWEEN 25 AND 34 THEN '25-34'
 WHEN Age BETWEEN 35 AND 44 THEN '35-44'
 WHEN Age BETWEEN 45 AND 54 THEN '45-54'
 ELSE '55+'
 END
ORDER BY Age_Group;

---CUSTOMERS BY LOCATION--

SELECT co.Country,co.City,
COUNT(c.Custid) AS Total_Customers
FROM [Customers.csv] AS c
INNER JOIN [Countries.csv] AS co
ON c.Locid = co.countryID
GROUP BY co.Country,co.City
ORDER BY Total_Customers DESC;

---PRODUCT ANALYSIS--

SELECT p.Prd_name, COUNT(cr.Reviewid) AS Total_Reviews,
 ROUND(AVG(CAST(cr.Rating AS FLOAT)), 2) AS Average_Rating
FROM [Products.csv] AS p
LEFT JOIN [Cust_review.csv] AS cr
ON p.Product_id = cr.Productid
GROUP BY p.Prd_name
ORDER BY Total_Reviews DESC;

--- Highest and lowest range prod.---

SELECT TOP 5 p.Prd_name,
ROUND(AVG(CAST(cr.Rating AS FLOAT)), 2) AS Average_Rating,
COUNT(cr.Reviewid) AS Total_Reviews
FROM [Products.csv] AS p
INNER JOIN [Cust_review.csv] AS cr
ON p.Product_id = cr.Productid
GROUP BY p.Prd_name
ORDER BY Average_Rating DESC;

-- lowest range--

SELECT TOP 5 p.Prd_name,
ROUND(AVG(CAST(cr.Rating AS FLOAT)), 2) AS Average_Rating,
COUNT(cr.Reviewid) AS Total_Reviews
FROM [Products.csv] AS p
INNER JOIN [Cust_review.csv] AS cr
ON p.Product_id = cr.Productid
GROUP BY p.Prd_name
ORDER BY Average_Rating ASC;

--CUSTOMER REVIEW ANALYSIS--

SELECT  ROUND(AVG(CAST(Rating AS FLOAT)), 2) AS Overall_Average_Rating,
COUNT(*) AS Total_Reviews
FROM [Cust_review.csv];

--- CUSTOMERS RATING --

SELECT Rating,
COUNT(*) AS Total_Reviews
FROM [Cust_review.csv]
GROUP BY Rating
ORDER BY Rating;

-- ENGAGEMENT & CONTENT ANALYSIS--

SELECT
    ContentType,
    COUNT(*) AS Total_Engagements,
    SUM(TRY_CAST(Likes AS INT)) AS Total_Likes,
    SUM(TRY_CAST([View] AS INT)) AS Total_Views,
    SUM(TRY_CAST(Clicks AS INT)) AS Total_Clicks
FROM [Engagement_data.csv]
GROUP BY ContentType
ORDER BY Total_Engagements DESC;


-- CAMPAIGN PERFORMANCE ANALYSIS---

SELECT
    CampaignID,
    COUNT(*) AS Total_Engagements,
    SUM(TRY_CAST(Likes AS INT)) AS Total_Likes,
    SUM(TRY_CAST([View] AS INT)) AS Total_Views,
    SUM(TRY_CAST(Clicks AS INT)) AS Total_Clicks
FROM [Engagement_data.csv]
GROUP BY CampaignID
ORDER BY Total_Engagements DESC;

-- MONTHLY ENGAGEMENT TREND---

SELECT
    YEAR(TRY_CONVERT(DATE, Eng_date)) AS Engagement_Year,
    MONTH(TRY_CONVERT(DATE, Eng_date)) AS Engagement_Month,
    COUNT(*) AS Total_Engagements,
    SUM(TRY_CAST(Likes AS INT)) AS Total_Likes,
    SUM(TRY_CAST([View] AS INT)) AS Total_Views,
    SUM(TRY_CAST(Clicks AS INT)) AS Total_Clicks
FROM [Engagement_data.csv]
WHERE TRY_CONVERT(DATE, Eng_date) IS NOT NULL
GROUP BY
    YEAR(TRY_CONVERT(DATE, Eng_date)),
    MONTH(TRY_CONVERT(DATE, Eng_date))
ORDER BY
    Engagement_Year,
    Engagement_Month;

---- Done--