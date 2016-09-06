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
import mx.app.src.dao.LaboratoriesDAO;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.dao.extend.MySQLUtil;
import mx.app.src.mysql.model.LaboratoriesModel;
import mx.app.src.mysql.model.UsersModel;


/**
 *
 * @author Carlos
 */
public class LaboratoriesControl implements LaboratoriesDAO{
    private String procedure = null;
    private final Connection conn;
    public LaboratoriesControl() throws ClassNotFoundException {
        conn = new connectionControl().getConnection();
    }
    @Override
    public ArrayList<LaboratoriesModel> selectLaboratories(String pt_user, String pt_order, String pt_type) throws DAOException, SQLException {
        ArrayList<LaboratoriesModel> list=new ArrayList<>();
        procedure="CALL `pto_get_laboratory`('allLabaratoriesByUser', ?, ?, ?)";
        PreparedStatement ps = null; 
        ResultSet rs = null;
        try {            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.setString(2, pt_order);
            ps.setString(3, pt_type);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                UsersModel uM = new UsersModel();
                LaboratoriesModel allData=new LaboratoriesModel();
                allData.setPk_laboratory(rs.getInt("pk_laboratory"));
                allData.setFl_name(rs.getString("fl_name"));
                allData.setFl_description(rs.getString("fl_description"));
                allData.setFl_cant_computers(rs.getInt("fl_cant_computers"));
                allData.setFl_row_create_date(rs.getString("fl_row_create_date"));
                allData.setFl_row_update_date(rs.getString("fl_row_update_date"));
                uM.setPk_user(rs.getInt("fk_user"));
                allData.setMl_user(uM);
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
    public String Insert(LaboratoriesModel data) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_laboratory`('insert', null, ?, ?, ?)";
        PreparedStatement ps = null;
        try {                         
            ps = conn.prepareStatement(procedure);            
            ps.setString(1, data.getFl_name());
            ps.setString(2, data.getFl_description());
            ps.setInt(3, data.getMl_user().getPk_user());
            ps.executeUpdate();
            result="Inserted";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        }
        return result;
    }

    @Override
    public String Update(LaboratoriesModel data) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_laboratory`('update', ?, ?, ?, null)";
        PreparedStatement ps = null;          
        try {            
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, data.getPk_laboratory());
            ps.setString(2, data.getFl_name());
            ps.setString(3, data.getFl_description());
            ps.executeUpdate();
            result="Updated";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        }
        return result;
    }

    @Override
    public String Delete(Integer key) throws DAOException, SQLException {
        String result;
        procedure = "CALL `pto_set_laboratory`('delete', ?, null, null, null)";
        PreparedStatement ps = null;
        try {          
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, key);
            ps.executeUpdate();
            result="Deleted";
        }catch (SQLException ex) {
            throw new DAOException("Error SQL "+ex);
        }finally{
            MySQLUtil.close(conn);
            MySQLUtil.close(ps);
        } 
        return result;
    }
    
    public static void main(String[] args) throws ClassNotFoundException, DAOException, SQLException {
        int pk_user = 20;
        UsersModel uM = new UsersModel();
        LaboratoriesModel obj = new LaboratoriesModel();                    
        obj.setFl_name("LAB32");
        obj.setFl_description("FDFGDFGD");
        uM.setPk_user(pk_user);
        obj.setMl_user(uM);
        System.out.print(new LaboratoriesControl().Insert(obj));
    }
    
}
