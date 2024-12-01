CREATE TABLE department(
    id SERIAL PRIMARY KEY,
    major VARCHAR(100)
);

CREATE TABLE exam(
    id SERIAL PRIMARY KEY,
    subject VARCHAR(50),
    dep_id INT REFERENCES department(id)
);

CREATE TABLE candidate(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    dep_id INT REFERENCES department(id)
);

CREATE TABLE teacher(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    exam_id INT REFERENCES exam(id)
);

CREATE TABLE grade(
    id SERIAL PRIMARY KEY,
    grade_value INT,
    teacher_id INT REFERENCES teacher(id),
    candidate_id INT REFERENCES candidate(id)
);

SELECT c.fullName AS student_enrolled FROM candidate c
LEFT JOIN grade g ON g.candidate_id = c.id
GROUP BY c.id, c.fullName
HAVING AVG(g.grade_value) >= (SELECT AVG(grade_value) FROM grade);