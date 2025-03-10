/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */
SELECT f.title
FROM film f
WHERE f.title IN (
SELECT f.title
FROM film f, unnest(f.special_features) AS feature
WHERE feature = 'Trailers'
) AND f.rating = 'G'
ORDER BY f.title;

