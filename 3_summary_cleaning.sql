-- Check for Duplicate Data
-- Film Tbale
SELECT title, release_year, language_id, rental_duration, COUNT(*)
FROM film
GROUP BY title, release_year, language_id, rental_duration
HAVING COUNT(*) > 1;

-- Customer Table
SELECT first_name, last_name, email, address_id, COUNT(*)
FROM customer
GROUP BY first_name, last_name, email, address_id
HAVING COUNT(*) > 1;

-- Check for Non-Uniform Data
--Film Table – Rating Column
SELECT DISTINCT rating
FROM film;

-- Customer Table – Active Column
SELECT DISTINCT active
FROM customer;

-- Check for Missing Values
-- Film Table
SELECT *
FROM film
WHERE rental_rate IS NULL OR length IS NULL;

-- Customer Table
SELECT *
FROM customer
WHERE email IS NULL OR address_id IS NULL;

-- Summarize Data
-- Film Table; Descriptive Statistics
SELECT
MIN(rental_rate) AS min_rent,
MAX(rental_rate) AS max_rent,
AVG(rental_rate) AS avg_rent,
COUNT(*) AS total_films
FROM film;

SELECT
MODE() WITHIN GROUP (ORDER BY rating) AS most_common_rating
FROM film;

-- Customer Table; Descriptive Statistics
SELECT
MIN(customer_id) AS min_id,
MAX(customer_id) AS max_id,
COUNT(*) AS total_customers
FROM customer;

SELECT
MODE() WITHIN GROUP (ORDER BY store_id) AS most_common_store
FROM customer;
