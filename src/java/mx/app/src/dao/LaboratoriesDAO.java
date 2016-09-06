/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.mysql.model.LaboratoriesModel;

/**
 *
 * @author Carlos
 */
public interface LaboratoriesDAO extends GenericDAO<Integer, LaboratoriesModel>{
    public ArrayList<LaboratoriesModel>  selectLaboratories(String pt_user, String pt_order, String pt_type) throws DAOException, SQLException;
}
