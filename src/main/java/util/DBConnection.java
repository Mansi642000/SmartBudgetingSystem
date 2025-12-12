package util;

import java.sql.Connection;
import java.sql.DriverManager;
public class DBConnection {
	public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Read DB connection settings from environment variables for security.
            // Configure these variables in your OS or Docker container, not hard-coded.
            String url = System.getenv("DB_URL");
            if (url == null || url.trim().isEmpty()) {
                // Default fallback for local development (override using DB_URL)
                url = "jdbc:mysql://localhost:3306/smart_grocery";
            }
            String user = System.getenv("DB_USER");
            if (user == null || user.trim().isEmpty()) {
                user = "root"; // fallback default for existing dev setup
            }
            String password = System.getenv("DB_PASS");
            if (password == null) {
                password = "Mansi@642000"; // fallback to empty; set DB_PASS explicitly in production
            }
            conn = DriverManager.getConnection(url, user, password);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
