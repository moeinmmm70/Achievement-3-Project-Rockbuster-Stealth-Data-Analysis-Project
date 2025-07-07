-- Rewrite Subqueries Using CTEs
-- Business Question 1: Average amount paid by the top 5 customers
-- Define the CTE for the top 5 customers by total payment
WITH total_amount_paid AS (
SELECT
customer. customer_id,
customer.first_name,
customer.last_name,
country.country,
city.city,
SUM(payment.amount) AS total_paid
FROM payment
JOIN customer ON payment. customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name, country.country, city.city
ORDER BY total_paid DESC
LIMIT 5
)
-- Main query to calculate average amount paid by those top 5 customers
SELECT
AVG(total_paid) AS average_paid
FROM total_amount_paid;

-- Business Question 2: Top 5 customers per country vs all customers
-- CTE for top 5 customers from previous query
WITH top_5_customers AS (
SELECT
customer.customer_id,
country.country
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY customer.customer_id, country.country
ORDER BY SUM(payment.amount) DESC
LIMIT 5
),
-- CTE for all customers per country
customer_counts AS (
SELECT
country.country,
COUNT(DISTINCT customer.customer_id) AS all_customer_count
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country
)
-- Main query to merge both CTEs and count top customers per country
SELECT
cc.country,
cc.all_customer_count,
COUNT(DISTINCT t5.customer_id) AS top_customer_count
FROM customer_counts cc
LEFT JOIN top_5_customers t5 ON cc.country = t5.country
GROUP BY cc.country, cc.all_customer_count
ORDER BY top_customer_count DESC;
