/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.mysql.control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import mx.app.src.dao.UsersDAO;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.dao.extend.MySQLUtil;
import mx.app.src.mysql.model.UsersModel;



/**
 *
 * @author Carlos
 */
public class UsersControl implements UsersDAO{
    private String procedure = null;
    private final Connection conn;
    public UsersControl() throws ClassNotFoundException {
        conn = new connectionControl().getConnection();
    }

    @Override
    public String changePasswordUser(String pt_user, String pt_newPassword) throws DAOException, SQLException {
        String rsult;
        procedure = "CALL `pto_set_user`('changePassword', null, ?, ?, null, null, null, null)";
        PreparedStatement ps = null;
        try {                      
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.setString(2, pt_newPassword);
            ps.executeUpdate();
            rsult="Success";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        } 
        return rsult;
    }

    @Override
    public boolean userStatusKeyRequestNewPassword(String pt_user, int pt_count_change_password)throws DAOException, SQLException{
        procedure="CALL `pto_get_user`('userKeyRequestNewPassword', null, ?, ?)";
        boolean rsult = false;
        PreparedStatement ps = null; 
        ResultSet rs = null;
        try {           
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.setInt(2, pt_count_change_password);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                rsult = rs.getString("rsult").equals("1");
            }
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps, rs);
        }
        return rsult;
    }

    @Override
    public ArrayList<UsersModel> selectUser(String pt_user)throws DAOException, SQLException{
        ArrayList<UsersModel> list=new ArrayList<>();
        procedure="CALL `pto_get_user`('userByUserName', null, ?, null)";
        PreparedStatement ps = null; 
        ResultSet rs = null; 
        try {                     
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                UsersModel allData=new UsersModel();
                allData.setPk_user(rs.getInt("pk_user"));
                allData.setFl_user_name(rs.getString("fl_user_name"));
                allData.setFl_mail(rs.getString("fl_mail"));
                allData.setFl_status_acount(rs.getInt("fl_status_acount"));
                allData.setFl_password_changed_count(rs.getInt("fl_password_changed_count"));
                list.add(allData);
            }
        } catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps, rs);
        }
        return list;
    }

    @Override
    public String resetKeyPasswordUser(String pt_user) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_user`('resetKeyRequestNewPassword', null, ?, null, null, null, null, null)";
        PreparedStatement ps = null;        
        try {                
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.executeUpdate();
            result="Clave temporal reseteada";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        }
        return result;
    }

    @Override
    public String resetPasswordUser(String pt_user) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_user`('requestNewPassword', null, ?, null, null, null, null, null)";
        PreparedStatement ps = null;
        try {                       
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.executeUpdate();
            result="Clave temporal reseteada";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        }
        return result;
    }

    @Override
    public String activateAcountUser(UsersModel dataUser) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_user`('activateAcount', null, ?, null, null, null, null, null)";
        PreparedStatement ps = null;
        try {                        
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, dataUser.getFl_user_name());
            ps.executeUpdate();
            result="Cuenta Activada";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        }
        return result;
    }

    @Override
    public ArrayList<UsersModel> userLogin(UsersModel dataUser) throws DAOException, SQLException {
        ArrayList<UsersModel> list=new ArrayList<>();
        procedure="CALL `pto_get_login`('login', ?, ?)";
        PreparedStatement ps = null; 
        ResultSet rs = null;
        try {           
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, dataUser.getFl_user_name());
            ps.setString(2, dataUser.getFl_password());
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                UsersModel allData=new UsersModel();
                allData.setPk_user(rs.getInt("pk_user"));
                allData.setFl_user_name(rs.getString("fl_user_name"));
                allData.setFl_mail(rs.getString("fl_mail"));
                allData.setFl_status_acount(rs.getInt("fl_status_acount"));
                list.add(allData);
            }
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps, rs);
        }
        return list;
    }

    @Override
    public boolean mailOrUserNameValidate(String pt_user) throws DAOException, SQLException {
        procedure="CALL `pto_get_login`('userRequestNewPassword', ?, null)";
        boolean result = false;
        PreparedStatement ps = null; 
        ResultSet rs = null;
        try {                       
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                result = rs.getString("result").equals("1");
            }
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps, rs);
        }
        return result;
    }

    @Override
    public boolean mailValidate(String pt_mail) throws DAOException, SQLException {
        procedure="CALL `pto_get_login`('mailValidate', ?, null)";
        boolean result = false;
        PreparedStatement ps = null; 
        ResultSet rs =  null;
        try {           
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_mail);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                result = rs.getString("result").equals("0");
            }
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps, rs);
        }
        return result;
    }

    @Override
    public boolean userValidate(String pt_user) throws DAOException, SQLException {
        procedure="CALL `pto_get_login`('userValidate', ?, null)";
        boolean result = false;
        PreparedStatement ps = null; 
        ResultSet rs = null; 
        try {
                      
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                result = rs.getString("result").equals("0");
            }
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps, rs);
        }
        return result;
    }
    @Override
    public String Insert(UsersModel data) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_user`('insert', null, ?, ?, ?, null, null, null)";
        PreparedStatement ps = null; 
        try {                        
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, data.getFl_user_name());
            ps.setString(2, data.getFl_password());
            ps.setString(3, data.getFl_mail());
            ps.executeUpdate();
            result="Datos Guardados";
            ps.close();
            conn.close();
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        } 
        return result;
    }

    @Override
    public String Update(UsersModel obj) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }   
    
    @Override
    public String Delete(Integer key) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
