DROP DATABASE IF EXISTS doctor_office_db;

CREATE DATABASE doctor_office_db;

\c doctor_office_db;

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    specialty TEXT NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    birthdate DATE NOT NULL,
    gender TEXT NULL
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY,
    doctor_id INT REFERENCES doctors,
    patient_id INT REFERENCES patients,
    date DATE NOT NULL
);

CREATE TABLE diseases (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    prognosis TEXT NULL,
    contagious boolean NOT NULL
);

CREATE TABLE diagnoses (
    id SERIAL PRIMARY KEY,
    visit_id INT REFERENCES visits,
    disease_id INT REFERENCES diseases,
    severity TEXT NOT NULL
);

INSERT INTO patients (name, birthdate, gender)
VALUES
('John Jackson', '1980-12-31', 'male'),
('Jane Smith', '1995-06-15', 'female'),
('Michael Johnson', '1978-09-22', 'male');


INSERT INTO doctors (name, specialty)
VALUES
('Layla Wilson', 'ENT'),
('Bill Jacob', 'GP');

INSERT INTO visits (doctor_id, patient_id, date)
VALUES
(1, 1, '2023-05-12'),
(2, 3, '09-08-2022');

INSERT INTO diseases (name, prognosis, contagious)
VALUES
('flu', 'clears up usually within 3-4 weeks', true),
('cold', 'clears up usually within 2-3 weeks', true);

INSERT INTO diagnoses (visit_id, disease_id, severity)
VALUES
(1, 1, 'mild'),
(2, 2, 'moderate');

SELECT d.name AS doctor_name, p.name AS patient_name, dis.name AS diagnosis_name
FROM doctors d
JOIN visits v ON d.id = v.doctor_id
JOIN patients p ON v.patient_id = p.id
JOIN diagnoses diag ON v.id = diag.visit_id
JOIN diseases dis ON diag.disease_id = dis.id;
