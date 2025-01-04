CREATE TABLE "meteorites" (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "class" TEXT NOT NULL,
    "mass" REAL,
    "discovery" TEXT NOT NULL CHECK("discovery" IN ('Fell', 'Found')),
    "year" INTEGER,
    "lat" REAL,
    "long" REAL,
    PRIMARY KEY("id")
);

CREATE TABLE "meteorites_temp" (
    "name" TEXT NOT NULL,
    "id" INTEGER,
    "nametype" TEXT,
    "class" TEXT NOT NULL,
    "mass" NUMERIC,
    "discovery" TEXT NOT NULL CHECK("discovery" IN ('Fell', 'Found')),
    "year" INTEGER,
    "lat" NUMERIC,
    "long" NUMERIC,
    PRIMARY KEY("id")
);

.import --csv --skip 1  meteorites.csv  meteorites_temp

DELETE FROM "meteorites_temp" WHERE "nametype" = 'Relict';

UPDATE "meteorites_temp"
SET "mass" = NULL
WHERE "mass" = 0;

UPDATE "meteorites_temp"
SET "lat" = NULL
WHERE "lat" = 0;

UPDATE "meteorites_temp"
SET "long" = NULL
WHERE "long" = 0;

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" = 0;

UPDATE "meteorites_temp"
SET "year" = NULL
WHERE "year" LIKE '';

UPDATE "meteorites_temp"
SET "mass" = ROUND("mass", 2),
    "lat" = ROUND("mass", 2),
    "long" = ROUND("mass", 2);

INSERT INTO "meteorites" ("name", "class", "mass", "discovery", "year", "lat", "long")
SELECT "name", "class", "mass", "discovery", "year", "lat", "long"
FROM "meteorites_temp"
ORDER BY "year", "name";
