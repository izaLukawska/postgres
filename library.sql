CREATE TABLE book(
    id SERIAL PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE catalog(
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(id),
    avaiablity BOOLEAN DEFAULT true
);

CREATE TABLE reader(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50)
);

CREATE TABLE book_order(
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(id),
    reader_id INT REFERENCES reader(id),
    rented_status BOOLEAN DEFAULT false
);

CREATE TABLE librarian(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    book_order_id INT REFERENCES book_order(id),
    rent_type VARCHAR(50)
);

CREATE TABLE administrator(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50)
);

CREATE TABLE blacklist(
    id SERIAL PRIMARY KEY,
    admin_id INT REFERENCES administrator(id),
    reader_id INT REFERENCES reader(id)
);