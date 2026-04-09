USE Mydatabase;
GO

/*
Name: Mangole Dorothy
Class: IT143
Assignment: 5.2 My Communities Analysis – Create Answers
Community: Tree Planting Records
Date: April 2026
Description: This script answers four questions about tree planting for soil erosion prevention and CO2 absorption.
*/

-- Question 1 (Author: Elijah Jefia)
-- How do different tree species affect soil erosion and pollution reduction across locations?
SELECT 
    t.Species,
    AVG(t.RootDepth_cm) AS AvgRootDepth_cm,
    AVG(t.CO2Absorbed_kg) AS AvgCO2Absorbed_kg,
    AVG(s.SoilLoss_tons_per_year) AS AvgSoilLoss,
    AVG(s.Pollutant_ppm) AS AvgPollutant_ppm
FROM Trees t
JOIN SoilTests s ON t.LocationID = s.LocationID
GROUP BY t.Species
ORDER BY AvgCO2Absorbed_kg DESC;

-- Question 2 (Author: Miebaka Okujagu)
-- Which tree species grows the tallest in each location?
SELECT 
    t.LocationID,
    t.Species,
    MAX(t.Height_cm) AS MaxHeight_cm,
    AVG(t.SurvivalRate) AS AvgSurvivalRate
FROM Trees t
GROUP BY t.LocationID, t.Species
ORDER BY MaxHeight_cm DESC;

-- Question 3 (Author: Mildred Sithole)
-- Which tree species have the highest survival rate and CO2 absorption combined?
SELECT 
    t.Species,
    AVG(t.SurvivalRate) AS AvgSurvivalRate,
    AVG(t.CO2Absorbed_kg) AS AvgCO2Absorbed_kg,
    (AVG(t.SurvivalRate) * AVG(t.CO2Absorbed_kg)) AS CombinedScore
FROM Trees t
GROUP BY t.Species
ORDER BY CombinedScore DESC;

-- Question 4 (Author: Me)
-- What is the average number of volunteers per planting event on slopes greater than 15 degrees?
SELECT 
    AVG(pe.Volunteers) AS AvgVolunteers,
    COUNT(pe.EventID) AS NumberOfEvents
FROM PlantingEvents pe
WHERE pe.Slope_Degree > 15;