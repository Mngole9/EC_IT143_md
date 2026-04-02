-- =============================================
-- EC_IT143_W4.2_hello_world_s5.1_md.sql
-- Step 5.1: Turn the view into a table.
-- =============================================

USE mycommunitiesDB;
GO

SELECT * 
INTO tbl_HelloWorld_CurrentDateTime
FROM vw_HelloWorld_CurrentDateTime;