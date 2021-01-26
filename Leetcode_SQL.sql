/*
176. Second Highest Salary
Write a SQL query to get the second highest salary from the Employee table.
+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
For example, given the above Employee table, the query should return 200 as the second highest salary. If there is no second highest salary, then the query should return null.
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
*/

/* Method 1: Window Function */
SELECT MIN(salary)
FROM (SELECT salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk FROM employee) AS tb
WHERE rnk = 2

/* Method 2: CTE + Window Function */
WITH T as
(
SELECT
ID, Salary, DENSE_RANK() OVER(ORDER BY Salary desc) as Rnk
FROM Employee
)

SELECT IFNULL(Salary, NULL) as SecondHighestSalary
FROM T
WHERE Rnk=2;

/* Method 3: IFNULL */
SELECT
IFNULL(
(SELECT Distinct Salary
FROM Employee
ORDER BY Salary Desc
LIMIT 1 OFFSET 1),
NULL
) as SecondHighestSalary
