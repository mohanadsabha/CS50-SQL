import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.Scanner;

public class Hack {
    public static void main(String[] args) throws Exception {
        // Get input
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the new password: ");
        String password = scanner.nextLine();

        // Make Connection
        Connection sqliteConnection = DriverManager.getConnection("jdbc:sqlite:dont-panic.db");

        // SQL Statment for emily33
        Statement sqliteStatement = sqliteConnection.createStatement();
        sqliteStatement.executeUpdate("""
            INSERT INTO "user_logs" ("type", "old_username", "new_username", "old_password", "new_password")
            VALUES ('update', 'admin', 'admin', (
                SELECT "password" FROM "users" WHERE "username" = 'admin'
            ), (
                SELECT "password" FROM "users" WHERE "username" = 'emily33'
            ));
        """);

        // The prepared query for the input
        String query = """
            UPDATE "users"
            SET "password" = ?
            WHERE "username" = 'admin';
        """;
        PreparedStatement sqlitePreparedStatement = sqliteConnection.prepareStatement(query);
        sqlitePreparedStatement.setString(1, password);
        sqlitePreparedStatement.executeUpdate();

        // Clean up my foot steps..
        sqliteStatement.executeUpdate("""
            DELETE FROM "user_logs" WHERE "old_username" = 'admin' AND "new_password" = (
                SELECT "password" FROM "users" WHERE "username" = 'admin'
            );
        """);

        System.out.println("Happy Hack!");

        sqliteConnection.close();
        scanner.close();
    }
}
