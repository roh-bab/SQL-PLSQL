--RFM Marketing Analysis with Analytical SQL---

---What's RFM Analysis?---
--***RFM*** Stands for ***Recency***, ***Frequency*** and ***Monetary*** which is a form of analysis often used 
--    in Marketing which segments customers based on those 3 factors.

-------- Questions answered in this project:----------

-- What's the total number of customers, orders and the avg total paid price?
-- Total number of orders made based on time intervals
-- Total quantities sold based on time intervals
-- Total price paid per time interval
-- Total price paid per time interval per customer
-- Segmenting customers based on their ***recent paid order***, ***order frequency*** and ***how much s/he pays***


------------------------------------------------------

-- Finding no. of customers, no. of orders and the avg paid price per country 

SELECT DISTINCT country,
                COUNT(DISTINCT invoice) OVER(PARTITION BY country) AS Number_Of_Orders,
                COUNT(DISTINCT customer_id) OVER(PARTITION BY country) AS Number_Of_Customers,
                ROUND(AVG(price*quantity) OVER(PARTITION BY country),2) AS Avg_Payment
FROM tableretail
ORDER BY Number_Of_Orders DESC, Number_Of_Customers DESC;

------------------------------------------------------

-- Figuring out the number of orders per date
SELECT DISTINCT invoicedate,
       COUNT(invoice) OVER(PARTITION BY invoicedate) AS Number_Of_Orders
FROM tableretail
ORDER BY Number_Of_Orders DESC;

------------------------------------------------------
-- Figuring out the quantities ordered per date
SELECT DISTINCT invoicedate,
            SUM(quantity) OVER(PARTITION BY invoicedate) as Total_Quantities_Per_Date
FROM tableretail
ORDER BY Total_Quantities_Per_Date DESC;

-- Figuring out the highest revenue made throughout the day
SELECT DISTINCT invoicedate,
            ROUND(SUM(price*quantity) OVER(PARTITION BY invoicedate),0) AS Total_Price_Of_Orders
FROM tableretail
ORDER BY Total_Price_Of_Orders DESC;

--  Figuring out the highest paid customers per interval
SELECT DISTINCT customer_id,
       invoicedate,
       ROUND(SUM(price*quantity) OVER(PARTITION BY customer_id, invoicedate),0) AS Total_Price
FROM tableretail
ORDER BY Total_Price DESC;


--- Quick Insights:---
-- There's a total order of 717 and 110 customers, They are all based in the UK.
-- The avg payment paid per order is 19.89 Pounds
-- The majority of orders are made during morning to noon with an interval of approximately 09:00 AM to 4:30 PM.
-- The highest amount paid also fits the same interval with an exception of a single occurrence **8/4/2011 18:06**
-- Based on the quantities ordered and total paid price, Customers tend to order frequently multiple goods ***which we will try to validate throught the next step***



--- Customer Segmentation using RFM ---

-- Step #1 - Extracting the highest date of each employee along with their order frequency and total price paid
SELECT customer_id,
       MAX(TO_DATE(invoicedate, 'MM/DD/YYYY HH24:MI')) AS Last_Date,
       COUNT(invoice) AS Order_Count,
       SUM(price*quantity) AS Total_Price
FROM tableretail
GROUP BY customer_id
ORDER BY customer_id;

-- Step #2 figuring out the recency of ordering per customer
SELECT customer_id,
            Last_Date,
            ROUND((ROUND(MONTHS_BETWEEN(TO_DATE('12/9/2011 12:20','MM/DD/YYYY HH24:MI'),Last_Date),2)/30)*1000,0) Recency,
            Order_Count,
            Total_Price
FROM (SELECT customer_id,
             MAX(TO_DATE(invoicedate, 'MM/DD/YYYY HH24:MI')) AS Last_Date,
             COUNT(invoice) AS Order_Count,
             SUM(price*quantity) AS Total_Price
     FROM tableretail
     GROUP BY customer_id
     ORDER BY customer_id) inner_table
ORDER BY Recency;


-- Step #3 using NTILE to segment the 2 factors (Recency and Monetary) *removed frequency since it indicates the volume as Monetary does* to segment customers in the next step
SELECT customer_id,
       NTILE(5) OVER(ORDER BY Recency) AS Recency,
       NTILE(5) OVER(ORDER BY Total_Price) AS Monetary
