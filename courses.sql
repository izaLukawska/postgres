CREATE TABLE teacher(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(100)
);

CREATE TABLE course(
    id SERIAL PRIMARY KEY,
    subject VARCHAR(50),
    teacher_id INT REFERENCES teacher(id)
);

CREATE TABLE student(
    id SERIAL PRIMARY KEY,
    fullName VARCHAR(50),
    course_id INT REFERENCES course(id)
);

CREATE TABLE grade(
    id SERIAL PRIMARY KEY,
    value INT,
    student_id INT REFERENCES student(id)
);

CREATE TABLE archive(
    id SERIAL PRIMARY KEY,
    grade_id INT REFERENCES grade(id)
);