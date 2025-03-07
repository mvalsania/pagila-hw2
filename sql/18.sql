/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
WITH film_revenue AS (
    SELECT
        f.film_id,
        f.title,
        SUM(p.amount) AS revenue
    FROM
        film f
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY
        f.film_id,
        f.title
),
total AS (
    SELECT SUM(revenue) AS total_revenue FROM film_revenue
)
SELECT
    ROW_NUMBER() OVER (ORDER BY fr.revenue DESC) AS rank,
    fr.title,
    ROUND(fr.revenue, 2) AS revenue,
    ROUND(SUM(fr.revenue) OVER (ORDER BY fr.revenue DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS "total revenue",
    TO_CHAR(100.0 * fr.revenue / t.total_revenue, 'FM00.00') AS "percent revenue"
FROM
    film_revenue fr,
    total t
ORDER BY
    fr.revenue DESC
