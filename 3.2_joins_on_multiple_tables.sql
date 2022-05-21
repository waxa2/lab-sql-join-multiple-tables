-- Instructions
use sakila;
-- 1. Write a query to display for each store its store ID, city, and country.
SELECT s.store_id, ci.city, co.country
FROM store s
JOIN address a ON s.address_id=a.address_id
JOIN city ci ON ci.city_id=a.city_id
JOIN country co ON co.country_id=ci.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) as total_amount_in_dollars
FROM staff s
JOIN payment p ON s.staff_id=p.staff_id
GROUP BY s.store_id;

-- 3. What is the average running time of films by category?
SELECT  c.name, round(AVG(f.length),1) as average_length
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
GROUP BY c.name;

-- 4. Which film categories are longest?
SELECT  c.name, round(AVG(f.length),1) as average_length
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
GROUP BY c.name
ORDER BY average_length DESC
LIMIT 5 ;

-- 5.Display the most frequently rented movies in descending order.
SELECT COUNT(r.rental_id) as rented_times,f.title 
FROM rental r
JOIN inventory i ON r.inventory_id=i.inventory_id
JOIN film f ON f.film_id=i.film_id
GROUP BY f.film_id 
ORDER BY COUNT(r.rental_id) DESC;

-- 6. List the top five genres in gross revenue in descending order.


SELECT name, SUM(amount) as gross_revenue
FROM category
JOIN film_category using(category_id)
JOIN inventory using(film_id)
JOIN rental using(inventory_id)
JOIN payment using (rental_id)
GROUP BY name
ORDER BY gross_revenue DESC;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?

SELECT s.store_id, f.title
FROM store s
JOIN inventory i ON s.store_id=i.inventory_id
JOIN film f ON f.film_id=i.film_id
WHERE f.title="Academy Dinosaur" and s.store_id=1;