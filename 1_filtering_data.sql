-- SQL Query: Ordering the Data

SELECT *
FROM film
ORDER BY title ASC, release_year DESC, rental_rate DESC;

-- SQL Query: Grouping Data by Rating

SELECT
rating,
AVG(rental_rate) AS avg_rental_rate,
MIN(rental_duration) AS min_rental_duration,
MAX(rental_duration) AS max_rental_duration
FROM film
GROUP BY rating;
