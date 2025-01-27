-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Retrieve all students along with their department names
SELECT "student"."ID", "student"."name", "department"."dept_name"
FROM "student"
JOIN "department" ON "student"."dept_id" = "department"."ID";

-- Retrieve all instructors with their departments and salary
SELECT "instructor"."ID", "instructor"."name", "department"."dept_name", "instructor"."salary"
FROM "instructor"
JOIN "department" ON "instructor"."dept_id" = "department"."ID";

-- Retrieve all courses taught by instructors in a specific semester and year
SELECT "course"."title", "teaches"."year", "teaches"."semester", "instructor"."name" AS "Instructor Name"
FROM "teaches"
JOIN "course" ON "teaches"."course_id" = "course"."ID"
JOIN "instructor" ON "teaches"."inst_id" = "instructor"."ID"
WHERE "teaches"."year" = 2025 AND "teaches"."semester" = 1;

-- Retrieve all students enrolled in a specific course with their marks
SELECT "student"."name" AS "Student Name", "course"."title" AS "Course Title", "enrollment"."mark"
FROM "enrollment"
JOIN "student" ON "enrollment"."std_id" = "student"."ID"
JOIN "course" ON "enrollment"."course_id" = "course"."ID"
WHERE "course"."ID" = 101;

-- Retrieve all prerequisites for a specific course
SELECT "course"."title" AS "Course", "pre_course"."title" AS "Prerequisite"
FROM "prerequisite"
JOIN "course" ON "prerequisite"."course_id" = "course"."ID"
JOIN "course" AS "pre_course" ON "prerequisite"."pre_course_id" = "pre_course"."ID"
WHERE "course"."ID" = 102;

-- Retrieve students who have passed a specific course
SELECT "student"."name" AS "Student Name", "course"."title" AS "Course Title"
FROM "enrollment"
JOIN "student" ON "enrollment"."std_id" = "student"."ID"
JOIN "course" ON "enrollment"."course_id" = "course"."ID"
WHERE "enrollment"."passed" = 'Y';

-- Count the total number of students in each department
SELECT "department"."dept_name", COUNT("student"."ID") AS "Total Students"
FROM "student"
JOIN "department" ON "student"."dept_id" = "department"."ID"
GROUP BY "department"."dept_name";

-- Retrieve the highest salary among instructors in each department
SELECT "department"."dept_name", MAX("instructor"."salary") AS "Highest Salary"
FROM "instructor"
JOIN "department" ON "instructor"."dept_id" = "department"."ID"
GROUP BY "department"."dept_name";

-- Insert a new student into the database
INSERT INTO "student" ("name", "phone", "email", "total_credits", "dept_id")
VALUES ('Mohanad AbuSabha', '5551234567', 'mohanad@example.com', 0, 1);

-- Update a student's total credits after course completion
UPDATE "student"
SET "total_credits" = "total_credits" + 3
WHERE "ID" = 1001;

-- Delete a course from the database
DELETE FROM "course"
WHERE "ID" = 105;
