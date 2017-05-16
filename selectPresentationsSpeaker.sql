USE s17guest04
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[selectPresentationsSpeaker]

	@presentation nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT Classes.Title, Persons.FirstName, Persons.LastName
	FROM Classes
	LEFT JOIN Presenters ON Presenters.PresenterID = Classes.PresenterID
	LEFT JOIN Persons ON Persons.PersonID = Presenters.PersonID
	WHERE Classes.Title = @presentation

END