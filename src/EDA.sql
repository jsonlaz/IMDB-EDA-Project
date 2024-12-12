-- Exploratory Data Analysis

SELECT *
FROM imdb_movies_dataset_cleaning1
;

SELECT MAX(budget)
FROM imdb_movies_dataset_cleaning1
;

SELECT MIN(budget)
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE budget = 700000000
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE budget = 350000
;

SELECT MAX(worldwide_gross)
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE worldwide_gross = 2799439100
;

SELECT MAX(metascore)
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE metascore = 100.0
;

SELECT MAX(average_rating)
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE average_rating = 9.3
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE country_of_origin LIKE '%United States%'
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE country_of_origin LIKE '%United States%'
ORDER BY budget DESC
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE country_of_origin LIKE '%United States%'
ORDER BY worldwide_gross DESC
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE director LIKE '%Christopher Nolan%'
;

SELECT *
FROM imdb_movies_dataset_cleaning1
WHERE director LIKE '%Christopher Nolan%'
OR writer LIKE '%Christopher Nolan%'
;

SELECT MIN(release_date),
MAX(release_date)
FROM imdb_movies_dataset_cleaning1
;

SELECT substring(release_date, 6, 2) AS `month`
FROM imdb_movies_dataset_cleaning1
;

SELECT *
FROM imdb_movies_dataset_cleaning1
ORDER BY release_date
;

SELECT title, 
release_date
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '19__-__-__'
ORDER BY release_date
;

SELECT title, 
release_date, metascore
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '19__-__-__'
ORDER BY release_date
;

WITH Average_90s_Metascore AS
(
SELECT title, 
release_date, metascore
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '19__-__-__'
ORDER BY release_date
)
SELECT ROUND(AVG(metascore))
FROM Average_90s_Metascore
;

SELECT title, 
release_date, metascore
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '20__-__-__'
ORDER BY release_date
;

WITH Average_20s_Metascore AS
(
SELECT title,
release_date,
metascore
FROM imdb_movies_dataset_cleaning1
WHERE release_date LIKE '20__-__-__'
ORDER BY release_date
)
SELECT ROUND(AVG(metascore))
FROM Average_20s_Metascore
;

SELECT *
FROM imdb_movies_dataset_cleaning1
ORDER BY runtime
;

SELECT director, COUNT(director) AS row_num
FROM imdb_movies_dataset_cleaning1
GROUP BY director
ORDER BY row_num DESC
;

#SELECT DISTINCT director,
#ROW_NUMBER() OVER(
#					PARTITION BY director
#                   ) AS row_num
#FROM imdb_movies_dataset_cleaning1
#ORDER BY row_num DESC
#;

#WITH Row_Num AS
#(
#SELECT director,
#ROW_NUMBER() OVER(
#					PARTITION BY director
#					) AS row_num
#FROM imdb_movies_dataset_cleaning1
#)
#SELECT MAX(row_num)
#FROM Row_Num
#;
