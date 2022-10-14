SELECT location, date, population, total_cases,new_cases, total_deaths
FROM [Covid Analysis]..CovidDeaths
ORDER BY 1,2

UPDATE [Covid Analysis]..CovidDeaths
SET total_deaths = 0
WHERE total_deaths IS NULL


UPDATE [Covid Analysis]..CovidDeaths
SET total_cases = 0
WHERE total_cases IS NULL


SELECT location, population, MAX(total_cases) as HighestInfectedCountry, MAX((total_cases / population)*100) as PercentPopulationInfected
FROM [Covid Analysis]..CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER By PercentPopulationInfected desc

ALTER TABLE [Covid Analysis]..CovidDeaths
ALTER COLUMN total_deaths float;

ALTER TABLE [Covid Analysis]..CovidDeaths
ALTER COLUMN total_deaths_per_million float;

ALTER TABLE [Covid Analysis]..CovidDeaths
ALTER COLUMN new_deaths float;


SELECT continent,location,date,total_tests,new_tests,positive_rate,total_vaccinations,new_vaccinations
FROM [Covid Analysis]..CovidVaccinations

UPDATE [Covid Analysis]..CovidVaccinations
SET total_tests = 0
WHERE total_tests IS NULL

UPDATE [Covid Analysis]..CovidVaccinations
SET positive_rate = 0
WHERE positive_rate IS NULL

UPDATE [Covid Analysis]..CovidVaccinations
SET new_tests = 0
WHERE new_tests IS NULL


ALTER TABLE [Covid Analysis]..CovidVaccinations
ALTER COLUMN total_tests FLOAT;

ALTER TABLE [Covid Analysis]..CovidVaccinations
ALTER COLUMN new_tests FLOAT;

ALTER TABLE [Covid Analysis]..CovidVaccinations
ALTER COLUMN total_vaccinations FLOAT;

ALTER TABLE [Covid Analysis]..CovidVaccinations
ALTER COLUMN new_vaccinations FLOAT;

ALTER TABLE [Covid Analysis]..CovidVaccinations
ALTER COLUMN positive_rate FLOAT;

ALTER TABLE [Covid Analysis]..CovidVaccinations
ALTER COLUMN total_tests FLOAT;