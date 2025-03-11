# Netflix Movies and TV Shows Data Analysis using SQL

![](https://github.com/najirh/netflix_sql_project/blob/main/logo.png)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset.

## Objectives

- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.
- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- 
## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schemas

```sql
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

-- DISTINCT DIRECTORS
SELECT 	
	DISTINCT(director)
FROM netflix;
```

## 15 Business Problems & Solutions

-- 15 Business Problems & Solutions

### 1. Count the number of Movies vs TV Shows.
```sql
	SELECT 
		type,
		COUNT(*) AS total_conTent
	FROM netflix
	GROUP BY 1;
```

### 2. Find the most common rating for movies and TV shows.
```sql
	SELECT 
		type,
		rating
	FROM
	(
		SELECT 
			type,
			rating,
			COUNT(*),
			RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
		FROM netflix
		GROUP BY 1,2
	)
	WHERE ranking =1;	
```

### 3. List all movies released in a specific year (e.g., 2020).
```sql
	SELECT *
	FROM netflix
	WHERE 
		type='Movie'
		AND 
		release_year='2020';
```

### 4. Find the top 5 countries with the most content on Netflix.
```sql
	SELECT 
		UNNEST(STRING_TO_ARRAY(country,', ')) AS new_country,
		COUNT(show_id) AS total_content
	FROM netflix
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 5;
```

### 5. Identify the longest movie.
```sql
	SELECT * FROM netflix
	WHERE 
		type='Movie'
		AND 
		duratiON=(SELECT MAX(duration) FROM netflix)
```

### 6. Find content added in the last 5 years.
```sql
	SELECT *
	FROM netflix
	WHERE 
		TO_DATE(date_added,'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years'
```
	
### 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
```sql
	SELECT * 
	FROM netflix
	WHERE director ILIKE '%Rajiv Chilaka%';
```

### 8. List all TV shows with more than 5 seasons.
```sql
	SELECT * 
	FROM netflix
	WHERE 
		type='TV Show'	
		AND
		SPLIT_PART(duration,' ',1)::numeric > 5 ;
```

### 9. Count the number of content items in each genre.
```sql
	SELECT 
		UNNEST(STRING_TO_ARRAY(listed_in,', ')) AS genres,
		COUNT(show_id) AS total_content
	FROM netflix
	GROUP BY 1;
```

### 10.Find each year and the average numbers of content release in India on netflix. 
###  return top 5 year with highest avg content release!
```sql
	SELECT 
		EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY')) AS year,
		COUNT(*) AS yearly_content,
		ROUND(
		COUNT(*):: numeric/(SELECT COUNT(*) FROM netflix WHERE country ='India')* 100 
		,2)AS avg_content_per_year
	FROM netflix
	WHERE country='India'
	GROUP BY 1;
```

### 11. List all movies that are documentaries.
```sql
	SELECT *
	FROM netflix
	WHERE 	
		listed_in ILIKE '%documentaries%';
```

### 12. Find all content without a director.
```sql
	SELECT * FROM netflix 
	WHERE director IS NULL;
```

### 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
```sql
	SELECT * FROM netflix
	WHERE 
		casts ILIKE '%Salman Khan%'
		AND 
		release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

### 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
```sql
	SELECT 
		UNNEST(STRING_TO_ARRAY(casts,', ')) AS actors,
		COUNT(*) AS total_content
	FROM netflix 
	WHERE country ILIKE '%India%'
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 10;
```

### 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
### the description field. Label content containing these keywords as 'Bad' and all other 
### content as 'Good'. Count how many items fall into each category.
```sql
	WITH new_table
	AS
	(
	SELECT *,
		CASE 
		WHEN description ILIKE '%kill%' OR
			 description ILIKE '%violence%' THEN 'Bad_content'
			 ELSE 'Good_content'
		END AS category
	FROM netflix
	)
	SELECT 
		category,
		COUNT(*) AS total_content
	FROM new_table
	GROUP BY 1;
```
-- END

## Conclusion:
The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.