FROM( SELECT customer_id,
             Last_Date,
             ROUND((ROUND(MONTHS_BETWEEN(TO_DATE('12/9/2011 12:20','MM/DD/YYYY HH24:MI'),Last_Date),2)/30)*1000,0) Recency,
             Order_Count,
             Total_Price
       FROM (SELECT customer_id,
                    MAX(TO_DATE(invoicedate, 'MM/DD/YYYY HH24:MI')) AS Last_Date,
                    COUNT(invoice) AS Order_Count,
                    SUM(price*quantity) AS Total_Price
             FROM tableretail
             GROUP BY customer_id
             ORDER BY customer_id) inner_table) outer_table;



-- Step #4 Segmenting the customers based on (Recency and Monetary) Scores
WITH customer_segment AS
(
SELECT customer_id,
            NTILE(5) OVER(ORDER BY Recency) AS Recency,
            NTILE(5) OVER(ORDER BY Total_Price) AS Monetary
FROM( SELECT customer_id,
            Last_Date,
            ROUND((ROUND(MONTHS_BETWEEN(TO_DATE('12/9/2011 12:20','MM/DD/YYYY HH24:MI'),Last_Date),2)/30)*1000,0) Recency,
            Order_Count,
            Total_Price
            FROM (SELECT customer_id,
                                    MAX(TO_DATE(invoicedate, 'MM/DD/YYYY HH24:MI')) AS Last_Date,
                                    COUNT(invoice) AS Order_Count,
                                    SUM(price*quantity) AS Total_Price
                        FROM tableretail
                        GROUP BY customer_id
                        ORDER BY customer_id) inner_table) outer_table
)

-- Segmenting Customers
SELECT customer_id,
            Recency,
            Monetary,
            CASE WHEN Recency = 5 AND Monetary = 5 THEN 'Champions'
                     WHEN Recency = 4 AND Monetary = 5 THEN 'Champions'
                     WHEN Recency = 5 AND Monetary = 4 THEN 'Champions'
                     WHEN Recency = 5 AND Monetary = 2 THEN 'Potential Loyalists'
                     WHEN Recency = 4 AND Monetary = 2 THEN 'Potential Loyalists'
                     WHEN Recency = 4 AND Monetary = 3 THEN 'Potential Loyalists'
                     WHEN Recency = 3 AND Monetary = 3 THEN 'Potential Loyalists'
                     WHEN Recency = 5 AND Monetary = 3 THEN 'Loyal Customers'
                     WHEN Recency = 4 AND Monetary = 4 THEN 'Loyal Customers'
                     WHEN Recency = 3 AND Monetary = 5 THEN 'Loyal Customers'
                     WHEN Recency = 3 AND Monetary = 4 THEN 'Loyal Customers'
                     WHEN Recency = 5 AND Monetary = 1 THEN 'Recent Customers'
                     WHEN Recency = 4 AND Monetary = 1 THEN 'Promising'
                     WHEN Recency = 3 AND Monetary = 1 THEN 'Promising'
                     WHEN Recency = 3 AND Monetary = 2 THEN 'Customers Needing Attention'
                     WHEN Recency = 2 AND Monetary = 3 THEN 'Customers Needing Attention'
                     WHEN Recency = 2 AND Monetary = 2 THEN 'Customers Needing Attention'
                     WHEN Recency = 2 AND Monetary = 5 THEN 'At Risk'
                     WHEN Recency = 2 AND Monetary = 4 THEN 'At Risk'
                     WHEN Recency = 1 AND Monetary = 3 THEN 'At Risk'
                     WHEN Recency = 1 AND Monetary = 5 THEN 'Cannot Lose Them'
                     WHEN Recency = 1 AND Monetary = 4 THEN 'Cannot Lose Them'
                     WHEN Recency = 1 AND Monetary = 2 THEN 'Hibernating'
                     WHEN Recency = 1 AND Monetary = 1 THEN 'Lost'
            END Customer_Segment
FROM customer_segment
ORDER BY Recency DESC, Monetary DESC;

------------------------------------------------------
--Conclusion:
-- Based on our customer segmentation analysis, we have identified five distinct customer groups, with scores ranging from 1 to 5. With this information, we can recommend to the marketing team to focus on developing a customized plan to target customers who have a score of 3 to 5. These customers are highly active and considered loyal, and nurturing their loyalty through targeted marketing efforts can help retain them.
-- On the other hand, customers with a score of 1 and 2 are most likely churned, and any marketing plan may not be as effective in re-engaging them. By focusing on the right customer groups, the marketing team can optimize their efforts and achieve better results.

------------------------------------------------------
