SELECT *
FROM imdb_movies_dataset_cleaning1
;

CREATE TABLE imdb_movies_dataset_cleaning2 AS
SELECT title,
average_rating,
director,
writer,
metascore,
cast,
release_date,
country_of_origin,
languages,
budget,
worldwide_gross,
runtime,
first_released
FROM imdb_movies_dataset_cleaning1
WHERE country_of_origin LIKE '%United States%'
;

SELECT *
FROM imdb_movies_dataset_cleaning2
;

SELECT 'title',
'average_rating',
'director',
'writer',
'metascore',
'cast',
'release_date',
'country_of_origin',
'languages',
'budget',
'worldwide_gross',
'runtime',
'first_released'
UNION ALL
SELECT title,
average_rating,
director,
writer,
metascore,
cast,
release_date,
country_of_origin,
languages,
budget,
worldwide_gross,
runtime,
first_released
FROM imdb_movies_dataset_cleaning2
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\imdb_movies_dataset_us.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
;
