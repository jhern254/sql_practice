/*
*/

-- ranking, id_guest, sum_n_messages
select * from airbnb_contacts;

SELECT COUNT(DISTINCT id_guest)
FROM airbnb_contacts
;

-- trick, check for duplicates. 
-- questions to ask: what is pk? is id guest unique?
WITH ranks
AS
(
    SELECT 
        id_guest,
        rank() over (PARTITION BY id_guest ORDER BY n_messages DESC) AS ranking,
        n_messages
    FROM airbnb_contacts
)
SELECT 
    ranking,
    id_guest,
    n_messages AS sum_n_messages
FROM ranks
WHERE ranking <= 5
;



-- works but wrong order
WITH summing
AS
(
    SELECT
        id_guest,
        sum(n_messages) OVER (PARTITION BY id_guest) sum_n_messages
    FROM airbnb_contacts
), ranks AS
(
    SELECT DISTINCT
        id_guest,
        dense_rank() over (ORDER BY sum_n_messages DESC) AS ranking,
        sum_n_messages
    FROM summing
)
SELECT *
FROM ranks
WHERE ranking <= 5
ORDER BY ranking, id_guest DESC
;



-- failed so far, checked hints, need sum
WITH summing
AS
(
    SELECT
        id_guest,
        sum(n_messages) OVER (PARTITION BY id_guest) sum_n_messages
    FROM airbnb_contacts
), ranks AS
(
    SELECT DISTINCT
        id_guest,
        dense_rank() over (ORDER BY sum_n_messages DESC) AS ranking,
        sum_n_messages
    FROM summing
)
SELECT *
FROM ranks
WHERE ranking <= 5
ORDER BY ranking, 
    CASE id_guest 
        WHEN id_guest ~ '^\d+(\.\d+)?$'  -- SUBSTR(1, id_guest) BETWEEN 0 AND 9
            THEN id_guest 
        END DESC,
    CASE id_guest 
        WHEN id_guest ~ '[a-zA-Z][a-zA-Z]%'
            THEN id_guest 
        END
;



