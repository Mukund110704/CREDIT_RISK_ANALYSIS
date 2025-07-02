# 📌 Credit Risk Analysis using SQL

![Home Credit Schema](https://storage.googleapis.com/kaggle-media/competitions/home-credit/home_credit.png)

## 🧭 Overview

This project aims to analyze customer credit risk using the [Home Credit Default Risk Dataset](https://www.kaggle.com/competitions/home-credit-default-risk/data) from Kaggle. It includes 8 interlinked tables containing information about customer loan applications, their credit history from other institutions, past payment behavior, and credit card usage.  
By leveraging **SQL-based relational analysis**, this project extracts meaningful insights to identify high-risk applicants and patterns in default behavior.

## 🎯 Objectives

- Understand patterns in income, credit, and loan status for defaulters vs. non-defaulters  
- Identify the impact of previous loan refusals, late payments, and credit utilization on default probability  
- Combine data from multiple sources (application, credit bureau, installments, credit card, etc.) to build a consolidated risk profile for each customer  
- Pinpoint segments of customers with high default risk based on behavioral patterns

## 📊 Key Highlights

- **Default vs. Non-default Analysis**: Compared average income and loan amounts of defaulting vs. repaying customers  
- **Loan Type Risk**: Identified which types of loans (cash, revolving, etc.) are associated with higher default rates  
- **Previous Application Behavior**: Tracked how many applications were refused, accepted, or unused per customer  
- **Installment Payment Delays**: Measured average payment delays and their link to default  
- **Credit Bureau Records**: Counted number of external loans per customer and flagged those with overdue or active delinquent loans  
- **Credit Card Utilization**: Calculated utilization ratio and identified high-balance or over-leveraged customers  
- **Risk Profiling**: Built a comprehensive summary table per customer capturing refusals, delays, credit card usage, and previous loans  
- **Segmentation**: Filtered customers with risky combinations — e.g., multiple refusals, high delays, and high utilization  
- **Behavioral Impact**: Analyzed how late payments correlate with default outcomes  
- **Top Outliers**: Highlighted customers with the biggest differences between loan requested vs. loan granted

## 🗂️ Dataset Source

- 📌 [Kaggle: Home Credit Default Risk Dataset](https://www.kaggle.com/competitions/home-credit-default-risk/data)

## 🧱 Data Schema & Table Relationships

The dataset consists of **8 main tables**:

| Table                    | Description                                                                 | Join Key(s)                     |
|-------------------------|-----------------------------------------------------------------------------|---------------------------------|
| `application_train` / `application_test` | Main loan application data with demographics, income, and loan terms     | `SK_ID_CURR`                    |
| `bureau`                | Credit history from other banks/financial institutions                      | `SK_ID_CURR`                    |
| `bureau_balance`        | Monthly repayment status of external loans                                  | `SK_ID_BUREAU` (links to `bureau`) |
| `previous_application`  | All past applications to Home Credit                                        | `SK_ID_CURR`, `SK_ID_PREV`      |
| `installments_payments` | Payment records on previous Home Credit loans                               | `SK_ID_PREV`                    |
| `credit_card_balance`   | Monthly credit card usage                                                   | `SK_ID_CURR`                    |
| `POS_CASH_balance`      | Point-of-sale loan balance and status over time                             | `SK_ID_CURR`                    |
| `application_test`      | Same as `application_train` but used for prediction (no TARGET column)      | `SK_ID_CURR`                    |

**Example Relationships:**
- Each `SK_ID_CURR` (customer) may have multiple entries in `bureau`, `previous_application`, and `credit_card_balance`
- Each `SK_ID_PREV` (loan) links to its payment history in `installments_payments`
- `bureau_balance` holds monthly updates on loans from the `bureau` table

## 🛠️ Tech Stack

- **Database**: MySQL  
- **Query Language**: SQL (JOINs, aggregates, CASE statements, subqueries)  
- **Source Control**: GitHub  
- **Dataset**: CSV files from Kaggle
