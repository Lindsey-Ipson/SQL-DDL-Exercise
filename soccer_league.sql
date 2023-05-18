DROP DATABASE IF EXISTS soccer_league_db;

CREATE DATABASE soccer_league_db;

\c soccer_league_db;

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE refs (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    team_id INTEGER REFERENCES teams
);

CREATE TABLE matches (
    id  SERIAL PRIMARY KEY,
    home_team INTEGER REFERENCES teams,
    away_team INTEGER REFERENCES teams,
    season_id INTEGER REFERENCES seasons,
    ref1 INTEGER REFERENCES refs,
    ref2 INTEGER REFERENCES refs
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players,
    match_id INTEGER REFERENCES matches
);

-- INSERT DATA

-- Insert data into the 'teams' table
INSERT INTO teams (name)
VALUES
  ('Team A'),
  ('Team B'),
  ('Team C'),
  ('Team D'),
  ('Team E');

-- Insert data into the 'players' table
INSERT INTO players (name, team_id)
VALUES
  ('Player 1', 1),
  ('Player 2', 1),
  ('Player 3', 2),
  ('Player 4', 3),
  ('Player 5', 3),
  ('Player 6', 4),
  ('Player 7', 4),
  ('Player 8', 5),
  ('Player 9', 5),
  ('Player 10', 5);

-- Insert data into the 'seasons' table
INSERT INTO seasons (name)
VALUES
  ('Season 1'),
  ('Season 2'),
  ('Season 3'),
  ('Season 4');

-- Insert data into the 'refs' table
INSERT INTO refs (name)
VALUES
  ('Referee A'),
  ('Referee B'),
  ('Referee C'),
  ('Referee D');

-- Insert data into the 'matches' table
INSERT INTO matches (home_team, away_team, season_id, ref1, ref2)
VALUES
  (1, 2, 1, 1, 2),
  (2, 3, 1, 1, 2),
  (3, 1, 2, 3, 4),
  (2, 3, 2, 3, 4),
  (3, 4, 3, 4, 2),
  (3, 1, 3, 4, 1),
  (4, 5, 4, 3, 2),
  (5, 2, 4, 1, 4);

-- Insert data into the 'goals' table
INSERT INTO goals (player_id, match_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (4, 2),
  (5, 3),
  (1, 4),
  (3, 4),
  (10, 8),
  (9, 7),
  (8, 7),
  (8, 6),
  (9, 5);



-- SAMPLE SELECTIONS

-- Select the top five scoring players for a given season
SELECT p.name AS player_name, SUM(g.id) AS total_goals
FROM players p
JOIN goals g ON p.id = g.player_id
JOIN matches m ON g.match_id = m.id
JOIN seasons s ON m.season_id = s.id
WHERE s.name = 'Season 1' -- Replace 'Season 1' with the desired season name
GROUP BY p.name
ORDER BY total_goals DESC
LIMIT 10;

-- Select the players and their corresponding teams for a given match
SELECT p.name AS player_name, t.name AS team_name
FROM players p
JOIN teams t ON p.team_id = t.id
JOIN goals g ON p.id = g.player_id
JOIN matches m ON g.match_id = m.id
WHERE m.id = 1; -- Replace 1 with the desired match ID

-- -- Select the matches and their corresponding season names
SELECT m.*, s.name AS season_name
FROM matches m
JOIN seasons s ON m.season_id = s.id;

-- Select the players and their total number of goals scored across all seasons ordered by goals
SELECT p.name AS player_name, COUNT(g.id) AS total_goals
FROM players p
LEFT JOIN goals g ON p.id = g.player_id
GROUP BY p.name
ORDER BY COUNT(g.id) DESC;

-- Select the teams and their total number of matches played in a specific season
SELECT t.name AS team_name, COUNT(m.id) AS total_matches
FROM teams t
LEFT JOIN matches m ON t.id = m.home_team OR t.id = m.away_team
JOIN seasons s ON m.season_id = s.id
WHERE s.name = 'Season 2'
GROUP BY t.name;


\c soccer_league_db;