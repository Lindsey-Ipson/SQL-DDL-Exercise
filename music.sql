DROP DATABASE IF EXISTS music_db;

CREATE DATABASE music_db;

\c music_db


CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL
);

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE producers (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE songs (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  album_id INT REFERENCES albums
);

CREATE TABLE song_artists (
  song_id INT REFERENCES songs,
  artist_id INT REFERENCES artists,
  PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE song_producers (
  song_id INT REFERENCES songs,
  producer_id INT REFERENCES producers,
  PRIMARY KEY (song_id, producer_id)
);


-- INSERT DATA:

INSERT INTO albums (title)
VALUES ('Middle of Nowhere'),
       ('A Night at the Opera'),
       ('Daydream'),
       ('A Star Is Born'),
       ('Silver Side Up'),
       ('The Blueprint 3'),
       ('Prism'),
       ('Hands All Over'),
       ('Let Go'),
       ('The Writing''s on the Wall');

INSERT INTO artists (name)
VALUES ('Hanson'),
       ('Queen'),
       ('Mariah Carey'),
       ('Boyz II Men'),
       ('Lady Gaga'),
       ('Bradley Cooper'),
       ('Nickelback'),
       ('Jay Z'),
       ('Alicia Keys'),
       ('Katy Perry'),
       ('Juicy J'),
       ('Maroon 5'),
       ('Christina Aguilera'),
       ('Avril Lavigne'),
       ('Destiny''s Child');

INSERT INTO producers (name)
VALUES ('Dust Brothers'),
       ('Stephen Lironi'),
       ('Roy Thomas Baker'),
       ('Walter Afanasieff'),
       ('Benjamin Rice'),
       ('Rick Parashar'),
       ('Al Shux'),
       ('Max Martin'),
       ('Cirkut'),
       ('Shellback'),
       ('Benny Blanco'),
       ('The Matrix'),
       ('Darkchild');

INSERT INTO songs (title, duration_in_seconds, release_date, album_id)
VALUES ('MMMBop', 238, '1997-04-15', 1),
       ('Bohemian Rhapsody', 355, '1975-10-31', 2),
       ('One Sweet Day', 282, '1995-11-14', 3),
       ('Shallow', 216, '2018-09-27', 4),
       ('How You Remind Me', 223, '2001-08-21', 5),
       ('New York State of Mind', 276, '2009-10-20', 6),
       ('Dark Horse', 215, '2013-12-17', 7),
       ('Moves Like Jagger', 201, '2011-06-21', 8),
       ('Complicated', 244, '2002-05-14', 9),
       ('Say My Name', 240, '1999-11-07', 10);

INSERT INTO song_artists (song_id, artist_id)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (3, 4),
       (4, 5),
       (4, 6),
       (5, 7),
       (6, 8),
       (6, 9),
       (7, 10),
       (7, 11),
       (8, 12),
       (8, 13),
       (9, 14),
       (10, 15);

INSERT INTO song_producers (song_id, producer_id)
VALUES (1, 1),
       (1, 2),
       (2, 3),
       (3, 4),
       (4, 5),
       (5, 6),
       (6, 7),
       (7, 8),
       (7, 9),
       (8, 10),
       (8, 11),
       (9, 12),
       (10, 13);
