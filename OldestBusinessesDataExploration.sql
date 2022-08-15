

-- Oldest and newest business founding years 
SELECT MIN(year_founded), MAX(year_founded)
FROM businesses

-- Checking how many businesses were founded before the year 1000
SELECT COUNT(*)
FROM businesses
WHERE year_founded < 1000

-- All information about businesses founded before the year 1000 from the businesses table 
SELECT *
FROM businesses
WHERE year_founded < 1000
ORDER BY year_founded 

-- Join with the category table to find out the business categories 

SELECT business, year_founded, country_code, c.category
FROM businesses as b
INNER JOIN categories as c
ON b.category_code = c.category_code
WHERE year_founded < 1000 
ORDER BY year_founded 

-- Most common industries among the oldest businesses

SELECT category, COUNT(category) as n
FROM businesses as b
INNER JOIN categories as c
ON b.category_code = c.category_code
GROUP BY category
ORDER BY n DESC
LIMIT 10;

-- Earliest founding year per continent 

SELECT MIN(year_founded) as oldest, c.continent
FROM businesses as b
INNER JOIN countries as c
ON b.country_code = c.country_code
GROUP BY continent 
ORDER BY oldest

-- The three tables joined together to display the most information 

SELECT b.business, b.year_founded, cat.category, count.country, count.continent
FROM businesses as b 
INNER JOIN categories as cat
ON b.category_code = cat.category_code
INNER JOIN countries as count
ON b.country_code = count.country_code;

-- Most common industries per continent 

SELECT continent, category, COUNT(business) as n
FROM businesses as b
INNER JOIN categories as cat
ON b.category_code = cat.category_code
INNER JOIN countries as count
ON b.country_code = count.country_code
GROUP BY continent, category
ORDER BY n DESC 

-- Limiting results to display only those with over 5 businesses per category per continent 
SELECT continent, category, COUNT(business) as n
FROM businesses as b
INNER JOIN categories as cat
ON b.category_code = cat.category_code
INNER JOIN countries as count
ON b.country_code = count.country_code
GROUP BY continent, category
HAVING COUNT(business) > 5
ORDER BY COUNT(business) DESC
