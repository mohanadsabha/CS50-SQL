CREATE TABLE "users" (
"id" INTEGER,
"first_name" TEXT NOT NULL,
"last_name" TEXT,
"username" TEXT NOT NULL UNIQUE,
"password" TEXT NOT NULL,
PRIMARY KEY("id")
);

CREATE TABLE "schools" (
"id" INTEGER,
"name" TEXT NOT NULL,
"type" TEXT NOT NULL,
"location" TEXT,
"foundation_year" INTEGER,
PRIMARY KEY("id")
);

CREATE TABLE "companies" (
"id" INTEGER,
"name" TEXT NOT NULL,
"industry" TEXT NOT NULL,
"location" TEXT,
PRIMARY KEY("id")
);

CREATE TABLE "people_connections" (
"user_id" INTEGER,
"conn_user_id" INTEGER,
FOREIGN KEY("user_id") REFERENCES "users"("id"),
FOREIGN KEY("conn_user_id") REFERENCES "users"("id")
);

CREATE TABLE "school_connections" (
"user_id" INTEGER,
"school_id" INTEGER,
"start_date" NUMERIC NOT NULL,
"end_date" NUMERIC,
"degree_type" TEXT NOT NULL,
FOREIGN KEY("user_id") REFERENCES "users"("id"),
FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

CREATE TABLE "company_connections" (
"user_id" INTEGER,
"company_id" INTEGER,
"start_date" NUMERIC NOT NULL,
"end_date" NUMERIC,
"title" TEXT NOT NULL,
FOREIGN KEY("user_id") REFERENCES "users"("id"),
FOREIGN KEY("company_id") REFERENCES "companies"("id")
);
