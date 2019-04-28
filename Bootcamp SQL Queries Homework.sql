USE sakila;

SELECT first_name, last_name FROM actor limit 5;

SELECT concat(first_name, " ", last_name) AS "Actor Name" FROM actor LIMIT 5;

SELECT actor_id, first_name, last_name FROM actor 
WHERE first_name = "Joe";

SELECT * FROM actor
WHERE last_name LIKE "%GEN%";

SELECT * FROM actor
WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

SELECT country_id, country FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor ADD description blob;
ALTER TABLE actor DROP description; 

SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) FROM actor
GROUP BY last_name 
HAVING COUNT(last_name) >= 2;

UPDATE actor 
SET first_name = "Harpo" WHERE first_name = "Groucho";
--6a
SELECT first_name, last_name, address FROM staff
JOIN address ON staff.address_id = address.address_id;

SELECT payment.staff_id, first_name, last_name, SUM(amount) FROM payment
JOIN staff ON staff.staff_id = payment.staff_id 
GROUP BY staff_id;

SELECT COUNT(*) FROM inventory
JOIN film_text ON inventory.film_id = film_text.film_id
WHERE film_text.title = "Hunchback Impossible";

SELECT title, COUNT(DISTINCT actor_id) AS "Number of Actors in Film" FROM film
JOIN film_actor ON film_actor.film_id = film.film_id
GROUP BY title;

SELECT customer.customer_id, first_name, last_name, SUM(amount) as "Total paid by customer"
FROM payment 
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer_id;
--7a
SELECT title FROM film 
WHERE title LIKE "K%" OR "Q%" 
AND title IN (SELECT title FROM film WHERE language_id = "English");

SELECT first_name, last_name FROM actor 
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN
(SELECT film_id FROM film WHERE title = "Alone Trip"));

SELECT first_name, last_name, email FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country = "Canada";

SELECT title FROM film
JOIN film_category ON film_category.film_id = film.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Family";

SELECT film.title, COUNT(rental_id) FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
ORDER BY rental_id DESC

SELECT store.store_id, SUM(amount) FROM payment 
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN store ON store.store_id = inventory.store_id
GROUP BY store.store_id; 

SELECT store.store_id, city.city, country.country FROM store 
JOIN address ON store.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id;

SELECT category.name AS "Genre", SUM(payment.amount) AS "Gross" FROM category 
JOIN film_category ON category.category_id=film_category.category_id
JOIN inventory ON film_category.film_id=inventory.film_id
JOIN rental ON inventory.inventory_id=rental.inventory_id
JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY category.name 
ORDER BY Gross LIMIT 5;
