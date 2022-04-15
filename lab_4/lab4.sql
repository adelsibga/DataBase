USE lab04;


-- 3.1 INSERT

-- 3.1a Без указания списка полей
INSERT INTO passenger
VALUES (700, 'John', 'Doe', 1, '1989-07-15'),
       (701, 'Joanne', 'Di', 0, '1995-03-02');

-- 3.1b С указанием списка полей
INSERT INTO plane (name, capacity, fuel_consumption, adoption_date)
VALUES ('Thunder', 50, 2500, '1999-03-02'),
       ('Margaret', 100, 3000, '2005-06-15');

-- 3.1c С чтением значения из другой таблицы
INSERT INTO passenger (first_name, last_name, gender, birthdate)
SELECT first_name, last_name, gender, '1986-01-15'
FROM employee
WHERE id_employee = 1;


-- 3.2 DELETE

-- 3.2a Всех записей
-- noinspection SqlWithoutWhere
DELETE
FROM plane_has_employee;

-- 3.2b По условию
DELETE
FROM plane
WHERE fuel_consumption = 3000;


-- 3.3 UPDATE

-- 3.3a Всех записей
-- noinspection SqlWithoutWhere
UPDATE passenger
SET first_name = 'Jane';

-- 3.3b По условию обновляя один атрибут
UPDATE passenger
SET birthdate = '1996-03-02'
WHERE last_name = 'Di';

-- 3.3c По условию обновляя несколько атрибутов
UPDATE passenger
SET first_name = 'Argenta',
    birthdate  = '1996-03-02'
WHERE id_passenger = 2;


-- 3.4 SELECT

-- 3.4a С набором извлекаемых атрибутов
SELECT first_name, last_name
FROM passenger;

-- 3.4b Со всеми атрибутами
SELECT *
FROM employee;

-- 3.4c С условием по атрибуту
SELECT *
FROM plane
WHERE capacity = 50;


-- 3.5 SELECT ORDER BY + TOP (LIMIT)

-- 3.5a С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT *
FROM plane
ORDER BY fuel_consumption
LIMIT 5;

-- 3.5b С сортировкой по убыванию DESC
SELECT *
FROM plane
ORDER BY capacity DESC;

-- 3.5c С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT *
FROM plane
ORDER BY capacity DESC, fuel_consumption
LIMIT 5;

-- 3.5d С сортировкой по первому атрибуту, из списка извлекаемых
SELECT capacity, name
FROM plane
ORDER BY 1;


-- 3.6 Работа с датами

-- 3.6a WHERE по дате
SELECT *
FROM plane
WHERE adoption_date = '2016-03-10';

-- 3.6b WHERE дата в диапазоне
SELECT *
FROM passenger
WHERE birthdate BETWEEN '1970-01-01' AND '1979-12-31';

-- 3.6c Извлечь из таблицы не всю дату, а только год
SELECT name, YEAR(adoption_date) AS adoption_year
FROM plane;


-- 3.7 Функции агрегации

-- 3.7a Посчитать количество записей в таблице
SELECT COUNT(*) AS amount_of_employees
FROM employee;

-- 3.7b Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT first_name) AS amount_of_unique_passengers_names
FROM passenger;

-- 3.7c Вывести уникальные значения столбца
SELECT DISTINCT first_name
FROM passenger;

-- 3.7d Найти максимальное значение столбца
SELECT MAX(capacity) AS max_plane_capacity
FROM plane;

-- 3.7e Найти минимальное значение столбца
SELECT MIN(fuel_consumption) AS min_plane_fuel_consumption
FROM plane;

-- 3.7f Написать запрос COUNT() + GROUP BY
SELECT first_name, COUNT(*) AS occurrences
FROM passenger
GROUP BY first_name;


-- 3.8 SELECT GROUP BY + HAVING

-- 3.8a Написать 3 разных запроса с использованием GROUP BY + HAVING. Для
-- каждого запроса написать комментарий с пояснением, какую информацию
-- извлекает запрос. Запрос должен быть осмысленным, т.е. находить информацию,
-- которую можно использовать.

-- Capacities of the planes and their average fuel consumptions less than 3500
SELECT capacity, AVG(fuel_consumption) AS average_fuel_consumption
FROM plane
GROUP BY capacity
HAVING AVG(fuel_consumption) < 3500;

-- Amount of planes having the same capacity
SELECT capacity, COUNT(*) AS amount
FROM plane
GROUP BY capacity
HAVING COUNT(*) > 1;

-- Overall capacity and fuel consumption of planes adopted between 2017 and 2020 with resulting capacity more than 120
SELECT SUM(capacity) AS overall_capacity, SUM(fuel_consumption) AS overall_fuel_consumption
FROM plane
WHERE YEAR(adoption_date) BETWEEN 2017 AND 2020
GROUP BY fuel_consumption
HAVING SUM(capacity) > 120;


-- 3.9 SELECT JOIN

-- 3.9a LEFT JOIN двух таблиц и WHERE по одному из атрибутов
-- Flights and corresponding planes
SELECT p.name, f.start_date, f.end_date
FROM flight f
         LEFT JOIN plane p ON f.id_plane = p.id_plane;

-- 3.9b RIGHT JOIN. Получить такую же выборку, как и в 3.9a
-- Flights and corresponding planes
SELECT p.name, f.start_date, f.end_date
FROM plane p
         RIGHT JOIN flight f ON p.id_plane = f.id_plane;

-- 3.9c LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
-- Which male pilot works at the plane named 'Celebration'
SELECT e.first_name, e.last_name
FROM plane_has_employee phe
         LEFT JOIN employee e ON phe.id_employee = e.id_employee AND e.gender = 1
         LEFT JOIN plane p ON phe.id_plane = p.id_plane AND p.name = 'Celebration'
WHERE phe.position = 0;

-- 3.9d INNER JOIN двух таблиц
-- Tickets and their owners
SELECT t.price, p.first_name, p.last_name
FROM ticket t
         INNER JOIN passenger p ON t.id_passenger = p.id_passenger;


-- 3.10 Подзапросы

-- 3.10a Написать запрос с условием WHERE IN (подзапрос)
-- Planes witch flew at least once
SELECT name
FROM plane
WHERE id_plane IN (SELECT id_plane FROM flight);

-- 3.10b Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
-- Amount of flights each plane had
SELECT p.name,
       (
           SELECT COUNT(*)
           FROM flight f
           WHERE p.id_plane = f.id_plane
       ) AS amount_of_flights
FROM plane p
ORDER BY amount_of_flights DESC;

-- 3.10c Написать запрос вида SELECT * FROM (подзапрос)
-- Planes having names starting with 'C' and capacity more than 60
SELECT c_planes.name, c_planes.capacity
FROM (
         SELECT *
         FROM plane
         WHERE LOWER(name) LIKE 'c%'
     ) c_planes
WHERE c_planes.capacity > 60;

-- 3.10d Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON ...
-- Old price and new price with personal discount for each passenger based on their last purchased ticket
SELECT p.first_name, p.last_name, tp.old AS old_price, tp.new AS new_price
FROM passenger p
         INNER JOIN (
    SELECT t.id_passenger AS id_passenger, t.price AS old, (t.price * 0.8) AS new
    FROM ticket t
    ORDER BY purchase_date DESC
    LIMIT 1
) tp ON p.id_passenger = tp.id_passenger;
