CREATE TABLE airport(
    code VARCHAR(10) PRIMARY KEY,
    country VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO airport (code, country, city) VALUES ('WAW', 'Poland', 'Warsaw'),
                                                ('KRK', 'Poland', 'Cracow'),
                                                ('BER', 'Germany', 'Berlin'),
                                                ('CDG', 'France', 'Paris'),
                                                ('LHR', 'United Kingdom', 'London');

CREATE TABLE aircraft(
    id SERIAL PRIMARY KEY,
    model VARCHAR(100) UNIQUE,
    seatsCount int
);

INSERT INTO aircraft (model, seatscount) VALUES ('MODEL 1', 100),
                                                ('MODEL 2', 50),
                                                ('MODEL 3', 200),
                                                ('MODEL 4', 150),
                                                ('MODEL 5', 300);

CREATE TABLE seat(
    aircraft_id INT REFERENCES aircraft(id),
    seat_no VARCHAR(5),
    UNIQUE(aircraft_id, seat_no)
);

INSERT INTO seat (aircraft_id, seat_no) VALUES (1, 'B1'),
                                               (2, 'A8'),
                                               (1, 'A5'),
                                               (1, 'B6'),
                                               (3, 'F8');

CREATE TABLE flight(
    id SERIAL PRIMARY KEY,
    flight_no VARCHAR(10),
    departure_date DATE,
    departure_airport_code VARCHAR(10) REFERENCES airport(code),
    arrival_date DATE,
    arrival_airport_code VARCHAR(10) REFERENCES airport(code),
    aircraft_id INT REFERENCES aircraft(id),
    status VARCHAR(50)
);


INSERT INTO flight(flight_no, departure_date, departure_airport_code,
                   arrival_date, arrival_airport_code,aircraft_id, status)
VALUES ('MK3536', '2024-11-26', 'WAW', '2024-11-26', 'KRK', 1, 'Scheduled'),
       ('BE1243', '2024-12-13', 'LHR', '2024-12-14', 'BER', 5, 'Cancelled'),
       ('JK4232', '2024-12-01', 'CDG', '2024-12-01', 'WAW', 3, 'Scheduled'),
       ('JI2132', '2024-10-11', 'BER', '2024-12-01', 'KRK', 2, 'Completed'),
       ('PO2132', '2024-12-03', 'WAW', '2024-12-01', 'CDG', 4, 'Scheduled');



CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    passenger_no VARCHAR(50) UNIQUE,
    passenger_name VARCHAR(100),
    flight_id INT REFERENCES flight(id),
    seat_no VARCHAR(10),
    cost NUMERIC(10, 2),
    UNIQUE (flight_id, seat_no)
);

INSERT INTO tickets (passenger_no, passenger_name, flight_id, seat_no, cost)
    VALUES ('K21IW', 'Jan Kowalski', 1, 'B1', 2000.50),
           ('92WLW', 'Anna Nowak', 1, 'A5', 340.20),
           ('KI33W', 'John Smith', 2, 'B6', 1000.30),
           ('P211L', 'Jacob Black', 2, 'B8', 1850),
           ('JN2W5', 'Ruth Sims', 3, 'F8', 2300),


--3. Wyświetlić pasażera lotu Warszawa (WAW) - Kraków (KRK) przedwczoraj z miejscem pod numerem B1.
SELECT (passenger_no, passenger_name) AS passenger FROM tickets t
    JOIN flight f ON t.flight_id = f.id
    AND t.seat_no = 'B1'
    AND f.departure_airport_code = 'WAW'
    AND f.arrival_airport_code = 'KRK'
    AND f.arrival_date = CURRENT_DATE - INTERVAL '1 day';


--4. Ile zostało wolnych miejsc 2024-11-26 na locie pod numerem MK3536?
SELECT f.flight_no, a.seatsCount - COUNT(t.seat_no) AS seats_left FROM flight f
    JOIN aircraft a ON f.aircraft_id = a.id
    LEFT JOIN tickets t ON f.id = t.flight_id
    WHERE f.flight_no = 'MK3536'
    GROUP BY flight_no, a.seatsCount;


--5.Wyświetlić listę lotów, które wylatują z lotniska w Polsce w ciągu najbliższych 7 dni.
SELECT * FROM flight
    WHERE departure_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '1 WEEK';

--6.Znaleźć średnią cenę biletów na lot o numerze MK3536 z dnia 2024-11-26.
SELECT AVG(cost) as average_price FROM tickets
    LEFT JOIN flight ON tickets.flight_id = flight.id
    WHERE flight.flight_no = 'MK3536' AND flight.departure_date = '2024-11-26';