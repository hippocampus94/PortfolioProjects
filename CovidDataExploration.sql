--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4 

SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4 DESC

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Total Cases vs Total Deaths
-- Likelihood of death if you get COVID in your country 
SELECT location, date, total_cases, total_deaths , (total_deaths / total_cases) * 100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'Poland'
ORDER BY 1,2

-- Total Cases vs Population
-- Percentage of population that contracted COVID
SELECT location, date, total_cases, population, (total_cases / population) * 100 AS case_percentage
FROM PortfolioProject..CovidDeaths
 WHERE location LIKE 'Pol%'
ORDER BY 1,2

-- Highest infection rate vs Population

SELECT location, MAX((total_cases)) AS highest_infection_count, population, MAX((total_cases / population)) * 100 AS population_infection_perc
FROM PortfolioProject..CovidDeaths
GROUP BY population, location
ORDER BY population_infection_perc DESC
 -- WHERE location LIKE 'Pol%'




--SELECT location, MAX(total_deaths) AS highest_death_count, population, MAX((total_deaths/population))* 100 AS population_death_perc
--FROM PortfolioProject..CovidDeaths
--GROUP BY location, population
--ORDER BY population_death_perc DESC

 -- Highest death count per country
SELECT location, MAX(cast(total_deaths AS int)) AS total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent is NOT NULL 
GROUP BY location
ORDER BY total_death_count DESC

-- Highest death count per continent 
SELECT location, MAX(cast(total_deaths AS int)) AS total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent is NULL 
AND location NOT IN ('Upper middle income', 'Lower middle income', 'Low income', 'International', 'High income', 'European Union', 'World')
GROUP BY location
ORDER BY total_death_count DESC

-- Global numbers

SELECT SUM(new_cases) AS total_cases, SUM(cast(new_deaths AS int)) AS total_deaths, SUM(cast(new_deaths AS int))/SUM(new_cases) * 100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL 
--GROUP BY date
ORDER BY 1,2 

-- Total Population vs Vaccination
-- Shows vaccination progress per country 
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
SUM(CONVERT(bigint, v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS vaccination_progress
FROM PortfolioProject..CovidVaccinations AS v
JOIN PortfolioProject..CovidDeaths AS d 
ON v.location = d.location
AND v.date = d.date
WHERE d.continent IS NOT NULL 
ORDER BY 1,2,3 

---- CTE
--WITH VacPop (continent, location, date, population, new_vaccinations, vaccination_progress)
--AS (
--SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
--SUM(CONVERT(bigint, v.new_vaccinations)) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS vaccination_progress
--FROM PortfolioProject..CovidVaccinations AS v
--JOIN PortfolioProject..CovidDeaths AS d 
--ON v.location = d.location
--AND v.date = d.date
--WHERE d.continent IS NOT NULL
----ORDER BY 1,2,3
--)
--SELECT *, (vaccination_progress / population ) * 100 
--FROM VacPop
--WHERE location = 'United States'

-- Total tests per thousand citizens per country
SELECT location, SUM(CAST(new_tests_smoothed_per_thousand AS float)) AS sum_tests_per_thousand
FROM PortfolioProject..CovidVaccinations
WHERE  new_tests_per_thousand IS NOT NULL 
GROUP BY location
ORDER BY sum_tests_per_thousand DESC 
