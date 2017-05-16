USE s17guest04
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[selectSpeakersPresentation]
	@speaker nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @first_name nvarchar(50)
	DECLARE @last_name nvarchar(50)
	SET @first_name = SUBSTRING(@speaker, 1, CHARINDEX(' ', @speaker) - 1);
	SET @last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1, CHARINDEX(' ', REVERSE(@speaker)) - 1));

	SELECT Persons.FirstName, Persons.LastName, Classes.Title
	FROM Classes
	LEFT JOIN Presenters ON Presenters.PresenterID = Classes.PresenterID
	LEFT JOIN Persons ON Persons.PersonID = Presenters.PersonID
	WHERE Persons.FirstName = @first_name AND Persons.LastName = @last_name

END