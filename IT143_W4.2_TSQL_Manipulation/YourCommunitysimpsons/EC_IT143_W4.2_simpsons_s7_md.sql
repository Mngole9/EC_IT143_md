-- =============================================
-- EC_IT143_W4.2_simpsons_s7_md.sql
-- Step 7: Turn the ad hoc script into a stored procedure.
-- =============================================

USE mycommunitiesDB;
GO

CREATE OR ALTER PROCEDURE usp_Simpsons_LoadCharactersByDepartment
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE tbl_Simpsons_CharactersByDepartment;

    INSERT INTO tbl_Simpsons_CharactersByDepartment (Department, NumberOfCharacters)
    SELECT Department, NumberOfCharacters
    FROM vw_Simpsons_CharactersByDepartment;

    PRINT 'Simpsons CharactersByDepartment table loaded successfully.';
END;