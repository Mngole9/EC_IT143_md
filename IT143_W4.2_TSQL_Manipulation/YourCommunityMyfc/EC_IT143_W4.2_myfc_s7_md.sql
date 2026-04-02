-- =============================================
-- EC_IT143_W4.2_myfc_s7_md.sql
-- Step 7: Turn the ad hoc script into a stored procedure.
-- =============================================

USE mycommunitiesDB;
GO

CREATE OR ALTER PROCEDURE usp_MyFC_LoadPlayersByTeam
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE tbl_MyFC_PlayersByTeam;

    INSERT INTO tbl_MyFC_PlayersByTeam (TeamCode, NumberOfPlayers)
    SELECT TeamCode, NumberOfPlayers
    FROM vw_MyFC_PlayersByTeam;

    PRINT 'MyFC PlayersByTeam table loaded successfully.';
END;