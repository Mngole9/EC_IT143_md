-- =============================================
-- EC_IT143_W4.2_simpsons_s5.2_md.sql
-- Step 5.2: Refine the table architecture.
-- =============================================

USE mycommunitiesDB;
GO

DROP TABLE IF EXISTS tbl_Simpsons_CharactersByDepartment;

CREATE TABLE tbl_Simpsons_CharactersByDepartment (
    CharCountID         INT IDENTITY(1,1) NOT NULL,
    Department          VARCHAR(100) NOT NULL,
    NumberOfCharacters  INT NOT NULL,
    CONSTRAINT PK_Simpsons_CharactersByDepartment 
        PRIMARY KEY CLUSTERED (CharCountID)
);