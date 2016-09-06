/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mx.app.src.dao.extend.DAOException;
import mx.app.src.mysql.control.ItemsMenuControl;
import mx.app.src.mysql.model.ItemsMenuModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS ANTONIO
 */
@WebServlet(name = "ItemsMenuService", urlPatterns = {"/ItemsMenuService"})
public class ItemsMenuService extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                if(request.getParameter("view")!=null){
                    HttpSession session = request.getSession();  
                    int pk_user = 0;
                    if(session.getAttribute("pk_user")!=null){
                        pk_user=Integer.parseInt(session.getAttribute("pk_user").toString());
                    }
                    JSONObject settings2 = new JSONObject();
                    ArrayList<ItemsMenuModel> listGroup=new ItemsMenuControl().groupItemsMenu(pk_user);                               
                    if(listGroup.size()>0){                    
                        for (ItemsMenuModel list1 : listGroup) {                         
                            JSONArray principal2 = new JSONArray();
                            ArrayList<ItemsMenuModel> list=new ItemsMenuControl().selectItemsMenu(pk_user, list1.getFl_section());                         
                            for (ItemsMenuModel list2 : list) {
                                JSONObject data = new JSONObject();
                                data.put("id", list2.getPk_item_menu());
                                data.put("parentid", list2.getFk_item_parent());
                                data.put("text", "<span data-indextree='"+list1.getFl_section()+"'>"+list2.getFl_text()+"</span>");
                                data.put("icon", list2.getFl_icon());
                                data.put("expanded", list2.getFl_expanded());
                                principal2.add(data);
                            }
                            settings2.put(list1.getFl_section(),principal2);
                        }
                        settings2.put("length",listGroup.size());
                    }               
                    response.setContentType("application/json");                 
                    out.print(settings2);
                    out.flush(); 
                    out.close();
                }
            }catch (DAOException ex) {
                out.print("Error DAOException: "+ ex);
            } catch (SQLException ex) {
                out.print("Error SQLException: "+ex);
            }catch (ClassNotFoundException ex) {
                Logger.getLogger(ItemsMenuService.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        response.sendRedirect("");
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
