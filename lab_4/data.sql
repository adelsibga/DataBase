USE lab04;

INSERT INTO passenger (last_name, first_name, gender, birthdate)
VALUES ('Ferry', 'Shaniya', 0, '1977-01-30'),
       ('Cartwright', 'Nicolas', 1, '1996-08-13'),
       ('Roberts', 'Shaniya', 0, '1974-05-16'),
       ('Mraz', 'Gayle', 1, '1974-01-13'),
       ('Koss', 'Mikayla', 0, '1979-06-14'),
       ('Collier', 'Santos', 1, '1989-01-22'),
       ('Schinner', 'Natalia', 0, '1996-09-19'),
       ('Gorczany', 'Cyrus', 1, '1971-08-30'),
       ('Dare', 'Chaz', 1, '1974-06-16'),
       ('Kunze', 'Ryley', 1, '1985-06-18'),
       ('Shanahan', 'Santos', 1, '1987-11-18'),
       ('Jones', 'Jessica', 0, '1971-01-01'),
       ('Botsford', 'Tania', 0, '1993-02-25'),
       ('Rosenbaum', 'Alexanne', 0, '1975-04-21'),
       ('Wisozk', 'Elmo', 1, '1985-06-10'),
       ('Ratke', 'Kirstin', 0, '1971-07-08'),
       ('Christiansen', 'Jessica', 0, '1988-07-23'),
       ('O\'Reilly', 'Newton', 1, '1990-12-17'),
       ('Robel', 'Timothy', 1, '1997-08-28'),
       ('Boyer', 'Corbin', 1, '1996-05-10');

INSERT INTO employee (last_name, first_name, ssn, gender)
VALUES ('Howe', 'Richie', '221-56-5328', 1),
       ('Bartoletti', 'Emory', '516-28-9906', 1),
       ('Mante', 'Jackson', '675-10-5554', 1),
       ('Lind', 'Luther', '013-56-9253', 1),
       ('Denesik', 'Faye', '575-65-0038', 0),
       ('Dietrich', 'Brennan', '503-56-6902', 1),
       ('Cruickshank', 'Catherine', '407-57-4462', 0),
       ('Langosh', 'Donnie', '646-34-1114', 1),
       ('Mann', 'Ida', '531-41-5698', 0),
       ('Simonis', 'Maria', '416-11-7503', 0),
       ('Jacobs', 'Valentina', '429-08-9772', 0),
       ('Swaniawski', 'Sonny', '251-71-0712', 1),
       ('Miller', 'Theodora', '519-11-2083', 0),
       ('Murray', 'Aryanna', '385-08-0120', 0),
       ('Gulgowski', 'Oswald', '480-60-0601', 1),
       ('Kiehn', 'Afton', '418-24-5667', 1),
       ('Jane', 'Sabrina', '578-07-7824', 0),
       ('Gutkowski', 'Eryn', '677-09-6866', 0),
       ('Jacobs', 'Leila', '045-64-1366', 0),
       ('Strosin', 'Amalia', '006-66-9895', 0);

INSERT INTO plane (name, capacity, fuel_consumption, adoption_date)
VALUES ('Analyst', 100, 3000, '2015-11-24'),
       ('Celebration', 100, 3100, '2015-12-14'),
       ('Combination', 50, 1250, '2016-03-10'),
       ('Football', 60, 1500, '2016-03-24'),
       ('Baseball', 70, 1600, '2016-12-02'),
       ('Ratio', 65, 1400, '2017-07-12'),
       ('Chapter', 60, 1600, '2017-10-04'),
       ('Judgment', 100, 2500, '2017-10-27'),
       ('Energy', 90, 2000, '2018-05-04'),
       ('Growth', 120, 3500, '2018-08-22'),
       ('Currency', 70, 1200, '2018-11-21'),
       ('Setting', 50, 1650, '2019-02-23'),
       ('Courage', 5, 800, '2020-02-17'),
       ('Professor', 40, 1200, '2020-04-22'),
       ('Protection', 85, 2000, '2020-09-02'),
       ('Mud', 30, 2500, '2020-09-20'),
       ('Stranger', 40, 3200, '2021-12-11'),
       ('Negotiation', 100, 3600, '2022-04-05'),
       ('Bathroom', 120, 3600, '2022-07-08'),
       ('Classroom', 90, 2950, '2022-10-20');

INSERT INTO plane_has_employee (id_plane, id_employee, position)
VALUES (2, 1, 0),
       (2, 2, 1),
       (2, 4, 2),
       (2, 5, 2);

INSERT INTO flight (id_plane, start_date, end_date)
VALUES (2, '2021-06-07 21:00:00', '2021-06-08 12:00:00'),
       (3, '2021-01-07 09:30:00', '2021-01-07 20:00:00');

INSERT INTO ticket (id_flight, id_passenger, price, purchase_date)
    VALUE (2, 12, 250.99, '2021-06-05');
