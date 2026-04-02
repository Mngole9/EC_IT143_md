-- =============================================
-- EC_IT143_W4.2_simpsons_s6_md.sql
-- Step 6: Load the table from the view.
-- =============================================

USE mycommunitiesDB;
GO

TRUNCATE TABLE tbl_Simpsons_CharactersByDepartment;

INSERT INTO tbl_Simpsons_CharactersByDepartment (Department, NumberOfCharacters)
SELECT Department, NumberOfCharacters
FROM vw_Simpsons_CharactersByDepartment;