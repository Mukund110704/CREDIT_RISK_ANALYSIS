Create Database CreditRiskAnalysis;
Use CreditRiskAnalysis;

#1. What is the average income and loan amount for customers who defaulted vs. those who didn’t?
SELECT TARGET,
Round(AVG(AMT_INCOME_TOTAL),2) AS Avg_income,
Round(AVG(AMT_CREDIT),2) AS Avg_credit
FROM application_train
GROUP BY TARGET;

#2. Which loan types have the highest default rate?
SELECT NAME_CONTRACT_TYPE, AVG(TARGET) AS Default_rate
FROM application_train
GROUP BY NAME_CONTRACT_TYPE;

#3. What is the number of previous applications made by each customer?
SELECT A.SK_ID_CURR, COUNT(B.SK_ID_PREV) AS NUM_PREV_APPLICATIONS
FROM application_train AS A
LEFT JOIN previous_application AS B
ON A.SK_ID_CURR = B.SK_ID_CURR
GROUP BY A.SK_ID_CURR;

#4. What percentage of previous applications were refused vs. approved?
SELECT NAME_CONTRACT_STATUS, COUNT(*) AS Application_count,
ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM previous_application), 2) AS Percentage_of_total
FROM previous_application
GROUP BY NAME_CONTRACT_STATUS
ORDER BY percentage_of_total DESC;

#5. What is the most common credit types for defaulters?
SELECT B.CREDIT_TYPE,COUNT(*) AS Num_Loans, AVG(A.TARGET) AS Default_Rate
FROM application_train AS A
JOIN bureau AS B
ON A.SK_ID_CURR = B.SK_ID_CURR
GROUP BY B.CREDIT_TYPE
ORDER BY Default_Rate DESC;

#6. What’s the number of external (bureau) loans per customer?
SELECT A.SK_ID_CURR,COUNT(B.SK_ID_BUREAU) AS Num_Bureau_Loans
FROM application_train AS A
LEFT JOIN bureau AS B
ON A.SK_ID_CURR = B.SK_ID_CURR
GROUP BY A.SK_ID_CURR;


#7. What is the average payment delay on previous loans per customer?
SELECT A.SK_ID_CURR, AVG(B.DAYS_ENTRY_PAYMENT - B.DAYS_INSTALMENT) AS Avg_Payment_Delay
FROM application_train AS A
JOIN installments_payments AS B
ON A.SK_ID_CURR = B.SK_ID_CURR
GROUP BY A.SK_ID_CURR;

#8. How many customers had overdue monthly bureau balances (status > 0)?
SELECT DISTINCT A.SK_ID_CURR
FROM application_train AS A
JOIN bureau AS B
ON A.SK_ID_CURR = B.SK_ID_CURR
JOIN bureau_balance AS C 
ON B.SK_ID_BUREAU = C.SK_ID_BUREAU
WHERE C.STATUS IN ('1', '2', '3', '4', '5');

#9. Which education levels are associated with higher default rates?
SELECT NAME_EDUCATION_TYPE,AVG(TARGET) AS default_rate
FROM application_train
GROUP BY NAME_EDUCATION_TYPE;


#10. What is the max credit card debt ever held by a customer?
SELECT SK_ID_CURR,MAX(AMT_BALANCE) AS max_balance_held
FROM credit_card_balance
WHERE SK_ID_CURR > 0
GROUP BY SK_ID_CURR
ORDER BY max_balance_held DESC
LIMIT 10;

#11. Build a customer-level summary view including: Total previous applications, Count of refused applications, Average payment delay, Credit card utilization
SELECT A.SK_ID_CURR,
COUNT(DISTINCT B.SK_ID_PREV) AS Total_Prev_Loans,
SUM(CASE WHEN B.NAME_CONTRACT_STATUS = 'Refused' THEN 1 ELSE 0 END) AS Num_refused,
AVG(C.DAYS_ENTRY_PAYMENT - C.DAYS_INSTALMENT) AS Avg_delay,
AVG(D.AMT_BALANCE / NULLIF(D.AMT_CREDIT_LIMIT_ACTUAL, 0)) AS Avg_utilization
FROM application_train AS A
LEFT JOIN previous_application AS B ON A.SK_ID_CURR = B.SK_ID_CURR
LEFT JOIN installments_payments AS C ON B.SK_ID_PREV = C.SK_ID_PREV
LEFT JOIN credit_card_balance AS D ON A.SK_ID_CURR = D.SK_ID_CURR
GROUP BY A.SK_ID_CURR;


#12. Identify customers who: Have >2 refused previous applications, Average payment delay > 30 days, Credit card utilization > 70%.

SELECT 
    summary.SK_ID_CURR
FROM (
    SELECT 
	A.SK_ID_CURR,
	SUM(CASE WHEN B.NAME_CONTRACT_STATUS = 'Refused' THEN 1 ELSE 0 END) AS Num_refused,
	AVG(C.DAYS_ENTRY_PAYMENT - C.DAYS_INSTALMENT) AS Avg_delay,
	AVG(D.AMT_BALANCE / NULLIF(D.AMT_CREDIT_LIMIT_ACTUAL, 0)) AS Avg_utilization
    FROM application_train AS A
    LEFT JOIN previous_application AS B ON A.SK_ID_CURR = B.SK_ID_CURR
    LEFT JOIN installments_payments AS C ON B.SK_ID_PREV = C.SK_ID_PREV
    LEFT JOIN credit_card_balance AS D ON A.SK_ID_CURR = D.SK_ID_CURR
    GROUP BY A.SK_ID_CURR
) AS summary
WHERE summary.num_refused > 2
  AND summary.avg_delay > 30
  AND summary.avg_utilization > 0.7;


#13. Top 10 customers with biggest gap between requested and granted amounts.
SELECT SK_ID_CURR, AMT_APPLICATION, AMT_CREDIT,
(AMT_APPLICATION - AMT_CREDIT) AS Amount_gap
FROM previous_application AS pa
ORDER BY Amount_gap DESC
LIMIT 10;

#14. For each customer, count how many bureau credits were still active and had overdue months.
SELECT A.SK_ID_CURR, COUNT(DISTINCT C.SK_ID_BUREAU) AS Active_Overdue_Loans
FROM application_train AS A
JOIN bureau AS B 
ON A.SK_ID_CURR = B.SK_ID_CURR
JOIN bureau_balance AS C 
ON B.SK_ID_BUREAU = C.SK_ID_BUREAU
WHERE B.CREDIT_ACTIVE = 'Active' AND C.STATUS IN ('1', '2', '3', '4', '5')
GROUP BY A.SK_ID_CURR;

#15. Default rate of customers who paid previous installments on time vs. those who paid late
SELECT 
    is_late,
    AVG(A.TARGET) AS Default_Rate
FROM (
    SELECT 
        B.SK_ID_CURR,
        MAX(CASE WHEN B.DAYS_ENTRY_PAYMENT > B.DAYS_INSTALMENT THEN 1 ELSE 0 END) AS is_late
    FROM installments_payments AS B
    GROUP BY B.SK_ID_CURR
) AS pay_status
JOIN application_train AS A ON pay_status.SK_ID_CURR = A.SK_ID_CURR
GROUP BY is_late;



