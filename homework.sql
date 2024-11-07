CREATE TABLE authors
(
id SERIAL PRIMARY KEY,
firstname VARCHAR (50),
lastname VARCHAR (50)
);

CREATE TABLE authors
(
id SERIAL PRIMARY KEY,
title VARCHAR (100),
publicationYear int,
pageCount int,
author_id int REFERENCES authors(id) ON DELETE SET NULL
);

INSER INTO authors (firstname, lastname)
VALUES ('Agatha', 'Christie'),
('John', 'Tolkien'),
('J.K', 'Rowling'),
('James', 'Owen'),
('Stephen', 'King');

INSERT INTO book(title, publicationYear, pageCount, author_id)
VALUES ('Book1', 1999, 250, 1),
('Book2', 2005, 300, 2),
('Book3', 2010, 150, 3),
('Book4', 2023, 850, 4),
('Book5', 1986, 400, 5),
('Book6', 2009, 80, 2),
('Book7', 2017, 230, 2),
('Book8', 1992, 170, 3),
('Book9', 2001, 300, 4),
('Book10', 2003, 600, 5);

--4. Napisać polecenie SQL, które wyświetli: nazwę książki, rok i imię autora, sortowane według roku produkcji rosnąco.--
SELECT (title, publicationYear, (SELECT firstname FROM authors WHERE authotrs_id = books.author_id)) FROM books ORDER BY publicationYear;

SELECT (title, publicationYear, (SELECT firstname FROM authors WHERE authotrs_id = books.author_id)) FROM books ORDER BY publicationYear DESC;

--5. Napisać polecenie, wyświetlające ilość książek konkretnego autora.-
SELECT count(*) FROM books WHERE auhtor_id = 2;

--6. Napisać polecenie, wyświetlające książki, którzy mają ilość stron większą niż średnia ilość stron wszystkich książek w tabeli.--
SELECT * FROM books WHERE pageCount > (SELECT avg(pageCount) FROM books);

--7. Napisać polecenie, wyświetlające 5 najstarszych książek i sumę ich stron.--
SELECT (title, publicationYear, (SELECT sum(pageCount) FROM (SELECT * FROM books ORDER BY publicationYear LIMIT 5)) FROM books ORDER BY publicationYear;

----8. Napisać polecenie, zmieniające ilość stron konkretnej książki.--
UPDATE books SET pageCount = pageCount + 100 WHERE books.id = 1;

--9. Napisać polecenie, usuwające autora, który napisał największą książkę.--
DELETE FROM authors  WHERE id = (SELECT author_id FROM books WHERE pagecount = (SELECT max(pageCount) FROM books));