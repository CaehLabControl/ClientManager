/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.mysql.model.ItemsMenuModel;

/**
 *
 * @author Carlos
 */
public interface ItemsMenuDAO extends GenericDAO<Integer, ItemsMenuModel>{
    ArrayList<ItemsMenuModel>  selectItemsMenu(int pk_user, int pt_section) throws DAOException, SQLException;
    ArrayList<ItemsMenuModel>  groupItemsMenu(int pk_user) throws DAOException, SQLException;
}
