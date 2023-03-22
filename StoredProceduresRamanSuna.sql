USE Northwind;

-------------------------------------------------------------------

DROP PROC IF EXISTS spInsertRegions;
GO 
CREATE PROC spInsertRegion
(@RegionDescription VARCHAR(50))
AS
INSERT INTO Region (RegionID, RegionDescription)
VALUES ((SELECT MAX(RegionID) FROM Region) + 1, @RegionDescription);
GO

-------------------------------------------------------------------

DROP PROC IF EXISTS spUpdateRegion;
GO 
CREATE PROC spUpdateRegion
(@RegionID INT, @NewRegionDescription VARCHAR(50))
AS
UPDATE Region
SET    RegionDescription = @NewRegionDescription
WHERE  RegionID = @RegionID
GO

-------------------------------------------------------------------

DROP PROC IF EXISTS spDeleteRegion;
GO 
CREATE PROC spDeleteRegion
(@RegionDescription VARCHAR(50))
AS
DECLARE @DelRegionID AS INT;
SELECT @DelRegionID = MIN(RegionID) FROM Region WHERE RegionDescription = @RegionDescription;

DELETE EmployeeTerritories
FROM EmployeeTerritories INNER JOIN Territories ON EmployeeTerritories.TerritoryID=Territories.TerritoryID WHERE RegionID = @DelRegionID;

DELETE FROM Territories WHERE RegionID = @DelRegionID;
DELETE FROM Region WHERE RegionID = @DelRegionID;
GO

-------------------------------------------------------------------

DROP PROC IF EXISTS spSelectRegion;
GO 
CREATE PROC spSelectRegion 
(@RegionDescription VARCHAR(50))
AS
SELECT RegionID, RegionDescription FROM Region 
WHERE RegionDescription = @RegionDescription AND RegionID = (SELECT MIN(RegionID) FROM Region WHERE RegionDescription = @RegionDescription)
GO

-------------------------------------------------------------------

DROP PROC IF EXISTS spSelectAllRegions;
GO 
CREATE PROC spSelectAllRegions 
AS
SELECT RegionID, RegionDescription FROM Region ORDER BY RegionID;