package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.userModel;

/**
 *
 * @author CARLOS ANTONIO
 */
public class userControl {
    public static void main(String[] args) {
        userModel obj = new userModel();
        obj.setFl_user_name("carlos");
        obj.setFl_password("12345");
        
    }
    public String changePasswordUser(String pt_user, String pt_newPassword){
        String result;
        String procedure = "CALL `pto_set_user`('changePassword', null, ?, ?, null, null, null, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.setString(2, pt_newPassword);
            ps.executeUpdate();
            result="Success";
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
    public boolean userStatusKeyRequestNewPassword(String pt_user, int pt_count_change_password){
        String procedure="CALL `pto_get_user`('userKeyRequestNewPassword', null, ?, ?)";
        boolean result = false;
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.setInt(2, pt_count_change_password);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                result = res.getString("result").equals("1");
            }
            if(res!=null){
                res.close();
            }
            ps.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public ArrayList<userModel>  selectUser(String pt_user){
        ArrayList<userModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_user`('userByUserName', null, ?, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                userModel allData=new userModel();
                allData.setPk_user(res.getInt("pk_user"));
                allData.setFl_user_name(res.getString("fl_user_name"));
                allData.setFl_mail(res.getString("fl_mail"));
                allData.setFl_status_acount(res.getString("fl_status_acount"));
                allData.setFl_password_changed_count(res.getInt("fl_password_changed_count"));
                list.add(allData);
            }
            if(res!=null){
                res.close();
            }
            ps.close();
            conn.close();
            return list;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public String resetKeyPasswordUser(String pt_user){
        String result;
        String procedure = "CALL `pto_set_user`('resetKeyRequestNewPassword', null, ?, null, null, null, null, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.executeUpdate();
            result="Clave temporal reseteada";
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        }
        return result;
    }
    public String resetPasswordUser(String pt_user){
        String result;
        String procedure = "CALL `pto_set_user`('requestNewPassword', null, ?, null, null, null, null, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.executeUpdate();
            result="Clave temporal reseteada";
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        }
        return result;
    }
    public String activateAcountUser(userModel dataUser){
        String result;
        String procedure = "CALL `pto_set_user`('activateAcount', null, ?, null, null, null, null, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, dataUser.getFl_user_name());
            ps.executeUpdate();
            result="Cuenta Activada";
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
    public ArrayList<userModel>  userLogin(userModel dataUser){
        ArrayList<userModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_login`('login', ?, ?)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, dataUser.getFl_user_name());
            ps.setString(2, dataUser.getFl_password());
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                userModel allData=new userModel();
                allData.setPk_user(res.getInt("pk_user"));
                allData.setFl_user_name(res.getString("fl_user_name"));
                allData.setFl_mail(res.getString("fl_mail"));
                allData.setFl_status_acount(res.getString("fl_status_acount"));
                list.add(allData);
            }
            if(res!=null){
                res.close();
            }
            ps.close();
            conn.close();
            return list;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public boolean mailOrUserNameValidate(String pt_user){
        String procedure="CALL `pto_get_login`('userRequestNewPassword', ?, null)";
        boolean result = false;
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                result = res.getString("result").equals("1");
            }
            if(res!=null){
                res.close();
            }
            ps.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public boolean mailValidate(String pt_mail){
        String procedure="CALL `pto_get_login`('mailValidate', ?, null)";
        boolean result = false;
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_mail);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                result = res.getString("result").equals("0");
            }
            if(res!=null){
                res.close();
            }
            ps.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public boolean userValidate(String pt_user){
        String procedure="CALL `pto_get_login`('userValidate', ?, null)";
        boolean result = false;
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                result = res.getString("result").equals("0");
            }
            if(res!=null){
                res.close();
            }
            ps.close();
            conn.close();
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public String addUser(userModel dataUser){
        String result;
        String procedure = "CALL `pto_set_user`('insert', null, ?, ?, ?, null, null, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, dataUser.getFl_user_name());
            ps.setString(2, dataUser.getFl_password());
            ps.setString(3, dataUser.getFl_mail());
            ps.executeUpdate();
            result="Datos Guardados";
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
}
