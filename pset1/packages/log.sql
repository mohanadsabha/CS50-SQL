
-- *** The Lost Letter ***

SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue';
SELECT "id" FROM "addresses" WHERE "address" = '2 Finnigan Street';

SELECT "id" FROM "packages" WHERE "from_address_id" = (
    SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue')
AND "to_address_id" = (
    SELECT "id" FROM "addresses" WHERE "address" = '2 Finnigan Street');

SELECT "address_id" FROM "scans" WHERE "package_id" = (
    SELECT "id" FROM "packages" WHERE "from_address_id" = (
        SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue')
    AND "to_address_id" = (
        SELECT "id" FROM "addresses" WHERE "address" = '2 Finnigan Street')
) AND "action" = 'Drop';

SELECT "address", "type" FROM "addresses" WHERE "id" = (
    SELECT "address_id" FROM "scans" WHERE "package_id" = (
        SELECT "id" FROM "packages" WHERE "from_address_id" = (
            SELECT "id" FROM "addresses" WHERE "address" = '900 Somerville Avenue')
        AND "to_address_id" = (
            SELECT "id" FROM "addresses" WHERE "address" = '2 Finnigan Street')
    ) AND "action" = 'Drop'
);


-- *** The Devious Delivery ***

SELECT * FROM "packages"
WHERE "from_address_id" IS NULL;

SELECT "id" FROM "packages"
WHERE "from_address_id" IS NULL;

SELECT * FROM "scans"
WHERE "package_id" = (
	SELECT "id" FROM "packages"
	WHERE "from_address_id" IS NULL
) AND "action" = "Drop";

SELECT "address", "type" FROM "addresses"
WHERE "id" = (
SELECT "address_id" FROM "scans"
WHERE "package_id" = (
    	SELECT "id" FROM "packages"
    	WHERE "from_address_id" IS NULL
    ) AND "action" = "Drop"
);


-- *** The Forgotten Gift ***

SELECT "id" FROM "addresses"
WHERE "address" = '109 Tileston Street';

SELECT * FROM "packages"
WHERE "from_address_id" = (
	SELECT "id" FROM "addresses"
	WHERE "address" = '109 Tileston Street'
);

SELECT "driver_id" FROM "scans"
WHERE "package_id" = (
	SELECT "id" FROM "packages"
	WHERE "from_address_id" = (
		SELECT "id" FROM "addresses"
		WHERE "address" = '109 Tileston Street'
	)
)
ORDER BY "timestamp" DESC
LIMIT 1;

SELECT "name" FROM "drivers"
	WHERE "id" = (
	SELECT "driver_id" FROM "scans"
	WHERE "package_id" = (
		SELECT "id" FROM "packages"
		WHERE "from_address_id" = (
			SELECT "id" FROM "addresses"
			WHERE "address" = '109 Tileston Street'
		)
	)
ORDER BY "timestamp" DESC
LIMIT 1
);
