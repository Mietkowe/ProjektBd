USE[GameStatistics]
GO

CREATE TABLE [Players] (
	playerID integer NOT NULL,
	nick varchar(30) NOT NULL UNIQUE,
	age tinyint,
	groupID integer NOT NULL,
	timePlayed integer NOT NULL DEFAULT '0',
	playerLevel integer NOT NULL DEFAULT '1',
  CONSTRAINT [PK_PLAYERS] PRIMARY KEY CLUSTERED
  (
  [playerID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [PlayerGroups] (
	groupID integer NOT NULL,
	name varchar(30) NOT NULL UNIQUE,
  CONSTRAINT [PK_PLAYERGROUPS] PRIMARY KEY CLUSTERED
  (
  [groupID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Games] (
	gameID integer NOT NULL,
	name varchar(30) NOT NULL UNIQUE,
	releaseDate date,
  CONSTRAINT [PK_GAMES] PRIMARY KEY CLUSTERED
  (
  [gameID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [gameTypes] (
	typeID integer NOT NULL,
	name varchar(30) NOT NULL UNIQUE,
  CONSTRAINT [PK_GAMETYPES] PRIMARY KEY CLUSTERED
  (
  [typeID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [sharesTypes] (
	gameID integer NOT NULL,
	typeID integer NOT NULL,
  CONSTRAINT [PK_SHARESTYPES] PRIMARY KEY CLUSTERED
  (
  [gameID],
  [typeID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [owns] (
	gameID integer NOT NULL,
	playerID integer NOT NULL,
	purchaseDate date NOT NULL,
	lastPlayed date NOT NULL,
	timePlayed integer NOT NULL DEFAULT '0',
	personalPreferences text NOT NULL DEFAULT 'No particular preferences',
  CONSTRAINT [PK_OWNS] PRIMARY KEY CLUSTERED
  (
  [gameID],
  [playerID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Achievements] (
	achievementID integer NOT NULL,
	gameID integer NOT NULL,
	name varchar(30) NOT NULL UNIQUE,
	description text NOT NULL DEFAULT '*SECRET*',
	points integer NOT NULL DEFAULT '10',
  CONSTRAINT [PK_ACHIEVEMENTS] PRIMARY KEY CLUSTERED
  (
  [achievementID],
  [gameID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [unlockedAchievements] (
	playerID integer NOT NULL,
	achievementID integer NOT NULL,
	gameID integer NOT NULL,
	unlockDate date NOT NULL,
  CONSTRAINT [PK_UNLOCKEDACHIEVEMENTS] PRIMARY KEY CLUSTERED
  (
  [playerID],
  [achievementID],
  [gameID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Levels] (
	levelID integer NOT NULL,
	gameID integer NOT NULL,
	name varchar(30) NOT NULL,
	description text,
  CONSTRAINT [PK_LEVELS] PRIMARY KEY CLUSTERED
  (
  [levelID],
  [gameID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Aids] (
	AidID integer NOT NULL,
	name varchar(30) NOT NULL UNIQUE,
	description text,
  CONSTRAINT [PK_AIDS] PRIMARY KEY CLUSTERED
  (
  [AidID] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [uses] (
	playerID integer NOT NULL,
	aidID integer NOT NULL,
  CONSTRAINT [PK_USES] PRIMARY KEY CLUSTERED
  (
  [playerID],
  [aidID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [scores] (
	playerID integer NOT NULL,
	levelID integer NOT NULL,
	gameID integer NOT NULL,
	bestResult integer,
  CONSTRAINT [PK_SCORES] PRIMARY KEY CLUSTERED
  (
  [playerID],
  [levelID],
  [gameID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
CREATE TABLE [Reviews] (
	playerID integer NOT NULL,
	gameID integer NOT NULL,
	rating tinyint NOT NULL,
	comment text NOT NULL DEFAULT 'No Comment',
  CONSTRAINT [PK_REVIEWS] PRIMARY KEY CLUSTERED
  (
  [playerID],
  [gameID]
  ) WITH (IGNORE_DUP_KEY = OFF)

)
GO
ALTER TABLE [Players] WITH CHECK ADD CONSTRAINT [Players_fk0] FOREIGN KEY ([groupID]) REFERENCES [PlayerGroups]([groupID])
ON UPDATE CASCADE
GO
ALTER TABLE [Players] CHECK CONSTRAINT [Players_fk0]
GO




ALTER TABLE [sharesTypes] WITH CHECK ADD CONSTRAINT [sharesTypes_fk0] FOREIGN KEY ([gameID]) REFERENCES [Games]([gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [sharesTypes] CHECK CONSTRAINT [sharesTypes_fk0]
GO
ALTER TABLE [sharesTypes] WITH CHECK ADD CONSTRAINT [sharesTypes_fk1] FOREIGN KEY ([typeID]) REFERENCES [gameTypes]([typeID])
ON UPDATE CASCADE
GO
ALTER TABLE [sharesTypes] CHECK CONSTRAINT [sharesTypes_fk1]
GO

ALTER TABLE [owns] WITH CHECK ADD CONSTRAINT [owns_fk0] FOREIGN KEY ([gameID]) REFERENCES [Games]([gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [owns] CHECK CONSTRAINT [owns_fk0]
GO
ALTER TABLE [owns] WITH CHECK ADD CONSTRAINT [owns_fk1] FOREIGN KEY ([playerID]) REFERENCES [Players]([playerID])
ON UPDATE CASCADE
GO
ALTER TABLE [owns] CHECK CONSTRAINT [owns_fk1]
GO

ALTER TABLE [Achievements] WITH CHECK ADD CONSTRAINT [Achievements_fk0] FOREIGN KEY ([gameID]) REFERENCES [Games]([gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [Achievements] CHECK CONSTRAINT [Achievements_fk0]
GO

ALTER TABLE [unlockedAchievements] WITH CHECK ADD CONSTRAINT [unlockedAchievements_fk0] FOREIGN KEY ([playerID]) REFERENCES [Players]([playerID])
ON UPDATE CASCADE
GO
ALTER TABLE [unlockedAchievements] CHECK CONSTRAINT [unlockedAchievements_fk0]
GO
ALTER TABLE [unlockedAchievements] WITH CHECK ADD CONSTRAINT [unlockedAchievements_fk1] FOREIGN KEY ([achievementID], [gameID]) REFERENCES [Achievements]([achievementID], [gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [unlockedAchievements] CHECK CONSTRAINT [unlockedAchievements_fk1]
GO

ALTER TABLE [Levels] WITH CHECK ADD CONSTRAINT [Levels_fk0] FOREIGN KEY ([gameID]) REFERENCES [Games]([gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [Levels] CHECK CONSTRAINT [Levels_fk0]
GO


ALTER TABLE [uses] WITH CHECK ADD CONSTRAINT [uses_fk0] FOREIGN KEY ([playerID]) REFERENCES [Players]([playerID])
ON UPDATE CASCADE
GO
ALTER TABLE [uses] CHECK CONSTRAINT [uses_fk0]
GO
ALTER TABLE [uses] WITH CHECK ADD CONSTRAINT [uses_fk1] FOREIGN KEY ([aidID]) REFERENCES [Aids]([AidID])
ON UPDATE CASCADE
GO
ALTER TABLE [uses] CHECK CONSTRAINT [uses_fk1]
GO

ALTER TABLE [scores] WITH CHECK ADD CONSTRAINT [scores_fk0] FOREIGN KEY ([playerID]) REFERENCES [Players]([playerID])
ON UPDATE CASCADE
GO
ALTER TABLE [scores] CHECK CONSTRAINT [scores_fk0]
GO
ALTER TABLE [scores] WITH CHECK ADD CONSTRAINT [scores_fk1] FOREIGN KEY ([levelID], [gameID]) REFERENCES [Levels]([levelID], [gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [scores] CHECK CONSTRAINT [scores_fk1]
GO


ALTER TABLE [Reviews] WITH CHECK ADD CONSTRAINT [Reviews_fk0] FOREIGN KEY ([playerID]) REFERENCES [Players]([playerID])
ON UPDATE CASCADE
GO
ALTER TABLE [Reviews] CHECK CONSTRAINT [Reviews_fk0]
GO
ALTER TABLE [Reviews] WITH CHECK ADD CONSTRAINT [Reviews_fk1] FOREIGN KEY ([gameID]) REFERENCES [Games]([gameID])
ON UPDATE CASCADE
GO
ALTER TABLE [Reviews] CHECK CONSTRAINT [Reviews_fk1]
GO


INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (1, 1, N'Beginner', N'Die once', 10)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (1, 2, N'Adventure awaits', N'Finish first level', 50)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (1, 3, N'Messi', N'*Secret*', 50)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (1, 4, N'Prodigy', N'Win a race with Fiat 126p', 126)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (1, 5, N'Domination', N'*Secret*', 50)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (2, 1, N'Immortal', N'Finish game without dying', 200)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (2, 2, N'Sharpshooter', N'Kill 10 thugs with headshots', 50)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (2, 3, N'Ronaldo', N'*Secret*', 50)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (2, 4, N'Luxury', N'Buy first A class car', 10)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (2, 5, N'Last hope', N'Win a game with no towers left', 100)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (3, 1, N'Finally', N'Finish the game', 30)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (3, 2, N'Nathan Drake', N'Finish the game', 100)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (3, 3, N'Bloody match', N'Get 5 red cards in a single match', 50)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (3, 4, N'Retirement', N'Finish the campaign', 100)
INSERT [dbo].[Achievements] ([achievementID], [gameID], [name], [description], [points]) VALUES (3, 5, N'Justice Warrior', N'Send a report that will result in permanent ban', 10)
INSERT [dbo].[Aids] ([AidID], [name], [description]) VALUES (1, N'VR', N'Virtual Reality Headset')
INSERT [dbo].[Aids] ([AidID], [name], [description]) VALUES (2, N'Professional Devices', N'Any kind of gaming mouse, keyboard or pad')
INSERT [dbo].[Aids] ([AidID], [name], [description]) VALUES (3, N'Streaming', N'Streaming Software')
INSERT [dbo].[Aids] ([AidID], [name], [description]) VALUES (4, N'Cheats', N'Any kind of cheats including game-in codes and aid software')
INSERT [dbo].[Aids] ([AidID], [name], [description]) VALUES (5, N'AV boosts', N'High resolution screens or high quality speakers/headphones')
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (1, N'Dark Souls', CAST(N'2008-05-16' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (2, N'Uncharted', CAST(N'2009-12-09' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (3, N'FIFA 17', CAST(N'2016-07-08' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (4, N'Need for Speed: Most Wanted', CAST(N'2014-02-15' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (5, N'League of Legends', CAST(N'2010-01-29' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (6, N'Witcher 3: Wild Hunt', CAST(N'2015-08-25' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (7, N'Company of Heroes', CAST(N'2012-11-11' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (8, N'Little Big Planet', CAST(N'2012-03-14' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (9, N'Civilization VI', CAST(N'2017-06-14' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (10, N'Pure Farming 2018', CAST(N'2018-01-06' AS Date))
INSERT [dbo].[Games] ([gameID], [name], [releaseDate]) VALUES (11, N'Call of Duty: World War II', CAST(N'2018-05-13' AS Date))
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (3, N'Action/Adventure')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (12, N'Family')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (2, N'FPS')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (11, N'MultiPlayer')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (7, N'Platformer')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (8, N'Puzzle')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (4, N'Racing')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (1, N'RPG')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (6, N'Simulation')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (10, N'SinglePlayer')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (9, N'Sport')
INSERT [dbo].[gameTypes] ([typeID], [name]) VALUES (5, N'Strategy')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 1, N'Cementary', N'Number of dies')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 2, N'Shipyard', N'Number of kills')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 3, N'BestMatch', N'+- ratio of the best match')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 4, N'Race1', N'Best Time')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 5, N'Fastest Game', N'least time to win a PvP game')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 6, N'MaxCharLevel', N'Highest Achieved Character Level')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 7, N'Map1 Time', N'Best Time')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 8, N'Map1 Score', N'Best Score')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 9, N'Fastest Win', N'Number of turns before win')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 10, N'Best income', N'Highest 30-days perido income')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (1, 11, N'D-Day', N'Number of kills')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (2, 1, N'City', N'Number of dies')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (2, 2, N'Jungle', N'Number of kills')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (2, 4, N'Race2', N'Best Time')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (2, 7, N'Map2 Time', N'Best Time')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (2, 8, N'Map2 Score', N'Best Score')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (2, 11, N'Normandy', N'Number of kills')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (3, 4, N'Race3', N'Best Time')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (3, 7, N'Map3 Time', N'Best Time')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (3, 8, N'Map3 Score', N'Best Score')
INSERT [dbo].[Levels] ([levelID], [gameID], [name], [description]) VALUES (3, 11, N'Carentan', N'Number of kills')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (1, 5, CAST(N'2017-04-01' AS Date), CAST(N'2017-06-12' AS Date), 12, N'No particular preferences')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (2, 1, CAST(N'2018-01-12' AS Date), CAST(N'2018-07-03' AS Date), 20, N'No particular preferences')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (3, 3, CAST(N'2017-08-21' AS Date), CAST(N'2018-06-12' AS Date), 152, N'No particular preferences')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (4, 9, CAST(N'2017-08-21' AS Date), CAST(N'2017-08-22' AS Date), 4, N'No assistance')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (5, 2, CAST(N'2017-08-01' AS Date), CAST(N'2017-08-21' AS Date), 100, N'No Smart Casts')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (5, 9, CAST(N'2016-12-31' AS Date), CAST(N'2018-06-25' AS Date), 120, N'No particular preferences')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (5, 12, CAST(N'2009-12-12' AS Date), CAST(N'2016-12-31' AS Date), 185, N'Windowed Mode')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (6, 6, CAST(N'2017-07-01' AS Date), CAST(N'2017-07-03' AS Date), 48, N'Nightmare mode')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (7, 7, CAST(N'2015-09-12' AS Date), CAST(N'2015-10-23' AS Date), 120, N'No particular preferences')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (8, 5, CAST(N'2017-02-28' AS Date), CAST(N'2018-01-01' AS Date), 512, N'Keyboard instead of pad')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (9, 8, CAST(N'2017-02-12' AS Date), CAST(N'2017-04-01' AS Date), 562, N'With help boxes')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (10, 10, CAST(N'2017-08-22' AS Date), CAST(N'2018-07-03' AS Date), 12415, N'VR only')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (11, 4, CAST(N'2017-02-19' AS Date), CAST(N'2018-03-12' AS Date), 152, N'No particular preferences')
INSERT [dbo].[owns] ([gameID], [playerID], [purchaseDate], [lastPlayed], [timePlayed], [personalPreferences]) VALUES (11, 11, CAST(N'2017-08-19' AS Date), CAST(N'2017-08-30' AS Date), 185, N'No particular preferences')
INSERT [dbo].[PlayerGroups] ([groupID], [name]) VALUES (2, N'Casual')
INSERT [dbo].[PlayerGroups] ([groupID], [name]) VALUES (4, N'Hardcore Gamer')
INSERT [dbo].[PlayerGroups] ([groupID], [name]) VALUES (1, N'Hobbyst')
INSERT [dbo].[PlayerGroups] ([groupID], [name]) VALUES (3, N'Nerd')
INSERT [dbo].[PlayerGroups] ([groupID], [name]) VALUES (5, N'Non-Gamer')
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (1, N'igorz24', 21, 1, 20, 2)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (2, N'robost', 22, 4, 123, 5)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (3, N'szymmik', 19, 2, 212, 6)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (4, N'marcpaj', 35, 2, 124, 5)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (5, N'jankow', 53, 3, 2115, 20)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (6, N'masterDestroyer', 7, 4, 12415, 30)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (7, N'anon15', 36, 3, 467, 11)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (8, N'wygryw122', 15, 2, 1421, 16)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (9, N'olka98', 20, 2, 124, 5)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (10, N'dżony99', 19, 1, 289, 7)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (11, N'karmazynowy01', 40, 2, 185, 6)
INSERT [dbo].[Players] ([playerID], [nick], [age], [groupID], [timePlayed], [playerLevel]) VALUES (12, N'Qra', 29, 5, 1200, 14)
INSERT [dbo].[Reviews] ([playerID], [gameID], [rating], [comment]) VALUES (2, 5, 75, N'Good game, had lot of fun')
INSERT [dbo].[Reviews] ([playerID], [gameID], [rating], [comment]) VALUES (4, 11, 35, N'Piece of crap, can''t hold stable 15 FPS')
INSERT [dbo].[Reviews] ([playerID], [gameID], [rating], [comment]) VALUES (9, 5, 40, N'Noobs everywhere!!!11oneoneone')
INSERT [dbo].[Reviews] ([playerID], [gameID], [rating], [comment]) VALUES (10, 10, 100, N'Very dynamic gameplay')
INSERT [dbo].[Reviews] ([playerID], [gameID], [rating], [comment]) VALUES (11, 11, 80, N'Decent title')
INSERT [dbo].[Reviews] ([playerID], [gameID], [rating], [comment]) VALUES (12, 5, 95, N'GOTY!')
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (1, 1, 2, 23)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (1, 2, 2, 32)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (2, 1, 5, 1200)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (3, 1, 3, 12)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (4, 1, 11, 145)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (4, 2, 11, 189)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (5, 1, 1, 20)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (5, 1, 8, 589)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (5, 2, 1, 56)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (6, 1, 6, 37)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (7, 1, 7, 1456)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (7, 2, 7, 2456)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (9, 1, 4, 234)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (9, 1, 5, 1167)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (9, 1, 8, 244)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (10, 1, 10, 30457)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (11, 1, 11, 124)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (11, 2, 11, 214)
INSERT [dbo].[scores] ([playerID], [levelID], [gameID], [bestResult]) VALUES (12, 1, 5, 1252)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (1, 1)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (1, 3)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (1, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (2, 3)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (2, 8)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (2, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (3, 9)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (3, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (3, 11)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (3, 12)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (4, 4)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (4, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (4, 11)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (5, 5)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (5, 11)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (6, 1)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (6, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (7, 5)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (7, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (7, 11)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (8, 7)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (8, 8)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (8, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (8, 11)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (8, 12)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (9, 5)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (9, 6)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (9, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (9, 11)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (10, 6)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (10, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (11, 2)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (11, 10)
INSERT [dbo].[sharesTypes] ([gameID], [typeID]) VALUES (11, 11)
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (1, 1, 2, CAST(N'2017-08-21' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (1, 2, 2, CAST(N'2017-08-23' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (2, 1, 5, CAST(N'2017-08-24' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (2, 2, 5, CAST(N'2016-12-01' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (3, 3, 3, CAST(N'2015-12-21' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (5, 1, 1, CAST(N'2016-08-21' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (9, 2, 4, CAST(N'2016-03-21' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (9, 2, 5, CAST(N'2017-06-21' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (9, 3, 5, CAST(N'2015-08-21' AS Date))
INSERT [dbo].[unlockedAchievements] ([playerID], [achievementID], [gameID], [unlockDate]) VALUES (12, 3, 5, CAST(N'2017-01-21' AS Date))
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (1, 4)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (1, 5)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (2, 4)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (3, 4)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (4, 2)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (5, 1)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (6, 1)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (6, 2)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (6, 5)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (9, 3)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (10, 3)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (10, 5)
INSERT [dbo].[uses] ([playerID], [aidID]) VALUES (12, 1)