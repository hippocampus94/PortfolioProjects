



 -- 10 best selling video games of all time 
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;

-- Check for games without ratings
SELECT COUNT(*)
FROM game_sales
LEFT JOIN reviews
ON game_sales.game = reviews.game
WHERE critic_score IS NULL
AND user_score IS NULL;

-- Years that video game critics loved
SELECT  year, AVG(reviews.critic_score) AS avg_critic_score 
FROM game_sales
INNER JOIN reviews
ON game_sales.game = reviews.game
GROUP BY year
ORDER BY avg_critic_score DESC 
LIMIT 10;

-- Years that video game critics loved, including only years with 4 or more reviewed games 
SELECT  year, AVG(reviews.critic_score) AS avg_critic_score, COUNT(game_sales.game) as num_games
FROM game_sales
INNER JOIN reviews
ON game_sales.game = reviews.game
GROUP BY year 
HAVING COUNT(game_sales.game) > 4
ORDER BY avg_critic_score DESC 
LIMIT 10;

-- Years with fewer than 4 game reviews
SELECT year, avg_critic_score
FROM top_critic_years
EXCEPT
SELECT year, avg_critic_score
FROM top_critic_years_more_than_four_games
ORDER BY avg_critic_score DESC

-- Years that users loved, including only years with 4 or more reviewed games
SELECT year, AVG(user_score) as avg_user_score, COUNT(game_sales.game) as num_games
FROM game_sales
INNER JOIN reviews
ON game_sales.game = reviews.game
GROUP BY year
HAVING COUNT(game_sales.game) > 4 
ORDER BY avg_user_score DESC
LIMIT 10;

-- Years loved by both critics and users
SELECT year
FROM top_critic_years_more_than_four_games
INTERSECT
SELECT year
FROM top_user_years_more_than_four_games
LIMIT 10;

-- Game sales for the top 3 games both critics and users loved 
SELECT year, SUM(games_sold) AS total_games_sold
FROM game_sales
WHERE year IN (SELECT year
FROM top_critic_years_more_than_four_games

INTERSECT

SELECT year
FROM top_user_years_more_than_four_games)
GROUP BY year
ORDER BY total_games_sold DESC 

