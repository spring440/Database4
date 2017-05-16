USE s17guest04
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[selectPresentationsPerTrack]
	
	@track nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Tracks.TrackID, Classes.Title, [Events].EventName, Addresses.City
	FROM Classes
	INNER JOIN Tracks ON Tracks.TrackID = Classes.TrackID
	INNER JOIN Rooms ON Rooms.RoomID = Classes.RoomID
	INNER JOIN Addresses ON Addresses.AddressID = Rooms.RoomID
	INNER JOIN [Events] ON [Events].AddressID = Addresses.AddressID
	WHERE Tracks.TrackID = @track
	AND Addresses.City = 'Budapest'
    
END