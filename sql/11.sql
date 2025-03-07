/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */
SELECT UPPER(a.first_name || ' ' || a.last_name) AS "Actor Name"
FROM public.actor a
JOIN public.film_actor fa ON a.actor_id = fa.actor_id
JOIN public.film f ON fa.film_id = f.film_id
WHERE 'Behind the Scenes' = ANY(f.special_features)
LIMIT 15;
