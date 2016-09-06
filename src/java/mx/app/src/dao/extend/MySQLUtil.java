package mx.app.src.dao.extend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Carlos
 */
public class MySQLUtil {
    public static void close(PreparedStatement ps) throws DAOException {
        if(ps!=null){
            try {
                ps.close();
            } catch (SQLException ex) {
                throw new  DAOException("Error SQL "+ex);
            }
        }        
    }

    public static void close(PreparedStatement ps, ResultSet rs) throws DAOException {
        if(ps != null){
            try {
                ps.close();
            } catch (SQLException ex) {
                throw new  DAOException("Error SQL "+ex);
            }
        }
        if(rs != null){
            try {
                rs.close();
            } catch (SQLException ex) {
                throw new  DAOException("Error SQL "+ex);
            }
        }
    }

    public static void close(Connection conn) throws SQLException {
        if(conn!=null){
            conn.close();
        }
    }
}
