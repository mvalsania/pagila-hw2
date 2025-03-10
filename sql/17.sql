/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */
SELECT rank, title, revenue, sum(revenue) OVER (ORDER BY rank) AS "total revenue"
FROM (
SELECT
    RANK() OVER (ORDER BY total_revenue DESC) AS rank,
    title,
    Total_revenue AS revenue
  FROM (
  SELECT
      f.title,
      COALESCE(SUM(p.amount), 0)::numeric(10,2) AS total_revenue
  FROM film f
  LEFT JOIN inventory i ON i.film_id = f.film_id
  LEFT JOIN rental r ON i.inventory_id = r.inventory_id
  LEFT JOIN payment p ON r.rental_id = p.rental_id
  GROUP BY f.title
) AS film_revenue
ORDER BY rank,title 
) AS subq
;

