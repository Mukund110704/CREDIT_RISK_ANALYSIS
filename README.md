# Credit Risk Analysis 🏦

## Overview

This project aims to perform in-depth **credit risk analysis** using structured banking and loan-related datasets. The goal is to extract actionable insights about customer creditworthiness, default tendencies, loan behavior, and other financial indicators by performing SQL-based data exploration.

The project uses relational data from multiple tables, such as customer application data, previous loan applications, bureau credit history, installment payments, and credit card balances. These are joined and analyzed to build a comprehensive picture of credit risk factors and borrower behavior.

![Schema Diagram](https://storage.googleapis.com/kaggle-media/competitions/home-credit/home_credit.png)

## Objectives

- 📊 **Compare defaulters vs. non-defaulters** on income, loan amounts, and financial habits.
- 🧾 **Analyze past loan application history** and refusal patterns.
- 🕵️ **Identify behavioral red flags** like payment delays, high credit utilization, or excessive applications.
- 🏷️ **Correlate personal attributes** (e.g., education level) with default rates.
- 📉 **Understand the burden of outstanding bureau loans** and missed payments.
- 📌 **Rank and segment customers** based on risk factors for potential intervention or policy optimization.

## Key Highlights

- Used **15 comprehensive SQL queries** to answer key business questions about credit risk and customer profiling.
- Built a **customer-level summary** with KPIs like:
  - Number of refused applications
  - Average payment delay
  - Credit card utilization
- Identified high-risk customers based on **multiple risk thresholds** (e.g., >2 refusals, avg. delay >30 days, utilization >70%).
- Ranked customers by **gaps between requested vs. granted credit**, helping highlight mismatches in credit assessments.
- Mapped relationships between **default risk and personal indicators**, such as education level and payment discipline.

## Tech Stack

- **SQL**: Core tool for querying, aggregating, and joining complex relational data.
- **MySQL Workbench** / **MySQL Server**: Used to manage and execute queries efficiently.
- **Kaggle Dataset**: Imported as CSVs and loaded into MySQL for querying.
- **GitHub**: Version control and documentation.

## Dataset Source

- 📂 [Home Credit Default Risk Dataset on Kaggle](https://www.kaggle.com/competitions/home-credit-default-risk/data)

## Schema Explanation (Based on Diagram Above)

- **application_train**: Main customer application table containing income, credit, education, family, and target (default status).
- **previous_application**: Details of previous loan applications, including status (approved/refused) and requested amounts.
- **bureau**: External credit history from credit bureaus, linked by `SK_ID_CURR`.
- **bureau_balance**: Monthly status updates for each bureau record.
- **installments_payments**: Records of scheduled vs. actual installment payments.
- **credit_card_balance**: Ongoing balance and limit data for customer credit cards.

The relationships between tables are:
- `SK_ID_CURR` links the main customer to bureau, previous applications, and credit cards.
- `SK_ID_PREV` links previous applications to installment payments.
- `SK_ID_BUREAU` links bureau records to their monthly balances.

---

