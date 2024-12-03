CREATE TABLE client(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50)
);

CREATE TABLE bank_account(
    id SERIAL PRIMARY KEY,
    balance NUMERIC(12,2),
    client_id INT REFERENCES client(id),
    is_blocked BOOLEAN DEFAULT false
);

CREATE TABLE credit_card(
    id SERIAL PRIMARY KEY,
    card_number INT UNIQUE,
    card_limit INT DEFAULT (1000),
    is_blocked BOOLEAN DEFAULT false,
    bank_account_id INT REFERENCES bank_account(id)
);

CREATE TABLE administrator(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    credit_card_blocked BOOLEAN DEFAULT false
);

CREATE TABLE order(
    id SERIAL PRIMARY KEY,
    amount INT,
    client_id INT REFERENCES client(id),
    status VARCHAR(50) DEFAULT 'PAYMENT REQUIRED'
);

CREATE TABLE transaction(
    id SERIAL PRIMARY KEY,
    amount NUMERIC(12,2),
    credit_card_id INT REFERENCES credit_card(id),
    to_bank_account INT REFERENCES bank_account(id)
);