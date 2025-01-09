CREATE VIEW "frequently_reviewed" AS
SELECT "listings"."id" AS "id", "property_type", "host_name", COUNT("reviews") AS "reviews"
FROM "listings" JOIN "reviews" ON "listings"."id" = "reviews"."listing_id"
GROUP BY "listings"."id"
ORDER BY "reviews" DESC
LIMIT 100;
