from cs50 import SQL

db = SQL("sqlite:///dont-panic.db")

db.execute(
    """
    INSERT INTO "user_logs" ("type", "old_username", "new_username", "old_password", "new_password")
    VALUES ('update', 'admin', 'admin', (
        SELECT "password" FROM "users" WHERE "username" = 'admin'
    ), (
        SELECT "password" FROM "users" WHERE "username" = 'emily33'
    ));
    """
)

password = input("Enter a password: ")
db.execute(
    """
    UPDATE "users"
    SET "password" = ?
    WHERE "username" = 'admin';
    """,
    password
)

db.execute(
    """
    DELETE FROM "user_logs" WHERE "old_username" = 'admin' AND "new_password" = (
        SELECT "password" FROM "users" WHERE "username" = 'admin'
    );
    """
)

print("Happy Hack!")
