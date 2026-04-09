USE Mydatabase;
GO

/*
Name: Mangole Dorothy
Class: IT143
Assignment: 5.2 My Communities Analysis – Create Answers
Community: Flower and Soil Monitoring
Date: April 2026
Description: This script answers four questions about flower ground cover and its impact on soil erosion and pollution reduction.
*/

-- Question 1 (Author: Me)
-- What is the average ground cover percentage per flower species?
SELECT 
    f.Species,
    AVG(f.GroundCover_Percent) AS AvgGroundCoverPercent,
    COUNT(f.FlowerID) AS NumberOfFlowers
FROM Flowers f
GROUP BY f.Species
ORDER BY AvgGroundCoverPercent DESC;

-- Question 2 (Author: Me)
-- Which locations show the highest soil loss and how does flower ground cover relate?
SELECT 
    s.LocationID,
    AVG(s.SoilLoss_tons_per_year) AS AvgSoilLoss,
    AVG(f.GroundCover_Percent) AS AvgGroundCoverPercent,
    AVG(s.Pollutant_ppm) AS AvgPollutant
FROM SoilTests s
LEFT JOIN Flowers f ON s.LocationID = f.LocationID
GROUP BY s.LocationID
ORDER BY AvgSoilLoss DESC;

-- Question 3 (Author: Me)
-- What is the relationship between rainfall and pollutant levels?
SELECT 
    s.LocationID,
    AVG(s.Rainfall_mm) AS AvgRainfall_mm,
    AVG(s.Pollutant_ppm) AS AvgPollutant_ppm
FROM SoilTests s
GROUP BY s.LocationID
ORDER BY AvgPollutant_ppm DESC;

-- Question 4 (Author: Elijah Jefia)
-- How do tree species and flower ground cover together affect pollution reduction?
SELECT 
    t.Species AS TreeSpecies,
    AVG(f.GroundCover_Percent) AS AvgFlowerCover,
    AVG(s.Pollutant_ppm) AS AvgPollutant
FROM Trees t
JOIN SoilTests s ON t.LocationID = s.LocationID
LEFT JOIN Flowers f ON s.LocationID = f.LocationID
GROUP BY t.Species
ORDER BY AvgPollutant ASC;