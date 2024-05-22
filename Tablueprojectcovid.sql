 --	SQL Queries for COVID-19 Data Analysis
--Introduction:
---In this project, I've utilized SQL queries to extract insightful information from a dataset containing COVID-19 related data. The queries aim to provide comprehensive insights into the spread and impact of the virus across different regions.
--Queries Overview:
--------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

---1.Global COVID-19 Statistics Query:
---Objective: To calculate the total number of cases, deaths, and the death percentage globally.
--SQL Query:::::::

SELECT 
    SUM(new_cases) AS total_cases,
    SUM(CAST(new_deaths AS INT)) AS total_deaths,
    SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS Deathpercentage
FROM 
    PortfolioProject..coviddeaths
WHERE 
    continent IS NOT NULL
ORDER BY 
    1, 2;
-----------------------------------------------------------------------------------------------

---2.	Regional Death Counts Query:
--Objective: To retrieve the total death count for regions not included in the global statistics.
--SQL Query:::::::
SELECT 
    location,
    SUM(CAST(new_deaths AS INT)) AS totaldeathcount
FROM 
    PortfolioProject..coviddeaths
WHERE 
    continent IS NULL
    AND location NOT IN ('world', 'european union', 'international')
GROUP BY 
    location
ORDER BY 
    totaldeathcount;
----------------------------------------------------------------------------------------------------
--3.Highest Infection Rates by Population Query:
--Objective: To identify regions with the highest infection rates relative to their population.

SELECT 
    location,
    population,
    MAX(total_cases) AS highestinfectioncount,
    MAX((total_cases/population)) * 100 AS percentpopulationinfected
FROM 
    PortfolioProject..coviddeaths
GROUP BY 
    location, population
ORDER BY 
    percentpopulationinfected DESC;
-----------------------------------------------------------------------------------------------------
--4.Temporal Analysis of Infection Rates Query:
--Objective: To analyze the temporal evolution of infection rates in different regions.

SELECT 
    location,
    population,
    date,
    MAX(total_cases) AS highestinfectioncount,
    MAX((total_cases/population)) * 100 AS percentpopulationinfected
FROM 
    PortfolioProject..coviddeaths
GROUP BY 
    location, population, date
ORDER BY 
    percentpopulationinfected DESC;

--Conclusion:
--By leveraging SQL queries, this project offers valuable insights into the global and regional impact of COVID-19.
--From overall statistics to detailed regional analyses, 
--These queries provide a comprehensive understanding of the pandemic's spread and its implications on different populations.   
---------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------










--1.Total Cases vs Total Deaths Over Time:
--This query will provide data on the total number of cases and total number of deaths over time.


SELECT
    dea.date,
    dea.location,
    (SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location) / dea.population) * 100 AS percent_population_vaccinated
FROM
    PortfolioProject..coviddeaths dea
JOIN
    PortfolioProject..covidvac vac ON dea.date = vac.date
                                    AND dea.location = vac.location
WHERE
    dea.continent IS NOT NULL
ORDER BY
    dea.date;

---2.Total Vaccinations Over Time:
---This query will give you data on the total number of vaccinations administered over time.

SELECT
    date,
    SUM(CAST(new_vaccinations AS INT)) AS total_vaccinations
FROM
    PortfolioProject..covidvac
WHERE
    new_vaccinations IS NOT NULL -- Exclude NULL values
GROUP BY
    date
ORDER BY
    date;

--3.Percentage of Population Vaccinated Over Time:
--This query calculates the percentage of the population vaccinated over time.


SELECT
    dea.date,
    dea.location,
    (SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location) / dea.population) * 100 AS percent_population_vaccinated
FROM
    PortfolioProject..coviddeaths dea
JOIN
    PortfolioProject..covidvac vac ON dea.date = vac.date
                                    AND dea.location = vac.location
WHERE
    dea.continent IS NOT NULL
ORDER BY
    dea.date;


----4.Countries with Highest Death Counts:
--This query lists countries with the highest death counts.


SELECT
    location,
    MAX(CAST(total_deaths AS INT)) AS totaldeathcount 
FROM
    PortfolioProject..coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY
    location
ORDER BY
    totaldeathcount DESC;

--	SQL Queries for COVID-19 Data Analysis
--Introduction:
---In this project, I've utilized SQL queries to extract insightful information from a dataset containing COVID-19 related data. The queries aim to provide comprehensive insights into the spread and impact of the virus across different regions.
--Queries Overview:
---1.Global COVID-19 Statistics Query:
---Objective: To calculate the total number of cases, deaths, and the death percentage globally.
--SQL Query:::::::

SELECT 
    SUM(new_cases) AS total_cases,
    SUM(CAST(new_deaths AS INT)) AS total_deaths,
    SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS Deathpercentage
FROM 
    PortfolioProject..coviddeaths
WHERE 
    continent IS NOT NULL
ORDER BY 
    1, 2;


---2.	Regional Death Counts Query:
--Objective: To retrieve the total death count for regions not included in the global statistics.
--SQL Query:::::::
SELECT 
    location,
    SUM(CAST(new_deaths AS INT)) AS totaldeathcount
FROM 
    PortfolioProject..coviddeaths
WHERE 
    continent IS NULL
    AND location NOT IN ('world', 'european union', 'international')
GROUP BY 
    location
ORDER BY 
    totaldeathcount;

--3.Highest Infection Rates by Population Query:
--Objective: To identify regions with the highest infection rates relative to their population.

SELECT 
    location,
    population,
    MAX(total_cases) AS highestinfectioncount,
    MAX((total_cases/population)) * 100 AS percentpopulationinfected
FROM 
    PortfolioProject..coviddeaths
GROUP BY 
    location, population
ORDER BY 
    percentpopulationinfected DESC;

--4.Temporal Analysis of Infection Rates Query:
--Objective: To analyze the temporal evolution of infection rates in different regions.

SELECT 
    location,
    population,
    date,
    MAX(total_cases) AS highestinfectioncount,
    MAX((total_cases/population)) * 100 AS percentpopulationinfected
FROM 
    PortfolioProject..coviddeaths
GROUP BY 
    location, population, date
ORDER BY 
    percentpopulationinfected DESC;

--Conclusion:
--By leveraging SQL queries, this project offers valuable insights into the global and regional impact of COVID-19.
--From overall statistics to detailed regional analyses, 
--These queries provide a comprehensive understanding of the pandemic's spread and its implications on different populations.


















--1.
select sum(new_cases) as total_cases,sum(cast(new_deaths as int)) as total_deaths,sum(cast(new_deaths as int))/sum(new_cases)*100 as
Deathpercentage
from portfolioproject..coviddeaths
where continent is not null
order by 1,2

--2. we take these out as they are not included in the above queries and want to stay consistent
--europe union is part of europe

select location,sum(cast(new_deaths as int)) as totaldeathcount
from PortfolioProject..coviddeaths
where continent is null
and location not in('world','european union','international')
group by location
order by totaldeathcount

--3.
select location,population,max(total_cases)as highestinfectioncount,max((total_cases/population))*100 as percentpopulationinfected
from PortfolioProject..coviddeaths
group by location,population
order by percentpopulationinfected desc

--4.
select location,population,date,max(total_cases)as highestinfectioncount,max((total_cases/population))*100 as percentpopulationinfected
from PortfolioProject..coviddeaths
group by location,population,date
order by percentpopulationinfected desc