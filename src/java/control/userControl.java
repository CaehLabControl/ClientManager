/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
        
    }
    public String changePasswordUser(String pt_user, String pt_newPassword){
        String result;
        String procedure = "CALL `pto_set_user`('changePassword', null, '"+pt_user+"', '"+pt_newPassword+"', null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result="Success";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
    public boolean userStatusKeyRequestNewPassword(String pt_user, int pt_count_change_password){
        String procedure="CALL `pto_get_user`('userKeyRequestNewPassword', null, '"+pt_user+"', "+pt_count_change_password+")";
        boolean result = false;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result = res.getString("result").equals("1");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public ArrayList<userModel>  selectUser(String pt_user){
        ArrayList<userModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_user`('userByUserName', null, '"+pt_user+"', null)";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    userModel allData=new userModel();
                    allData.setPk_user(res.getInt("pk_user"));
                    allData.setFl_user_name(res.getString("fl_user_name"));
                    allData.setFl_mail(res.getString("fl_mail"));
                    allData.setFl_status_acount(res.getString("fl_status_acount"));
                    allData.setFl_password_changed_count(res.getInt("fl_password_changed_count"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public String resetKeyPasswordUser(String pt_user){
        String result;
        String procedure = "CALL `pto_set_user`('resetKeyRequestNewPassword', null, '"+pt_user+"', null, null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result="Clave temporal reseteada";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
    public String resetPasswordUser(String pt_user){
        String result;
        String procedure = "CALL `pto_set_user`('requestNewPassword', null, '"+pt_user+"', null, null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result="Clave temporal generada";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
    public String activateAcountUser(userModel dataUser){
        String result;
        String procedure = "CALL `pto_set_user`('activateAcount', null, '"+dataUser.getFl_user_name()+"', null, null, null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result="Cuenta Activada";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
    public ArrayList<userModel>  userLogin(userModel dataUser){
        ArrayList<userModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_login`('login', '"+dataUser.getFl_user_name()+"', '"+dataUser.getFl_password()+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    userModel allData=new userModel();
                    allData.setPk_user(res.getInt("pk_user"));
                    allData.setFl_user_name(res.getString("fl_user_name"));
                    allData.setFl_mail(res.getString("fl_mail"));
                    allData.setFl_status_acount(res.getString("fl_status_acount"));
                    list.add(allData);
                }
                res.close();
                ps.close();
                conn.close();
            }
            return list;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return list;
    }
    public boolean mailOrUserNameValidate(String pt_user){
        String procedure="CALL `pto_get_login`('userRequestNewPassword', '"+pt_user+"', null)";
       boolean result = false;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result = res.getString("result").equals("1");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public boolean mailValidate(String pt_mail){
        String procedure="CALL `pto_get_login`('mailValidate', '"+pt_mail+"', null)";
       boolean result = false;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result = res.getString("result").equals("0");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public boolean userValidate(String pt_user){
        String procedure="CALL `pto_get_login`('userValidate', '"+pt_user+"', null)";
       boolean result = false;
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    result = res.getString("result").equals("0");
                }
                res.close();
                ps.close();
                conn.close();
            }
            return result;
        } catch (SQLException ex) {
            System.err.println(ex);
        }
        return result;
    }
    public String addUser(userModel dataUser){
        String result;
        String procedure = "CALL `pto_set_user`('insert', null, '"+dataUser.getFl_user_name()+"', '"+dataUser.getFl_password()+"', '"+dataUser.getFl_mail()+"', null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result="Datos Guardados";
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=""+e.getMessage();
            e.getMessage();
        } 
        return result;
    }
}
