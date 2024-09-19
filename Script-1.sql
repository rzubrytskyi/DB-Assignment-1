CREATE DATABASE P01;

USE P01;

CREATE TABLE Coaches (
    CoachID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50)
);

CREATE TABLE Teams (
    TeamID INT AUTO_INCREMENT PRIMARY KEY,
    TeamName VARCHAR(100),
    CoachID INT,
    FOREIGN KEY (CoachID) REFERENCES Coaches(CoachID)
);

CREATE TABLE Players (
    PlayerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Teams(TeamID)
);

CREATE TABLE Matches (
    MatchID INT AUTO_INCREMENT PRIMARY KEY,
    HomeTeamID INT,
    AwayTeamID INT,
    MatchDate DATE,
    FOREIGN KEY (HomeTeamID) REFERENCES Teams(TeamID),
    FOREIGN KEY (AwayTeamID) REFERENCES Teams(TeamID)
);

CREATE TABLE PlayerStats (
    StatID INT AUTO_INCREMENT PRIMARY KEY,
    PlayerID INT,
    MatchID INT,
    PointsScored INT,
    Rebounds INT,
    Assists INT,
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

INSERT INTO Coaches (FirstName, LastName) VALUES
('Mike', 'Smith'),
('Sarah', 'Johnson'),
('Robert', 'Williams'),
('David', 'Clark'),
('Emma', 'Lewis'),
('Michael', 'Hall');

INSERT INTO Teams (TeamName, CoachID) VALUES
('Eagles', 1),
('Tigers', 2),
('Wolves', 3),
('Sharks', 4),
('Bears', 5),
('Lions', 6);

INSERT INTO Players (FirstName, LastName, TeamID) VALUES
('John', 'Doe', 1),
('Jane', 'Smith', 1),
('Alice', 'Johnson', 2),
('Bob', 'Brown', 2),
('Charlie', 'Davis', 3),
('Eve', 'Miller', 3),
('David', 'Taylor', 4),
('Chris', 'Walker', 4),
('Nina', 'Adams', 5),
('Oliver', 'Evans', 5),
('Sophia', 'Baker', 6),
('Liam', 'Hill', 6);

INSERT INTO Matches (HomeTeamID, AwayTeamID, MatchDate) VALUES
(1, 2, '2024-09-01'),
(2, 3, '2024-09-02'),
(3, 1, '2024-09-03'),
(4, 5, '2024-09-04'),
(5, 6, '2024-09-05'),
(6, 4, '2024-09-06');

INSERT INTO PlayerStats (PlayerID, MatchID, PointsScored, Rebounds, Assists) VALUES
(1, 1, 20, 5, 7),
(2, 1, 15, 3, 4), 
(3, 1, 22, 6, 5), 
(4, 1, 10, 4, 2), 
(3, 2, 18, 7, 6), 
(4, 2, 12, 5, 3), 
(5, 2, 25, 8, 7), 
(6, 2, 20, 6, 5), 
(5, 3, 30, 9, 8), 
(6, 3, 15, 4, 4), 
(1, 3, 18, 5, 6), 
(2, 3, 14, 3, 5), 
(7, 4, 18, 6, 4), 
(8, 4, 20, 7, 5), 
(9, 4, 15, 5, 3), 
(10, 4, 12, 4, 2), 
(9, 5, 22, 8, 6), 
(10, 5, 18, 6, 4), 
(11, 5, 30, 10, 8), 
(12, 5, 25, 9, 7),
(11, 6, 28, 11, 9), 
(12, 6, 20, 8, 6), 
(7, 6, 17, 6, 4), 
(8, 6, 15, 5, 3); 

SELECT
    CONCAT(Players.FirstName, ' ', Players.LastName) AS PlayerName,
    Teams.TeamName,
    CONCAT(Coaches.FirstName, ' ', Coaches.LastName) AS CoachName,
    SUM(PlayerStats.PointsScored) AS TotalPoints,
    (   SELECT SUM(PlayerStats.Assists)
        FROM PlayerStats
        WHERE PlayerStats.PlayerID = Players.PlayerID
    ) AS TotalAssists
FROM
    Players
JOIN
    Teams ON Players.TeamID = Teams.TeamID
JOIN
    Coaches ON Teams.CoachID = Coaches.CoachID
JOIN
    PlayerStats ON Players.PlayerID = PlayerStats.PlayerID
JOIN
    Matches ON PlayerStats.MatchID = Matches.MatchID
WHERE
    Matches.MatchDate >= '2024-09-01'
GROUP BY
    Players.PlayerID
ORDER BY
    TotalPoints DESC;




