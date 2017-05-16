USE s17guest04
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[dbBackup]
AS
BEGIN
	SET NOCOUNT ON;

	BACKUP DATABASE [s17guest04] 
		TO DISK = 's17guest04.Bak'
		WITH FORMAT,
			MEDIANAME = 'Z_SQLServerBackups',
			NAME = 's17guest04 Database Backup';
END
