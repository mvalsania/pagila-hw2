/*
 * Compute the total revenue for each film.
 */
SELECT f.title, COALESCE(SUM(p.amount), 0)::numeric(10,2) AS revenue
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
GROUP BY f.title
ORDER BY revenue DESC;

