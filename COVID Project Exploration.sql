--SELECT * FROM [Covid Analysis]..CovidDeaths
--ORDER BY 3,4


--SELECT * FROM [Covid Analysis]..CovidVaccinations
--ORDER BY 3,4

-- Select data that we need to use
SELECT location, date, population, total_cases,new_cases, total_deaths
FROM [Covid Analysis]..CovidDeaths
ORDER BY 1,2

-- Total Cases VS Total Deaths
-- Shows the Percentage of dying if u infected with covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths / total_cases)*100 as per_of_total_deaths
FROM [Covid Analysis]..CovidDeaths
WHERE location = 'Egypt'
and continent is not null
ORDER BY 1,2

-- Total Cases VS Population
-- Shows the Percentage of infect with covid in your country
SELECT location, date, total_cases, population, (total_cases / population)*100 as per_of_total_infected
FROM [Covid Analysis]..CovidDeaths
--WHERE location = 'Egypt'
--and continent is not null
ORDER By 1,2

-- Highest Infected Country & Its Percentage
SELECT location, population, MAX(total_cases) as HighestInfectedCountry, MAX((total_cases / population)*100) as PercentPopulationInfected
FROM [Covid Analysis]..CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER By PercentPopulationInfected desc

-- Highest TotalDeath Country per Population
SELECT location, population, MAX(CAST (total_deaths as int)) as HighestDeathCount
FROM [Covid Analysis]..CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER By HighestDeathCount desc

-- Highest TotalDeath Continent
SELECT continent, MAX(CAST (total_deaths as int)) as HighestDeathCount
FROM [Covid Analysis]..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER By HighestDeathCount desc

-- GLOBAL NUMBERS
SELECT SUM(new_cases) as TotalCases, SUM(CAST(new_deaths AS float)) as TotalDeaths,
SUM(CAST(new_deaths AS float)) / SUM(new_cases) *100 as per_of_total_deaths
FROM [Covid Analysis]..CovidDeaths
WHERE continent is not null


-- see total vaccinated
-- Total Population VS Vaccinations

SELECT CovidDeaths.continent,CovidDeaths.location ,CovidDeaths.date,CovidDeaths.population,Covidvaccinations.new_vaccinations
-- partition for NOT start count over every time gets anew location
-- order by location to avoid conflict numbers and been proper
, SUM(CAST(Covidvaccinations.new_vaccinations AS int)) OVER (Partition by CovidDeaths.location ORDER BY CovidDeaths.location
, CovidDeaths.date) as PeopleVaccinated
FROM [Covid Analysis]..CovidDeaths
Join [Covid Analysis]..Covidvaccinations
ON CovidDeaths.location = Covidvaccinations.location 
and CovidDeaths.date = Covidvaccinations.date 
WHERE CovidDeaths.continent is not null
ORDER BY 2,3