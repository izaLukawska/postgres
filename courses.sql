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
    grade_value INT,
    teacher_id INT REFERENCES teacher(id),
    student_id INT REFERENCES student(id)
);

CREATE TABLE archive(
    id SERIAL PRIMARY KEY,
    teacher_id INT REFERENCES teacher(id),
    student_id INT REFERENCES student(id),
    course_id INT REFERENCES course(id),
    grade_id INT REFERENCES grade(id)
);

CREATE TABLE course_student(
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id),
    course_id INT REFERENCES course(id),
    status VARCHAR(50) DEFAULT 'NOT ENROLLED'
);

CREATE TABLE course_teacher(
    id SERIAL PRIMARY KEY,
    course_id INT REFERENCES course(id),
    teacher_id INT REFERENCES teacher(id),
    status VARCHAR(50) DEFAULT 'OPEN'
);