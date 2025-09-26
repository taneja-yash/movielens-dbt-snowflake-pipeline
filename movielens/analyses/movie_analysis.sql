-- 1. Top 20 Movies by Average Rating (with at least 100 ratings)
WITH ratings_summary AS (
    SELECT
        movie_id,
        AVG(rating) AS average_rating,
        COUNT(*) AS total_ratings
    FROM MOVIELENS.DEV.fct_ratings
    GROUP BY movie_id
    HAVING COUNT(*) > 100
)
SELECT
    m.movie_title,
    rs.average_rating,
    rs.total_ratings
FROM ratings_summary rs
JOIN MOVIELENS.DEV.dim_movies m ON m.movie_id = rs.movie_id
ORDER BY rs.average_rating DESC
LIMIT 20;

-- 2. Most Active Users
SELECT
    u.user_id,
    COUNT(*) AS total_ratings
FROM MOVIELENS.DEV.fct_ratings r
JOIN MOVIELENS.DEV.dim_users u ON u.user_id = r.user_id
GROUP BY u.user_id
ORDER BY total_ratings DESC
LIMIT 20;

-- 3. Most Popular Genres
WITH movie_genres AS (
    SELECT
        m.movie_id,
        g.value AS genre
    FROM MOVIELENS.DEV.dim_movies m,
         LATERAL FLATTEN(input => m.genre_array) g
)
SELECT
    genre,
    COUNT(r.rating) AS total_ratings,
    AVG(r.rating) AS avg_rating
FROM movie_genres mg
JOIN MOVIELENS.DEV.fct_ratings r ON r.movie_id = mg.movie_id
GROUP BY genre
ORDER BY total_ratings DESC;

-- 4. Movies with Most Tag Activity
SELECT
    m.movie_title,
    COUNT(t.tag) AS total_tags
FROM MOVIELENS.DEV.dim_movies m
JOIN MOVIELENS.DEV.src_tags t ON t.movie_id = m.movie_id
GROUP BY m.movie_title
ORDER BY total_tags DESC
LIMIT 20;

-- 5. Top Tags by Average Relevance
SELECT
    gt.tag_name,
    AVG(gs.relevance_score) AS avg_relevance,
    COUNT(gs.movie_id) AS movies_tagged
FROM MOVIELENS.DEV.fct_genome_scores gs
JOIN MOVIELENS.DEV.dim_genome_tags gt ON gt.tag_id = gs.tag_id
GROUP BY gt.tag_name
ORDER BY avg_relevance DESC
LIMIT 20;

-- 6. Movies with Most Diverse Ratings (High Variance)
SELECT
    m.movie_title,
    COUNT(r.rating) AS total_ratings,
    VAR_SAMP(r.rating) AS rating_variance,
    AVG(r.rating) AS average_rating
FROM MOVIELENS.DEV.fct_ratings r
JOIN MOVIELENS.DEV.dim_movies m ON m.movie_id = r.movie_id
GROUP BY m.movie_title
HAVING COUNT(r.rating) > 50
ORDER BY rating_variance DESC
LIMIT 20;

-- 7. Highly Rated Tags (Average Rating by Tag)
WITH movie_tag_ratings AS (
    SELECT
        t.tag,
        r.rating
    FROM MOVIELENS.DEV.src_tags t
    JOIN MOVIELENS.DEV.fct_ratings r ON r.movie_id = t.movie_id
)
SELECT
    tag,
    COUNT(rating) AS total_ratings,
    AVG(rating) AS avg_rating
FROM movie_tag_ratings
GROUP BY tag
ORDER BY avg_rating DESC
LIMIT 20;