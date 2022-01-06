/* 
Salaries Differences
Write a query that calculates the difference between the highest salaries 
found in the marketing and engineering departments. Output just the difference 
in salaries.

db_employee
    id  int
    first_name  varchar
    last_name   varchar
    salary  int
    department_id   int

db_dept
    id  int
    department  varchar

*/

-- test queries
SELECT dept.id, emp.first_name
FROM db_employee emp JOIN db_dept dept
ON emp.department_id = dept.id;

SELECT id 
FROM db_employee;

SELECT dept.id, dept.department, emp.salary
FROM db_employee emp JOIN db_dept dept
ON emp.department_id = dept.id;

-- ans - messed up my sol. so copy pasted

-- Join tables for dept information 
-- Filter for Engineering and Marketing
-- Find max(eng_salary)
-- Find max(marketing_salary)
-- Find Difference of Max(Eng_Salary) and Max(Marketing Salary), absolute
WITH cte (salary, department) AS (
    SELECT salary, department
    FROM db_employee e
    LEFT JOIN db_dept d
    ON e.department_id = d.id
    WHERE d.department IN ('engineering','marketing')
),
 
cte_eng (max_eng_sal) AS (
    SELECT max(salary) AS max_eng_sal
    FROM cte
    WHERE department = 'engineering'
),

cte_mar (max_mar_sal) AS (
    SELECT max(salary) AS max_mar_sal
    FROM cte
    WHERE department = 'marketing'
)

SELECT ABS(max_eng_sal - max_mar_sal) AS sal_diff
FROM cte_eng, cte_mar


