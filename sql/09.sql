/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */
SELECT special_features.special_features, count(*)
FROM film f, unnest(f.special_features) AS special_features
GROUP BY special_features.special_features
ORDER BY special_features;

