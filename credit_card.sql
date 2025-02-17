USE CREDIT_CARD_ANALYSIS;

-- Integrating Client and Account Data
SELECT c.client_id, c.birth_number, c.district_id AS client_district_id,
a.account_id, a.district_id AS account_district_id, a.date AS account_creation_date, a.frequency
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id;
--  Integrating Client and Account Data
SELECT c.client_id, c.birth_number, a.account_id, l.loan_id, l.date AS loan_date,
 l.amount, l.duration, l.payments, l.status
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN LOAN l ON a.account_id = l.account_id;

-- Integrating Loans with Accounts and Clients
SELECT c.client_id, c.birth_number, a.account_id, l.loan_id, l.date AS loan_date,
 l.amount, l.duration, l.payments, l.status
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN LOAN l ON a.account_id = l.account_id;

 -- Integrating Transactions with Accounts and Clients
 SELECT c.client_id, c.birth_number, a.account_id, t.trans_id,
t.date AS transaction_date, t.type AS transaction_type, t.amount, t.balance, 
t.k_symbol, t.bank, t.account AS partner_account
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN TRANSACTION t ON a.account_id = t.account_id;
-- Integrating Credit Cards with Clients and Accounts
SELECT c.client_id, c.birth_number, a.account_id, cc.card_id, cc.type AS card_type, 
cc.issued AS card_issued_date
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN CREDIT_CARD cc ON d.disp_id = cc.disp_id;
-- Transaction Patterns Analysis
SELECT c.client_id, t.type AS transaction_type, COUNT(*) AS transaction_count,
SUM(t.amount) AS total_amount
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN TRANSACTION t ON a.account_id = t.account_id
GROUP BY c.client_id, t.type
ORDER BY c.client_id, t.type;

-- Loan Repayment Analysis
SELECT c.client_id, COUNT(*) AS total_loans, SUM(l.amount) AS total_loan_amount, 
SUM(l.payments) AS total_payments, l.status
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN LOAN l ON a.account_id = l.account_id
GROUP BY c.client_id, l.status
ORDER BY c.client_id, l.status;
-- Credit Card Usage Analysis
SELECT c.client_id, cc.type AS card_type, COUNT(*) AS card_count
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN CREDIT_CARD cc ON d.disp_id = cc.disp_id
GROUP BY c.client_id, cc.type
ORDER BY c.client_id, cc.type;

-- Demographic Analysis
SELECT d.district_id, dem.region, dem.no_of_inhabitants, dem.average_salary, 
dem.unemployment_rate_1995, dem.unemployment_rate_1996, dem.no_of_crimes_1995, dem.no_of_crimes_1996
FROM DISTRICT d
JOIN DEMOGRAPHIC dem ON d.district_id = dem.district_id;
-- Segment Clients Based on Loan Status
SELECT c.client_id, l.status, COUNT(*) AS loan_count, SUM(l.amount) AS total_loan_amount
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN LOAN l ON a.account_id = l.account_id
GROUP BY c.client_id, l.status;



-- Assign Risk Scores to Clients
SELECT c.client_id, 
       CASE 
           WHEN l.status = 'D' THEN 'High Risk'
           WHEN l.status = 'C' THEN 'Medium Risk'
           ELSE 'Low Risk'
       END AS risk_level
FROM CLIENT c
JOIN DISPOSITION d ON c.client_id = d.client_id
JOIN ACCOUNT a ON d.account_id = a.account_id
JOIN LOAN l ON a.account_id = l.account_id;

 