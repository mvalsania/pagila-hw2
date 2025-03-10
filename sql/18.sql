/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT rank, title, revenue, sum(revenue) OVER (ORDER BY rank) AS "total revenue", to_char(100 * sum(revenue) OVER (ORDER BY rank) / sum(revenue) OVER (), 'FM900.00') AS "percent revenue"
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
ORDER BY rank, title
) AS subq
;

