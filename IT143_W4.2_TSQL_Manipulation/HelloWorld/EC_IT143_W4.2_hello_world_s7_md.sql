-- =============================================
-- EC_IT143_W4.2_hello_world_s7_md.sql
-- Step 7: Turn the ad hoc script into a stored procedure.
-- =============================================

USE mycommunitiesDB;
GO

CREATE OR ALTER PROCEDURE usp_HelloWorld_LoadCurrentDateTime
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE tbl_HelloWorld_CurrentDateTime;

    INSERT INTO tbl_HelloWorld_CurrentDateTime (CurrentDateTime)
    SELECT CurrentDateTime
    FROM vw_HelloWorld_CurrentDateTime;

    PRINT 'Hello World table loaded successfully.';
END;