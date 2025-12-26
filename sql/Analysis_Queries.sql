USE Finance;

-- Expected output is omitted in this sql file due to inconsistent data in the CREATE sql file and the finance database.
-- Comparison bar chart for Budget Versus Actual total expense this month by categories
SELECT c.Category_name, c.Budget_per_month, ABS(d.Actual_total_expense) AS Total_Expense_This_Month
FROM 
	(SELECT Category_id, Category_name, Budget_per_month
	FROM Categories
	WHERE NOT(Category_id = 1 
				OR Category_id = 3)) AS c
LEFT JOIN
		(SELECT S.Category_id, Category_name, SUM(Amount) AS Actual_total_expense 
	FROM `Transaction` AS S
	JOIN Categories
	ON S.Category_id = Categories.Category_id
	WHERE (S.Category_id != 1
			AND ( MONTH(Transaction_date) = MONTH(CURDATE())
					AND YEAR(Transaction_date) = YEAR(CURDATE())
				)
		   )	
	GROUP BY Category_id) AS d
ON c.Category_id = d.Category_id
;

-- 1. How much do I budget for all categories per month?
-- finding the category and its budget_per_month
SELECT Category_name, Budget_per_month
FROM Categories
WHERE NOT(Category_id = 1 
			OR Category_id = 3)
;

-- 2. How much have I spent by categories this month?
-- finding the sum of all expenses by category(excluding salary and including only current month) in the transaction table
SELECT S.Category_id, Category_name, SUM(Amount) AS Actual_total_expense 
FROM `Transaction` AS S
JOIN Categories
ON S.Category_id = Categories.Category_id
WHERE (S.Category_id != 1
		AND ( MONTH(Transaction_date) = MONTH(CURDATE())
				AND YEAR(Transaction_date) = YEAR(CURDATE())
			)
	   )	
GROUP BY Category_id 
;

-- 3. What is the top three categories on which I have used my money this month?
-- find total by category, sort by desc, limit 3
SELECT S.Category_id, Category_name, SUM(Amount) AS Actual_total_expense 
FROM `Transaction` AS S
JOIN Categories
ON S.Category_id = Categories.Category_id
WHERE (S.Category_id != 1
		AND ( MONTH(Transaction_date) = MONTH(CURDATE())
				AND YEAR(Transaction_date) = YEAR(CURDATE())
			)
	   )
GROUP BY Category_id
ORDER BY Actual_total_expense ASC 
LIMIT 3
;
-- 4. What is the outstanding debt?
-- For outstanding debt, sum all amounts with account = credit card, then subtract (sum of all amounts with category = credit card refill)

SELECT (table1.Paid_debt - table2.Total_debt) AS Outstanding_debt
FROM (
		(SELECT SUM(Amount) AS Paid_debt
		FROM `Transaction`
		WHERE Category_id = 3) AS table1
        JOIN
		(SELECT SUM(Amount) AS Total_debt
		FROM `Transaction`
		WHERE Account_id = 2) AS table2
	 )
;
-- 5. What is the current balance?
-- For current balance, income - expense(both from checking and credit card), 
-- exclude expense for category_id = credit card refill(already includes in credit card)
SELECT SUM(Amount) AS Current_balance
FROM `Transaction`
WHERE Category_id != 3
;

-- Testing
SELECT * FROM Transaction;
SELECT * FROM Bank_account;
SELECT * FROM Categories;



