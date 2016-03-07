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
import model.laboratoryModel;

/**
 *
 * @author CARLOS ANTONIO
 */
public class laboratoryControl {
    public static void main(String[] args) {
        
    }
    public boolean deleteLaboratory(laboratoryModel dataLaboratory){
        boolean result;
        String procedure = "CALL `pto_set_laboratory`('delete', "+dataLaboratory.getPk_laboratory()+", null, null, null)";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result=true;
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=false;
            System.err.println(e.getMessage());
        } 
        return result;
    }
    public boolean addLaboratory(laboratoryModel dataLaboratory){
        boolean result;
        String procedure = "CALL `pto_set_laboratory`('insert', null, '"+dataLaboratory.getFl_name()+"', '"+dataLaboratory.getFl_description()+"', "+dataLaboratory.getPk_user()+")";
        try {
            Connection conn=new conectionControl().getConexion();
            try (PreparedStatement ps = conn.prepareStatement(procedure)) {
                ps.executeUpdate();
                result=true;
                ps.close();
                conn.close();
            }
        } catch (SQLException e) {
            result=false;
            System.err.println(e.getMessage());
        } 
        return result;
    }
    public ArrayList<laboratoryModel>  selectLaboratories(String pt_user, String pt_order, String pt_type){
        ArrayList<laboratoryModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_laboratory`('allLabaratoriesByUser', "+pt_user+", '"+pt_order+"', '"+pt_type+"')";
        try {
            try (Connection conn = new conectionControl().getConexion(); PreparedStatement ps = conn.prepareStatement(procedure); ResultSet res = ps.executeQuery()) {
                while(res!=null&&res.next()){
                    laboratoryModel allData=new laboratoryModel();
                    allData.setPk_laboratory(res.getInt("pk_laboratory"));
                    allData.setFl_name(res.getString("fl_name"));
                    allData.setFl_description(res.getString("fl_description"));
                    allData.setFl_cant_computers(res.getString("fl_cant_computers"));
                    allData.setFl_row_create_date(res.getString("fl_row_create_date"));
                    allData.setFl_row_update_date(res.getString("fl_row_update_date"));
                    allData.setPk_user(res.getInt("fk_user"));
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
}
