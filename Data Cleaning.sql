-- SQL Project - Data Cleaning

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove any Columns

SELECT *
FROM imdb_movies_dataset
;

CREATE TABLE imdb_movies_dataset_cleaning
LIKE imdb_movies_dataset
;

SELECT *
FROM imdb_movies_dataset_cleaning
;

INSERT imdb_movies_dataset_cleaning
SELECT *
FROM imdb_movies_dataset
;

SELECT *
FROM imdb_movies_dataset_cleaning
;

-- 1. Remove Duplicates

SELECT *,
ROW_NUMBER() OVER(
					PARTITION BY MyUnknownColumn, 
                    Title, 
                    'Average Rating',
                    Director,
                    Writer,
                    Metascore,
                    Cast,
                    'Release Date',
                    'Country of Origin',
                    Languages,
                    Budget,
                    'Worldwide Gross',
                    Runtime
                    ) AS row_num
FROM imdb_movies_dataset_cleaning
;

WITH duplicate_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(
					PARTITION BY MyUnknownColumn, 
                    Title, 
                    'Average Rating',
                    Director,
                    Writer,
                    Metascore,
                    Cast,
                    'Release Date',
                    'Country of Origin',
                    Languages,
                    Budget,
                    'Worldwide Gross',
                    Runtime
                    ) AS row_num
FROM imdb_movies_dataset_cleaning
)
SELECT *
FROM duplicate_CTE
WHERE row_num > 1
;

#No duplicates in the original data

-- 2. Standardize the Data

SELECT 
    `Release Date`, 
    SUBSTRING_INDEX(SUBSTRING_INDEX(`Release Date`, '(', -1), ')', 1) AS 'First Released'
FROM imdb_movies_dataset_cleaning
;

SELECT *
FROM imdb_movies_dataset_cleaning
;

CREATE TABLE `imdb_movies_dataset_cleaning1` (
  `number` int DEFAULT NULL,
  `title` text,
  `average_rating` double DEFAULT NULL,
  `director` text,
  `writer` text,
  `metascore` text,
  `cast` text,
  `release_date` text,
  `country_of_origin` text,
  `languages` text,
  `budget` text,
  `worldwide_gross` text,
  `runtime` text,
  `first_released` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

INSERT INTO imdb_movies_dataset_cleaning1
SELECT *,
SUBSTRING_INDEX(SUBSTRING_INDEX(`Release Date`, '(', -1), ')', 1) AS first_released
FROM imdb_movies_dataset_cleaning
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT release_date,
TRIM(
	CONCAT(
			SUBSTRING_INDEX(release_date, '(', 1),
            SUBSTRING_INDEX(release_date, ')', -1)
            )
	) AS trimming
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '% %, %'
;

UPDATE imdb_movies_dataset_cleaning1
SET release_date = TRIM(
    CONCAT(
        SUBSTRING_INDEX(release_date, '(', 1), 
        SUBSTRING_INDEX(release_date, ')', -1)
    )
)
WHERE release_date LIKE '%(%)%'
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT release_date,
STR_TO_DATE(release_date, '%M %d, %Y')
FROM imdb_movies_dataset_cleaning1
;

SELECT release_date,
DATE_FORMAT(STR_TO_DATE(release_date, '%M %d, %Y'), '%m-%d-%Y') AS date_fmt
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '% %, %'
;

#UPDATE imdb_movies_dataset_cleaning1
#SET release_date = DATE_FORMAT(STR_TO_DATE(release_date, '%M %d, %Y'), '%m-%d-%Y')
#WHERE release_date LIKE '% %, %'
#;

UPDATE imdb_movies_dataset_cleaning1
SET release_date = CASE
    WHEN release_date LIKE '% %, %' 
    THEN STR_TO_DATE(release_date, '%M %d, %Y')
    ELSE NULL
END;

SELECT release_date
FROM imdb_movies_dataset_cleaning1
;

SELECT budget
FROM imdb_movies_dataset_cleaning1
;

SELECT budget,
       CAST(REGEXP_REPLACE(budget, '[^0-9]', '') AS UNSIGNED)
FROM imdb_movies_dataset_cleaning1
;


SELECT budget,
       CAST(NULLIF(REGEXP_REPLACE(budget, '[^0-9]', ''), '') AS UNSIGNED) AS numeric_budget
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NOT NULL
;

UPDATE imdb_movies_dataset_cleaning1
SET budget = CAST(NULLIF(REGEXP_REPLACE(budget, '[^0-9]', ''), '') AS UNSIGNED)
WHERE budget IS NOT NULL
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT worldwide_gross,
       CAST(NULLIF(REGEXP_REPLACE(worldwide_gross, '[^0-9]', ''), '') AS UNSIGNED)
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NOT NULL
;

UPDATE imdb_movies_dataset_cleaning1
SET worldwide_gross = CAST(NULLIF(REGEXP_REPLACE(worldwide_gross,'[^0-9]',''), '') AS UNSIGNED)
WHERE worldwide_gross IS NOT NULL
;

#SELECT RANK() OVER(ORDER BY title)
#FROM imdb_movies_dataset_cleaning1
#;

#CREATE TEMPORARY TABLE temp_ranks AS
#SELECT ROW_NUMBER() OVER(ORDER BY title) AS row_num, title
#FROM imdb_movies_dataset_cleaning1;

#UPDATE imdb_movies_dataset_cleaning1 AS t1
#JOIN temp_ranks AS t2
#ON t1.title = t2.title
#SET t1.row_num = t2.row_num;

SELECT *
FROM imdb_movies_dataset_cleaning1
;



-- 3. Null Values or Blank Values
 
SELECT `number`, metascore
FROM imdb_movies_dataset_cleaning1
WHERE metascore NOT LIKE '_%'
;

UPDATE imdb_movies_dataset_cleaning1
SET metascore = NULL
WHERE metascore NOT LIKE '_%'
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NULL 
AND metascore IS NULL
AND worldwide_gross IS NULL
;

-- 4. Remove any Columns

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NULL 
AND metascore IS NULL
AND worldwide_gross IS NULL
;

DELETE
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NULL 
AND metascore IS NULL
AND worldwide_gross IS NULL
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NULL
;

DELETE
FROM imdb_movies_dataset_cleaning1
WHERE budget IS NULL
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE worldwide_gross IS NULL
;

DELETE
FROM imdb_movies_dataset_cleaning1
WHERE worldwide_gross IS NULL
;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

#ALTER TABLE imdb_movies_dataset_cleaning1
#DROP COLUMN `number`
#;

SELECT *
FROM imdb_movies_dataset_cleaning1
;

ALTER TABLE imdb_movies_dataset_cleaning1
MODIFY COLUMN budget BIGINT
;

ALTER TABLE imdb_movies_dataset_cleaning1
MODIFY COLUMN worldwide_gross BIGINT
;

ALTER TABLE imdb_movies_dataset_cleaning1
MODIFY COLUMN metascore DOUBLE
;

ALTER TABLE imdb_movies_dataset_cleaning1
MODIFY COLUMN release_date DATE
;

DESCRIBE imdb_movies_dataset_cleaning1;
