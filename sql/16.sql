/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */
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
ORDER BY rank;

