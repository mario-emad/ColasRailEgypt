package classes_package;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ServerConnection {

    private final static String url = "jdbc:mysql://localhost/colas";
    private final static String username = "root";
    private final static String password = "";
    private static Connection connectionObject;

    public static Connection ConnectionMethod() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connectionObject = (Connection) DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ServerConnection.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ServerConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connectionObject;
    }
}
