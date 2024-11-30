CREATE TABLE bank_account(
    id SERIAL PRIMARY KEY,
    balance NUMERIC(12,2)
);

CREATE TABLE client(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    bank_acc_id INT REFERENCES bank_account(id)
);

CREATE TABLE credit_card(
    id SERIAL PRIMARY KEY,
    card_number INT UNIQUE ,
    client_id INT REFERENCES client(id),
    bank_acc_id INT REFERENCES bank_account(id),
    card_limit INT DEFAULT (1000)
);

CREATE TABLE administrator(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    bank_acc_id INT REFERENCES bank_account(id)
);

CREATE TABLE admin_card(
    id SERIAL PRIMARY KEY,
    credit_card_id INT REFERENCES credit_card(id),
    administrator_id INT REFERENCES administrator(id),
    is_blocked BOOLEAN DEFAULT false
);

CREATE TABLE client_card(
     id SERIAL PRIMARY KEY,
     client_id INT REFERENCES client(id),
     credit_card_id INT REFERENCES credit_card(id),
     is_blocked BOOLEAN DEFAULT false
);

CREATE TABLE client_account(
    id SERIAL PRIMARY KEY,
    client_id INT REFERENCES client(id),
    bank_acc_id INT REFERENCES bank_account(id),
    is_cancelled BOOLEAN DEFAULT false
);

CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    amount INT,
    client_id INT REFERENCES client(id),
    status VARCHAR(50) DEFAULT 'PAYMENT REQUIRED'
);

CREATE TABLE money_transfer(
    id SERIAL PRIMARY KEY,
    amount NUMERIC(12,2),
    credit_card_id INT REFERENCES credit_card(id),
    from_bank_acc_id INT REFERENCES bank_account(id),
    to_bank_acc_id INT REFERENCES bank_account(id)
);