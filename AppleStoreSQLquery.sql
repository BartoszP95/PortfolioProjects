/*
This is an Apple store analysis.
For this project I used a dataset from Kaggle:
https://www.kaggle.com/datasets/ramamet4/app-store-apple-data-set-10k-apps
*/

--number of unique apps in AppleStore table

SELECT
COUNT(DISTINCT id) as UniqueAppIds
FROM AppleStore

--check for any missing values in key fields

SELECT
COUNT(*) as MissingValues
FROM AppleStore
WHERE track_name is null or user_rating is null or prime_genre is null

--amount of apps per genre

SELECT
prime_genre, 
COUNT(*) as AppsPerGenre
FROM AppleStore
GROUP By prime_genre
ORDER By AppsPerGenre DESC

--overwiev of the apps' ratings

SELECT
	min(user_rating) as MinRating,
	max(user_rating) As MaxRating,
	avg(user_rating) As AvgRating
FROM AppleStore

--do paid apps have higher ratings than free apps

SELECt CASE
	When price > 0 THEN 'paid'
    	ELSE 'free'
    	END AS App_Type,
    	avg(user_rating) as Avg_Rating
FROM AppleStore
GROUP by App_Type

--do apps with more supported languages have higher ratings

SELECT CASE
	WHEN lang.num < 10 THEN '<10 languages'
	WHEN lang.num BETWEEN 10 and 30 THEN '10-30 languages'
    	ELSE '>30 languages'
 	END as language_bucket,
    	avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY language_bucket
ORDER BY Avg_Rating DESC

--genres with lowest ratings

SELECT
prime_genre,
avg(user_rating) As Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating ASC
LIMIT 10

--the top rated apps for each genre

SELECT
	prime_genre,
	track_name,
	user_rating
FROM
	(
	SELECT
	prime_genre,
	track_name,
	user_rating,
	RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) rank
	FROM
	AppleStore
	) AS a
WHERE
a.rank = 1


     
     
    

