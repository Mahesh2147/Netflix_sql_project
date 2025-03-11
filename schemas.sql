-- SCHEMAS
-- CREATE TABLE
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

-- ALL RECORDS
SELECT * FROM netflix;

-- COUNT OF RECORDS
SELECT 
	COUNT(*) AS total_concent
FROM  netflix;

-- DISTINCT TYPE
SELECT 	
	DISTINCT type
FROM netfLix;

--DISTINCT DIRECTORS
SELECT 	
	DISTINCT(director)
FROM netflix;