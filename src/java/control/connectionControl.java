package control;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Carlos
 */
public class connectionControl {
    public Connection getConnection(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return java.sql.DriverManager.getConnection("jdbc:mysql://localhost/db_sizlab", "root", "");
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(connectionControl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
