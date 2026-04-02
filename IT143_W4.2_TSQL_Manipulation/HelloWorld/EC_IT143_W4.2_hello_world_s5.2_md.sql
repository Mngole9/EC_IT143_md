-- =============================================
-- EC_IT143_W4.2_hello_world_s5.2_md.sql
-- Step 5.2: Refine the table architecture.
-- =============================================

USE mycommunitiesDB;
GO

DROP TABLE IF EXISTS tbl_HelloWorld_CurrentDateTime;

CREATE TABLE tbl_HelloWorld_CurrentDateTime (
    RecordID        INT IDENTITY(1,1) NOT NULL,
    CurrentDateTime DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_HelloWorld_CurrentDateTime 
        PRIMARY KEY CLUSTERED (RecordID)
);