create table authors(
id serial primary key,
firstname varchar (50),
lastname varchar (50)
);

create table books(
id serial primary key,
title varchar (100),
publicationYear int,
pageCount int,
author_id int references author(id) on delete set null
);

insert into authors (firstname, lastname) values ('Agatha', 'Christie'),
                                                ('John', 'Tolkien'),
                                                ('J.K', 'Rowling'),
                                                ('James', 'Owen'),
                                                ('Stephen', 'King');

insert into book(title, publicationYear, pageCount, author_id) values ('Book1', 1999, 250, 1),
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
select (title, publicationYear, (select firstname from authors where authotrs_id = books.author_id)) from books order by publicationYear;
select (title, publicationYear, (select firstname from authors where authotrs_id = books.author_id)) from books order by publicationYear desc;

--5. Napisać polecenie, wyświetlające ilość książek konkretnego autora.-
select count(*) from books where auhtor_id = 2;

--6. Napisać polecenie, wyświetlające książki, którzy mają ilość stron większą niż średnia ilość stron wszystkich książek w tabeli.--
select * from books where pageCount > (select avg(pageCount) from books);

--7. Napisać polecenie, wyświetlające 5 najstarszych książek i sumę ich stron.--
select (title, publicationYear, (select sum(pageCount) from (select * from books order by publicationYear limit 5)) from books order by publicationYear;

----8. Napisać polecenie, zmieniające ilość stron konkretnej książki.--
update books set pageCount = pageCount + 100 where books.id = 1;

--9. Napisać polecenie, usuwające autora, który napisał największą książkę.--
delete from authors  where id = (select author_id from books where pagecount = (select max(pageCount) from books));
)
