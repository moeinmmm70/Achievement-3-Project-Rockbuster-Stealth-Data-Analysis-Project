-- Film title contains the word "Uptown"
SELECT film_id, title, description
FROM film
WHERE title LIKE '%Uptown%';

-- Film length > 120 minutes and rental rate > 2.99
SELECT film_id, title, description
FROM film
WHERE length > 120 AND rental_rate > 2.99;

-- Rental duration is between 3 and 7 days (exclusive)
SELECT film_id, title, description
FROM film
WHERE rental_duration > 3 AND rental_duration < 7;

-- Replacement cost is less than 14.99
SELECT film_id, title, description
FROM film
WHERE replacement_cost < 14.99;

-- Rating is either PG or G
SELECT film_id, title, description
FROM film
WHERE rating IN ('PG', 'G');

-- The count of PG and G rated movies, along with the average rental rate,
-- and the maximum and minimum rental durations, with properly aliased columns for clarity
SELECT
COUNT(*) AS "count of movies",
AVG(rental_rate) AS "average movie rental rate",
MAX(rental_duration) AS "maximum rental duration",
MIN(rental_duration) AS "minimum rental duration"
FROM film
WHERE rating IN ('PG', 'G');

-- Aggregate statistics by rating
SELECT
rating,
COUNT(*) AS "count of movies",
AVG(rental_rate) AS "average movie rental rate",
MAX(rental_duration) AS "maximum rental duration",
MIN(rental_duration) AS "minimum rental duration"
FROM film
WHERE rating IN ('PG', 'G')
GROUP BY rating;
