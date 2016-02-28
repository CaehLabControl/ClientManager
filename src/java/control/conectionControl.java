/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Carlos
 */
public class conectionControl {
    public Connection getConexion(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return java.sql.DriverManager.getConnection("jdbc:mysql://localhost/db_sizlab", "root", "");
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(conectionControl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
