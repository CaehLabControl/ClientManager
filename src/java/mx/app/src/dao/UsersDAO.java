/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.mysql.model.UsersModel;

/**
 *
 * @author Carlos
 */
public interface UsersDAO extends GenericDAO<Integer, UsersModel>{
    String changePasswordUser(String pt_user, String pt_newPassword) throws DAOException, SQLException;
    boolean userStatusKeyRequestNewPassword(String pt_user, int pt_count_change_password) throws DAOException, SQLException;
    ArrayList<UsersModel> selectUser(String pt_user)throws DAOException, SQLException;
    public String resetKeyPasswordUser(String pt_user)throws DAOException, SQLException;
    String resetPasswordUser(String pt_user)throws DAOException, SQLException;
    String activateAcountUser(UsersModel dataUser)throws DAOException, SQLException;
    ArrayList<UsersModel> userLogin(UsersModel dataUser) throws DAOException, SQLException;
    boolean mailOrUserNameValidate(String pt_user)throws DAOException, SQLException;
    boolean mailValidate(String pt_mail) throws DAOException, SQLException;
    boolean userValidate(String pt_user) throws DAOException, SQLException;
}
