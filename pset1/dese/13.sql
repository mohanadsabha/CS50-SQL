SELECT "name", AVG("graduated") AS "graduation_rate"
FROM "schools" JOIN "graduation_rates" ON schools.id = graduation_rates.school_id
GROUP BY "city";
