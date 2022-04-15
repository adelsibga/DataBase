/* Рейсы, пассажиры, билеты */

CREATE DATABASE IF NOT EXISTS lab04;
USE lab04;

CREATE TABLE IF NOT EXISTS employee
(
    id_employee INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    first_name  VARCHAR(255) NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    gender      TINYINT(1)   NOT NULL,
    ssn         VARCHAR(11)  NOT NULL
);

CREATE TABLE IF NOT EXISTS passenger
(
    id_passenger INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    first_name   VARCHAR(255) NOT NULL,
    last_name    VARCHAR(255) NOT NULL,
    gender       TINYINT(1)   NOT NULL,
    birthdate    DATE         NOT NULL
);

CREATE TABLE IF NOT EXISTS plane
(
    id_plane         INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    name             VARCHAR(255) NOT NULL,
    capacity         INT          NOT NULL,
    fuel_consumption INT          NOT NULL,
    adoption_date    DATE         NOT NULL
);

CREATE TABLE IF NOT EXISTS flight
(
    id_flight  INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_plane   INT UNSIGNED NOT NULL,
    start_date DATETIME     NOT NULL,
    end_date   DATETIME     NULL,
    CONSTRAINT flight_plane_id_plane_fk
        FOREIGN KEY (id_plane) REFERENCES plane (id_plane)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS plane_has_employee
(
    id_plane    INT UNSIGNED NOT NULL,
    id_employee INT UNSIGNED NOT NULL,
    position    TINYINT(1)   NOT NULL, -- 0 - pilot, 1 - pair pilot, 2 - waiter/waitress
    PRIMARY KEY (id_plane, id_employee),
    CONSTRAINT plane_has_employee_employee_id_employee_fk
        FOREIGN KEY (id_employee) REFERENCES employee (id_employee)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT plane_has_employee_plane_id_plane_fk
        FOREIGN KEY (id_plane) REFERENCES plane (id_plane)
            ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ticket
(
    id_ticket     INT UNSIGNED AUTO_INCREMENT
        PRIMARY KEY,
    id_flight     INT UNSIGNED   NOT NULL,
    id_passenger  INT UNSIGNED   NOT NULL,
    price         DECIMAL(15, 2) NOT NULL,
    purchase_date DATETIME       NOT NULL,
    CONSTRAINT ticket_flight_id_flight_fk
        FOREIGN KEY (id_flight) REFERENCES flight (id_flight)
            ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ticket_passenger_id_passenger_fk
        FOREIGN KEY (id_passenger) REFERENCES passenger (id_passenger)
            ON UPDATE CASCADE ON DELETE CASCADE
);
