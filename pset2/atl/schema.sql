CREATE TABLE "passengers" (
"id" INTEGER,
"first_name" TEXT NOT NULL,
"last_name" TEXT NOT NULL,
"age" NUMERIC,
PRIMARY KEY("id")
);

CREATE TABLE "airlines" (
"id" INTEGER,
"name" TEXT NOT NULL,
"concourse" TEXT NOT NULL CHECK("concourse" IN ('A', 'B', 'C', 'D', 'E', 'F', 'T')),
PRIMARY KEY("id")
);

CREATE TABLE "flights" (
"id" INTEGER,
"flight_number" NUMERIC NOT NULL,
"airline_id" INTEGER,
"depart_from" TEXT NOT NULL,
"head_to" TEXT NOT NULL,
"departure_date" NUMERIC,
"arrival_date" NUMERIC,
PRIMARY KEY("id"),
FOREIGN KEY("airline_id") REFERENCES "airlines"("id")
);

CREATE TABLE "check_in" (
"passenger_id" INTEGER,
"flight_id" INTEGER,
"datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
FOREIGN KEY("flight_id") REFERENCES "flights"("id")
);
