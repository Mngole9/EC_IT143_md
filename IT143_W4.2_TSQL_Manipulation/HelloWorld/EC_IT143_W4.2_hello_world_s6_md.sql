-- =============================================
-- EC_IT143_W4.2_hello_world_s6_md.sql
-- Step 6: Load the table from the view.
-- =============================================

USE mycommunitiesDB;
GO

TRUNCATE TABLE tbl_HelloWorld_CurrentDateTime;

INSERT INTO tbl_HelloWorld_CurrentDateTime (CurrentDateTime)
SELECT CurrentDateTime
FROM vw_HelloWorld_CurrentDateTime;