CREATE TABLE "ingredients" (
"id" INTEGER,
"name" TEXT NOT NULL,
"price" NUMERIC NOT NULL,
PRIMARY KEY("id")
);

CREATE TABLE "donuts" (
"id" INTEGER,
"name" TEXT NOT NULL,
"gluten_free" INTEGER NOT NULL CHECK("gluten_free" IN (0, 1)),
"price" NUMERIC NOT NULL,
PRIMARY KEY("id")
);

CREATE TABLE "customers" (
"id" INTEGER,
"first_name" TEXT NOT NULL,
"last_name" TEXT NOT NULL,
PRIMARY KEY("id")
);

CREATE TABLE "orders" (
"id" INTEGER,
"order_number" INTEGER,
"customer_id" INTEGER,
PRIMARY KEY("id"),
FOREIGN KEY("customer_id") REFERENCES "customers"("id")
);

CREATE TABLE "donut_ingred" (
"donut_id" INTEGER,
"ingredient_id" INTEGER,
PRIMARY KEY("donut_id", "ingredient_id"),
FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
FOREIGN KEY("ingredient_id") REFERENCES "ingredients"("id")
);

CREATE TABLE "donut_order" (
"order_id" INTEGER,
"donut_id" INTEGER,
"quantity" INTEGER NOT NULL CHECK("quantity" > 0),
FOREIGN KEY("donut_id") REFERENCES "donuts"("id"),
FOREIGN KEY("order_id") REFERENCES "orders"("id")
);
