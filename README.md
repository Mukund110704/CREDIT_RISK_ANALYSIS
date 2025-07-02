# 📊 Credit Risk Analysis using SQL

This project performs an in-depth credit risk analysis using SQL on the [Home Credit Default Risk dataset](https://www.kaggle.com/competitions/home-credit-default-risk/data). The goal is to understand customer behavior, loan defaults, credit utilization, and payment patterns by writing powerful analytical SQL queries across multiple interconnected tables.

## Objective

The main objective of this project is to explore customer credit behavior and assess risk factors associated with loan defaults. We use structured SQL queries to extract insights that banks or lenders could use to make informed lending decisions.

## Dataset Overview

The dataset contains rich information about past and current loan applications, credit bureau data, installment payment history, and credit card usage. It consists of **millions of rows across multiple normalized tables**.

**Source**: [Kaggle - Home Credit Default Risk](https://www.kaggle.com/competitions/home-credit-default-risk/data)


## Database Schema

The diagram below visualizes the relationship between the main tables:

![Schema](https://storage.googleapis.com/kaggle-media/competitions/home-credit/home_credit.png)

### Table Relationships

| Table                   | Description                                                                                      | Linked By             |
|------------------------|--------------------------------------------------------------------------------------------------|-----------------------|
| `application_train` / `application_test` | Main customer application data (train includes `TARGET` = default or not)                      | `SK_ID_CURR`          |
| `bureau`               | Historical credit data from other institutions                                                   | `SK_ID_CURR`          |
| `bureau_balance`       | Monthly status updates of each loan from the `bureau` table                                      | `SK_ID_BUREAU`        |
| `previous_application` | All past loans the customer applied for (even if refused)                                        | `SK_ID_CURR`          |
| `installments_payments`| Installment-wise payment behavior for previously approved loans                                 | `SK_ID_PREV`          |
| `credit_card_balance`  | Monthly usage and repayment information on credit card accounts                                 | `SK_ID_CURR`          |
| `pos_cash_balance`     | Point-of-sale and cash loan status over time                                                    | `SK_ID_CURR`          |


## 📈 Key Insights and Analysis Performed

This project answers critical credit risk questions using SQL queries across these tables. Some examples of insights derived include:

- **Default behavior vs. income and credit amount**  
- **Loan types with highest default rates**  
- **Utilization ratios on credit cards**  
- **Delay patterns in installment payments**  
- **Customers with high past refusal rates or overdue balances**
- **Which education or employment types are more prone to default?**
- ⚠**Risk profiling based on behavior across all loans and credit cards**

##Techniques Used

- Complex **JOINs** across 4–5 tables  
- **Aggregations** like `AVG`, `MAX`, `COUNT`, `SUM`  
- **CASE WHEN** for conditional analysis  
- Use of **NULLIF** to avoid divide-by-zero errors  
- Creation of **customer-level summaries and risk flags**  
- Using binary columns like `TARGET` to compute **default rates**


## Tech Stack

- **SQL**: Core tool for querying, aggregating, and joining complex relational data.
- **MySQL Workbench** : Used to manage and execute queries efficiently.
- **Kaggle Dataset**: Imported as CSVs and loaded into MySQL for querying.
- **GitHub**: Version control and documentation.


This project is built using the public Kaggle dataset from [Home Credit Default Risk](https://www.kaggle.com/competitions/home-credit-default-risk/data).


