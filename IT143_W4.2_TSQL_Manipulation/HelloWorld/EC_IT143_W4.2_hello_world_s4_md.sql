-- =============================================
-- EC_IT143_W4.2_hello_world_s4_md.sql
-- Step 4: Turn the ad hoc SQL query into a view.
-- Author: Mangole Dorothy
-- Date: April 2026
-- Description: This view returns the current server date and time.
-- =============================================

USE mycommunitiesDB;
GO

CREATE OR ALTER VIEW vw_HelloWorld_CurrentDateTime
AS
SELECT GETDATE() AS CurrentDateTime;