/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.dao;

import mx.app.src.dao.extend.DAOException;
import java.sql.SQLException;

/**
 *
 * @author Carlos
 * @param <K>
 * @param <C>
 */
public interface GenericDAO<K,C> {
    String Insert(C data) throws DAOException, SQLException;
    String Update(C data) throws DAOException, SQLException;
    String Delete(K key) throws DAOException, SQLException;
}
