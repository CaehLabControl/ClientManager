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
import mx.app.src.dao.ItemsMenuDAO;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.dao.extend.MySQLUtil;
import mx.app.src.mysql.model.ItemsMenuModel;



/**
 *
 * @author Carlos
 */
public class ItemsMenuControl implements ItemsMenuDAO{
    private String procedure = null;
    private final Connection conn;
    public ItemsMenuControl() throws ClassNotFoundException {
        conn = new connectionControl().getConnection();
    }

    @Override
    public ArrayList<ItemsMenuModel> selectItemsMenu(int pk_user, int pt_section) throws DAOException, SQLException{
        ArrayList<ItemsMenuModel> list=new ArrayList<>();
        procedure="CALL `pto_get_items_menu`('allItemsMenu', ?, ?)";
        PreparedStatement ps = null; 
        ResultSet rs = null; 
        try {        
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, pk_user);
            ps.setInt(2, pt_section);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                ItemsMenuModel allData=new ItemsMenuModel();
                allData.setPk_item_menu(rs.getInt("pk_item_menu"));
                allData.setFk_item_parent(rs.getInt("fk_item_parent"));
                allData.setFl_icon(rs.getString("fl_icon"));
                allData.setFl_text(rs.getString("fl_text"));
                allData.setFl_expanded(rs.getString("fl_expanded"));
                allData.setFl_section(rs.getInt("fl_section"));
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
    public ArrayList<ItemsMenuModel> groupItemsMenu(int pk_user)throws DAOException, SQLException {
        ArrayList<ItemsMenuModel> list=new ArrayList<>();
        procedure="CALL `pto_get_items_menu`('groupBySection', ?, null)";
        PreparedStatement ps = null; 
        ResultSet rs = null;
        try {         
            ps = conn.prepareStatement(procedure); 
            ps.setInt(1, pk_user);
            rs = ps.executeQuery();
            while(rs!=null&&rs.next()){
                ItemsMenuModel allData=new ItemsMenuModel();
                allData.setFl_section(rs.getInt("fl_section"));
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
    public String Insert(ItemsMenuModel data) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String Update(ItemsMenuModel data) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String Delete(Integer key) throws DAOException, SQLException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    public static void main(String[] args) throws ClassNotFoundException, DAOException, SQLException {
        
        ItemsMenuDAO menuDao = new ItemsMenuControl();
        ArrayList<ItemsMenuModel> menu;
        menu = menuDao.selectItemsMenu(1, 3);
        System.out.print(menu);
        if(menu.size()>0){
            for (ItemsMenuModel list1 : menu) {
                System.out.println(list1.getPk_item_menu());
            }
        }
    }
}
