package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.menuModel;

/**
 *
 * @author CARLOS ANTONIO
 */
public class menuControl {
    public static void main(String[] args) {
        ArrayList<menuModel> list=new menuControl().selectItemsMenu(1,3);
        if(list.size()>0){
            for (menuModel list1 : list) {
                System.out.println(list1.getPk_item_menu());
            }
        }
    }
    public ArrayList<menuModel>  selectItemsMenu(int pk_user, int pt_section){
        ArrayList<menuModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_items_menu`('allItemsMenu', ?, ?)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, pk_user);
            ps.setInt(2, pt_section);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                menuModel allData=new menuModel();
                allData.setPk_item_menu(res.getInt("pk_item_menu"));
                allData.setFk_item_parent(res.getInt("fk_item_parent"));
                allData.setFl_icon(res.getString("fl_icon"));
                allData.setFl_text(res.getString("fl_text"));
                allData.setFl_expanded(res.getString("fl_expanded"));
                allData.setFl_section(res.getInt("fl_section"));
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
    public ArrayList<menuModel>  groupItemsMenu(int pk_user){
        ArrayList<menuModel> list=new ArrayList<>();
        String procedure="CALL `pto_get_items_menu`('groupBySection', ?, null)";
        try {
            Connection conn; 
            PreparedStatement ps; 
            ResultSet res;
            conn = new connectionControl().getConnection();            
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, pk_user);
            res = ps.executeQuery();
            while(res!=null&&res.next()){
                menuModel allData=new menuModel();
                allData.setFl_section(res.getInt("fl_section"));
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
