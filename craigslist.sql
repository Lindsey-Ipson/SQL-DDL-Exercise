DROP DATABASE IF EXISTS craigslist_db;

CREATE DATABASE craigslist_db;

\c craigslist_db;

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    username TEXT NOT NULL,
    region_id INT REFERENCES regions
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    location TEXT NOT NULL,
    user_id INT REFERENCES users,
    region_id INT REFERENCES regions,
    category_id INT REFERENCES categories
);


INSERT INTO regions (name)
VALUES
('North'), ('East'), ('South'), ('West');

INSERT INTO categories (name)
VALUES
('Clothing'), ('Electronics'), ('Services'), ('Transportation');

INSERT INTO users (name, username, region_id)
VALUES
('Erica Johnson', 'EK299', 2),
('Mary Cornwall', 'MS456', 1),
('Ben Jackson', 'BJ898', 4);

INSERT INTO posts
(title, text, location, user_id, region_id, category_id)
VALUES
('Stereo System For Sale', 'This is where the text goes.', 'Seattle, WA', 2, 3, 2),
('Car for Sale', 'This is where the text goes.', 'Trenton, NJ', 1, 1, 4),
('Cleaning Out Closet', 'This is where the text goes.', 'Boston, MA', 3, 2, 1);


SELECT u.name AS person, p.title AS listing, p.location AS place, r.name AS region, c.name AS category
FROM regions r
JOIN users u ON r.id = u.region_id
JOIN posts p ON p.user_id = u.id
JOIN categories c ON c.id = p.category_id;
