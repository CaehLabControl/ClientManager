/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.mysql.control;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import mx.app.src.dao.ComputersDAO;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.mysql.model.ComputersModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Carlos
 */
public class ComputersControl implements ComputersDAO{

    @Override
    public String Insert(ComputersModel data) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String Update(ComputersModel data) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String Delete(Integer key) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
