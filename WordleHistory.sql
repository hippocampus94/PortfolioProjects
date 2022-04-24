SELECT *
FROM PortfolioProject..WordleHistory


-- Create a separate column with first letters 
SELECT LEFT(solution,1) AS first_letter
FROM PortfolioProject..WordleHistory

ALTER TABLE WordleHistory
ADD first_letter char;

UPDATE WordleHistory
SET first_letter = LEFT(solution,1)

-- Create a separate column with last letters
SELECT RIGHT(solution,1) AS last_letter
FROM PortfolioProject..WordleHistory

ALTER TABLE WordleHistory
ADD last_letter char;

UPDATE WordleHistory
SET last_letter = RIGHT(solution,1)

-- Solutions ending with a vowel
SELECT solution
FROM PortfolioProject..WordleHistory
WHERE right(solution,1) IN ('a','e','i','o','u','y')
-- Solutions starting with a vowel 
SELECT solution
FROM PortfolioProject..WordleHistory
WHERE left(solution,1) IN ('a','e','i','o','u','y')
-- Solutions both starting and ending with a vowel 
SELECT solution
FROM PortfolioProject..WordleHistory
WHERE left(solution,1) IN ('a','e','i','o','u','y')
AND right(solution,1) IN ('a','e','i','o','u','y')

SELECT COUNT(*), LEFT(solution,1) as first_letter
FROM PortfolioProject..WordleHistory
WHERE solution LIKE 'a%'
GROUP BY solution

-- Most frequent first letter
SELECT first_letter, COUNT(first_letter) AS most_frequent_first_letter 
FROM PortfolioProject..WordleHistory
GROUP BY first_letter
ORDER BY COUNT(first_letter) DESC 

-- Most frequent last letter 
SELECT last_letter, COUNT(last_letter) AS most_frequent_last_letter
FROM PortfolioProject..WordleHistory
GROUP BY last_letter
ORDER BY COUNT(last_letter) DESC 







