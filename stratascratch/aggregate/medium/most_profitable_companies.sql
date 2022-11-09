/*

*/
SELECT * 
FROM forbes_global_2010_2014;

-- solution
-- SELECT rank, company
-- ORDER BY profits desc

WITH ranks
AS
(
    SELECT 
        company,
        dense_rank() OVER (ORDER BY PROFIT) 
)

SELECT f.company, f.profits, f.rank
FROM forbes_global_2010_2014 f
WHERE f.rank <= 3
ORDER BY f.profits DESC
;
-- checking expected output, not same. 

-- reread question, just most profitable companies
SELECT f.company, f.profits
FROM forbes_global_2010_2014 f
ORDER BY f.profits DESC
LIMIT 3
;






