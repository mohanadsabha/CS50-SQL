CREATE INDEX "index_course_department" ON "courses" ("department");
CREATE INDEX "index_course_semester" ON "courses" ("semester");
CREATE INDEX "index_courses_dept_num_sem" ON "courses" ("department", "number", "semester");

CREATE INDEX "index_enrollments_student_course" ON "enrollments" ("course_id", "student_id");
CREATE INDEX "index_enrollments_course_id" ON "enrollments" ("course_id");

CREATE INDEX "index_satisfies_course_id" ON "satisfies" ("course_id");
CREATE INDEX "index_satisfies_requirment_id" ON "satisfies" ("requirment_id");
