-- In this SQL file, we define the schema for the university database in SQLite3.
-- This includes CREATE TABLE statements with appropriate data types, constraints,
-- and foreign key relationships.

-- Table: faculty
CREATE TABLE "faculty" (
    "ID" INTEGER NOT NULL PRIMARY KEY,
    "fac_name" TEXT NOT NULL,
    "fac_manager" TEXT
);

-- Table: department
CREATE TABLE "department" (
    "ID" INTEGER NOT NULL PRIMARY KEY,
    "dept_name" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "fac_id" INTEGER,
    FOREIGN KEY ("fac_id") REFERENCES "faculty" ("ID")
);

-- Table: student
CREATE TABLE "student" (
    "ID" INTEGER NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "total_credits" INTEGER,
    "dept_id" INTEGER,
    FOREIGN KEY ("dept_id") REFERENCES "department" ("ID")
);

-- Table: instructor
CREATE TABLE "instructor" (
    "ID" INTEGER NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "phone" TEXT,
    "email" TEXT,
    "salary" REAL,
    "dept_id" INTEGER,
    FOREIGN KEY ("dept_id") REFERENCES "department" ("ID")
);

-- Table: course
CREATE TABLE "course" (
    "ID" INTEGER NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "credits" INTEGER NOT NULL,
    "dept_id" INTEGER,
    FOREIGN KEY ("dept_id") REFERENCES "department" ("ID")
);

-- Table: prerequisite
CREATE TABLE "prerequisite" (
    "course_id" INTEGER NOT NULL,
    "pre_course_id" INTEGER NOT NULL,
    PRIMARY KEY ("course_id", "pre_course_id"),
    FOREIGN KEY ("course_id") REFERENCES "course" ("ID"),
    FOREIGN KEY ("pre_course_id") REFERENCES "course" ("ID")
);

-- Table: teaches
CREATE TABLE "teaches" (
    "course_id" INTEGER NOT NULL,
    "inst_id" INTEGER NOT NULL,
    "year" INTEGER NOT NULL,
    "semester" INTEGER NOT NULL,
    PRIMARY KEY ("course_id", "inst_id", "year", "semester"),
    FOREIGN KEY ("course_id") REFERENCES "course" ("ID"),
    FOREIGN KEY ("inst_id") REFERENCES "instructor" ("ID")
);

-- Table: enrollment
CREATE TABLE "enrollment" (
    "ID" INTEGER NOT NULL PRIMARY KEY,
    "std_id" INTEGER NOT NULL,
    "course_id" INTEGER NOT NULL,
    "mark" INTEGER,
    "passed" TEXT CHECK ("passed" IN ('Y', 'N')),
    "enrolled" TEXT CHECK ("enrolled" IN ('Y', 'N')),
    FOREIGN KEY ("std_id") REFERENCES "student" ("ID"),
    FOREIGN KEY ("course_id") REFERENCES "course" ("ID")
);

-- To view all departments under each faculty along with their manager.
CREATE VIEW "faculty_department_overview" AS
SELECT
    "faculty"."fac_name" AS "faculty_name",
    "faculty"."fac_manager" AS "faculty_manager",
    "department"."dept_name" AS "department_name",
    "department"."phone" AS "department_phone",
    "department"."email" AS "department_email"
FROM
    "faculty"
JOIN
    "department" ON "faculty"."ID" = "department"."fac_id";

-- To provide a quick overview of student details along with their department and faculty.
CREATE VIEW "student_details" AS
SELECT
    "student"."ID" AS "student_id",
    "student"."name" AS "student_name",
    "student"."phone" AS "phone",
    "student"."email" AS "email",
    "department"."dept_name" AS "department_name",
    "faculty"."fac_name" AS "faculty_name"
FROM
    "student"
JOIN
    "department" ON "student"."dept_id" = "department"."ID"
JOIN
    "faculty" ON "department"."fac_id" = "faculty"."ID";

-- To list instructors with their department and faculty details.
CREATE VIEW "instructor_details" AS
SELECT
    "instructor"."ID" AS "instructor_id",
    "instructor"."name" AS "instructor_name",
    "instructor"."phone" AS "phone",
    "instructor"."email" AS "email",
    "instructor"."salary" AS "salary",
    "department"."dept_name" AS "department_name",
    "faculty"."fac_name" AS "faculty_name"
FROM
    "instructor"
JOIN
    "department" ON "instructor"."dept_id" = "department"."ID"
JOIN
    "faculty" ON "department"."fac_id" = "faculty"."ID";

-- To summarize enrollment data for courses, including the number of students enrolled and their average grade.
CREATE VIEW "enrollment_summary" AS
SELECT
    "course"."ID" AS "course_id",
    "course"."title" AS "course_title",
    "course"."credits" AS "credits",
    COUNT("enrollment"."ID") AS "total_students",
    AVG("enrollment"."mark") AS "average_grade"
FROM
    "course"
LEFT JOIN
    "enrollment" ON "course"."ID" = "enrollment"."course_id"
GROUP BY
    "course"."ID", "course"."title", "course"."credits";

-- To display courses and their prerequisites in a single view.
CREATE VIEW "course_with_prerequisites" AS
SELECT
    c1."ID" AS "course_id",
    c1."title" AS "course_title",
    c1."credits" AS "course_credits",
    c2."ID" AS "prerequisite_course_id",
    c2."title" AS "prerequisite_course_title"
FROM
    "course" c1
LEFT JOIN
    "prerequisite" ON c1."ID" = "prerequisite"."course_id"
LEFT JOIN
    "course" c2 ON "prerequisite"."pre_course_id" = c2."ID";

-- Index for "student"."dept_id" to optimize queries joining "student" and "department"
CREATE INDEX "idx_student_dept_id" ON "student" ("dept_id");

-- Index for "instructor"."dept_id" to optimize queries joining "instructor" and "department"
CREATE INDEX "idx_instructor_dept_id" ON "instructor" ("dept_id");

-- Index for "teaches" to optimize queries for join.
CREATE INDEX "idx_teaches_course_id" ON "teaches" ("course_id");
CREATE INDEX "idx_teaches_inst_id" ON "teaches" ("inst_id");

-- Index for "teaches"."year" and "teaches"."semester" to optimize filtering by year and semester
CREATE INDEX "idx_teaches_year_semester" ON "teaches" ("year", "semester");

-- Index for "enrollment"."std_id" to optimize queries joining "enrollment" and "student"
CREATE INDEX "idx_enrollment_std_id" ON "enrollment" ("std_id");

-- Index for "enrollment"."course_id" to optimize queries joining "enrollment" and "course"
CREATE INDEX "idx_enrollment_course_id" ON "enrollment" ("course_id");

-- Index for "enrollment"."passed" to optimize filtering by passed status
CREATE INDEX "idx_enrollment_passed" ON "enrollment" ("passed");
