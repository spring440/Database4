USE s17guest04
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[insertPresentation]
	@speaker nvarchar(100), 
	@presentation nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
		
		DECLARE @first_name nvarchar(50)
		DECLARE @last_name nvarchar(50)
		SET @first_name = SUBSTRING(@speaker, 1, CHARINDEX(' ', @speaker) - 1);
		SET @last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1, CHARINDEX(' ', REVERSE(@speaker)) - 1));

		IF EXISTS(SELECT Title FROM Classes WHERE Title = @presentation)
		BEGIN
			PRINT 'ERROR'
			RETURN
		END

		IF NOT EXISTS(SELECT FirstName, LastName FROM Persons WHERE FirstName = @first_name AND LastName = @last_name)
		BEGIN
			
			INSERT INTO Persons VALUES (NULL, NULL, NULL, NULL, NULL, @first_name, @last_name, NULL, NULL);
		END
		
		DECLARE @personID int
		SELECT 
			@personID = PersonID
			FROM Persons 
			WHERE FirstName = @first_name AND LastName = @last_name;

		IF NOT EXISTS(SELECT PersonID FROM Presenters WHERE PersonID = @personID)
		BEGIN
			INSERT INTO Presenters VALUES (@personID, NULL);

			UPDATE q
			SET q.PresenterID = a.PresenterID
			FROM Persons q
			INNER JOIN Presenters a
			ON q.PersonID = a.PersonID;
		END

		DECLARE @presenterID int
		SELECT
			@presenterID = PresenterID
			FROM Presenters
			WHERE PersonID = @personID;

		INSERT INTO Classes VALUES (@presentation, NULL, NULL, NULL, NULL, NULL, NULL, NULL, @presenterID, NULL);

	END TRY
	BEGIN CATCH
		PRINT 'ERROR'
	END CATCH
END
