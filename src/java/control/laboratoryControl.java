package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.laboratoryModel;
import model.userModel;

/**
 *
 * @author CARLOS ANTONIO
 */
public class laboratoryControl {
    public static void main(String[] args) {
        
    }
    public boolean updateLaboratory(laboratoryModel dataLaboratory){
        boolean result;
        String procedure = "CALL `pto_set_laboratory`('update', ?, ?, ?, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, dataLaboratory.getPk_laboratory());
            ps.setString(2, dataLaboratory.getFl_name());
            ps.setString(3, dataLaboratory.getFl_description());
            ps.executeUpdate();
            result=true;
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=false;
            e.getMessage();
        } 
        return result;
    }
    public boolean deleteLaboratory(laboratoryModel dataLaboratory){
        boolean result;
        String procedure = "CALL `pto_set_laboratory`('delete', ?, null, null, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, dataLaboratory.getPk_laboratory());
            ps.executeUpdate();
            result=true;
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=false;
            e.getMessage();
        }  
        return result;
    }
    public boolean addLaboratory(laboratoryModel dataLaboratory){
        boolean result;
        String procedure = "CALL `pto_set_laboratory`('insert', null, '"+dataLaboratory.getFl_name()+"', '"+dataLaboratory.getFl_description()+"', "+dataLaboratory.getUm().getPk_user()+")";
        try {
            Connection conn; 
            PreparedStatement ps; 
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure);            
            ps.setString(1, dataLaboratory.getFl_name());
            ps.setString(2, dataLaboratory.getFl_description());
            ps.setInt(3, dataLaboratory.getUm().getPk_user());
            ps.executeUpdate();
            result=true;
            ps.close();
            conn.close();
        } catch (SQLException e) {
            result=false;
            e.getMessage();
        } 
        return result;
    }
    public ArrayList<laboratoryModel>  selectLaboratories(String pt_user, String pt_order, String pt_type){
        ArrayList<laboratoryModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_laboratory`('allLabaratoriesByUser', ?, ?, ?)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setString(1, pt_user);
            ps.setString(2, pt_order);
            ps.setString(3, pt_type);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                userModel uM = new userModel();
                laboratoryModel allData=new laboratoryModel(uM);
                allData.setPk_laboratory(res.getInt("pk_laboratory"));
                allData.setFl_name(res.getString("fl_name"));
                allData.setFl_description(res.getString("fl_description"));
                allData.setFl_cant_computers(res.getString("fl_cant_computers"));
                allData.setFl_row_create_date(res.getString("fl_row_create_date"));
                allData.setFl_row_update_date(res.getString("fl_row_update_date"));
                uM.setPk_user(res.getInt("fk_user"));
                allData.setUm(uM);
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
}
