Create table If Not Exists Accounts (account_id int, income int);

insert into Accounts (account_id, income) values ('3', '108939');
insert into Accounts (account_id, income) values ('2', '12747');
insert into Accounts (account_id, income) values ('8', '87709');
insert into Accounts (account_id, income) values ('6', '91796');

SELECT 
  SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS 'Low Salary',
  SUM(CASE WHEN income between 20000 and 50000 THEN 1 ELSE 0 END) AS 'Average Salary',
  SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS 'High Salary'
FROM 
  Accounts;
  SELECT 'Low Salary' AS category,
       SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS count
FROM Accounts
UNION ALL
SELECT 'Average Salary' AS category,
       SUM(CASE WHEN income BETWEEN 20000 AND 50000 THEN 1 ELSE 0 END) AS count
FROM Accounts
UNION ALL
SELECT 'High Salary' AS category,
       SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS count
FROM Accounts;