SELECT *
FROM PortfolioProject..SephoraData


--  10 most expensive products
SELECT TOP 10 name, brand, category, price
FROM PortfolioProject..SephoraData
ORDER BY price DESC 

-- The most liked product
SELECT TOP 1 name, brand, category, love
FROM PortfolioProject..SephoraData
ORDER BY love DESC 


-- 5 most liked product categories 
SELECT TOP 5 category, SUM(love) AS love_sum_per_category
FROM PortfolioProject..SephoraData
GROUP BY category
ORDER BY love_sum_per_category DESC 


-- Most liked lipstick vs most expensive lipstick vs least expensive lipstick
SELECT TOP 1 name, brand, category, price
FROM PortfolioProject..SephoraData
WHERE category = 'Lipstick'
ORDER BY love DESC 

SELECT TOP 1 name, brand, category, price
FROM PortfolioProject..SephoraData
WHERE category = 'Lipstick'
ORDER BY price DESC 

SELECT TOP 1 name, brand, category, price
FROM PortfolioProject..SephoraData
WHERE category = 'Lipstick'
ORDER BY price ASC 

-- Most liked foundation
SELECT TOP 1 name, brand, category, love, rating
FROM PortfolioProject..SephoraData
WHERE category = 'Foundation'
ORDER BY love DESC 

-- Most liked eye palette
SELECT TOP 1 name, brand, category, love, rating
FROM PortfolioProject..SephoraData
WHERE category = 'Eye Palettes'
ORDER BY love DESC 

-- Most liked face serum 
SELECT TOP 1 name, brand, category, love, rating
FROM PortfolioProject..SephoraData
WHERE category = 'Face Serums'
ORDER BY love DESC 

-- Most liked moisturizer
SELECT TOP 1 name, brand, category, love, rating
FROM PortfolioProject..SephoraData
WHERE category = 'Moisturizers'
ORDER BY love DESC 

-- 5 most liked brands and the average brand ratings 
SELECT TOP 5 brand, SUM(love) AS love_per_brand, AVG(rating) AS avg_brand_rating
FROM PortfolioProject..SephoraData
GROUP BY brand 
ORDER BY love_per_brand DESC 

-- Most expensive brands
SELECT brand, AVG(price) AS avg_brand_price
FROM PortfolioProject..SephoraData
GROUP BY brand
ORDER BY avg_brand_price DESC 

-- Lowest and highest price of products per category
SELECT category, MIN(price) AS lowest_price, MAX(price) AS highest_price
FROM PortfolioProject..SephoraData
GROUP BY category









