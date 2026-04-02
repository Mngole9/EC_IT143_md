-- =============================================
-- EC_IT143_W4.2_myfc_s5.2_md.sql
-- Step 5.2: Refine the table architecture.
-- Author: Mangole Dorothy
-- Date: April 2026
-- =============================================

USE mycommunitiesDB;
GO

DROP TABLE IF EXISTS tbl_MyFC_PlayersByTeam;

CREATE TABLE tbl_MyFC_PlayersByTeam (
    PlayerCountID   INT IDENTITY(1,1) NOT NULL,
    TeamCode        VARCHAR(50) NOT NULL,
    NumberOfPlayers INT NOT NULL,
    CONSTRAINT PK_MyFC_PlayersByTeam 
        PRIMARY KEY CLUSTERED (PlayerCountID)
);