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
import mx.app.src.mysql.control.LaboratoriesControl;
import mx.app.src.mysql.model.LaboratoriesModel;
import mx.app.src.mysql.model.UsersModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS ANTONIO
 */
@WebServlet(name = "LaboratoriesService", urlPatterns = {"/LaboratoriesService"})
public class LaboratoriesService extends HttpServlet {

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
                if(request.getParameter("selectLaboratoriesByUser")!=null){
                    JSONArray principal = new JSONArray();
                    JSONObject settings = new JSONObject();
                    HttpSession session = request.getSession();  
                    String pk_user = "";
                    String pt_order = request.getParameter("pt_order");
                    String pt_type = request.getParameter("pt_type");
                    if(session.getAttribute("pk_user")!=null){
                        pk_user=session.getAttribute("pk_user").toString();
                    }
                    ArrayList<LaboratoriesModel> list=new LaboratoriesControl().selectLaboratories(pk_user, pt_order, pt_type);
                    if(list.size()>0){
                        for (LaboratoriesModel list1 : list) {
                            JSONObject data = new JSONObject();
                            data.put("pk_laboratory", list1.getPk_laboratory());
                            data.put("pk_user", list1.getMl_user().getPk_user());
                            data.put("fl_name", list1.getFl_name());
                            data.put("fl_description", list1.getFl_description());
                            data.put("fl_cant_computers", list1.getFl_cant_computers());
                            data.put("fl_row_create_date", list1.getFl_row_create_date());
                            data.put("fl_row_update_date", list1.getFl_row_update_date());
                            principal.add(data);
                        }
                        settings.put("response", principal);
                    }else{
                        settings.put("response", principal);
                    }                
                    response.setContentType("application/json");                 
                    out.print(settings);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("addLaboratory")!=null){
                    JSONObject settings = new JSONObject();
                    HttpSession session = request.getSession();  
                    int pk_user;
                    if(session.getAttribute("pk_user")!=null){
                        pk_user = Integer.parseInt(session.getAttribute("pk_user").toString());
                        UsersModel uM = new UsersModel();
                        LaboratoriesModel obj = new LaboratoriesModel();                    
                        obj.setFl_name(request.getParameter("fl_name"));
                        obj.setFl_description(request.getParameter("fl_description"));
                        uM.setPk_user(pk_user);
                        obj.setMl_user(uM);
                        if(new LaboratoriesControl().Insert(obj).equals("Inserted")){
                            settings.put("response", "true");
                        }else{
                            settings.put("response", "false");
                        }          
                    }else{
                        settings.put("response", "sessionExpired");
                    }
                    response.setContentType("application/json");                 
                    out.print(settings);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("updateLaboratory")!=null){
                    JSONObject settings = new JSONObject();
                    HttpSession session = request.getSession();  
                    if(session.getAttribute("pk_user")!=null){
                        UsersModel uM = new UsersModel();
                        LaboratoriesModel obj = new LaboratoriesModel();
                        obj.setFl_name(request.getParameter("fl_name"));
                        obj.setFl_description(request.getParameter("fl_description"));
                        obj.setPk_laboratory(Integer.parseInt(request.getParameter("pk_laboratory")));
                        if(new LaboratoriesControl().Update(obj).equals("Updated")){
                            settings.put("response", "true");
                        }else{
                            settings.put("response", "false");
                        }                

                    }else{
                        settings.put("response", "sessionExpired");
                    }
                    response.setContentType("application/json");                 
                    out.print(settings);
                    out.flush(); 
                    out.close();
                }
                if(request.getParameter("deleteLaboratory")!=null){
                    JSONObject settings = new JSONObject();  
                    Integer pk_laboratory = Integer.parseInt(request.getParameter("pk_laboratory"));
                    if(new LaboratoriesControl().Delete(pk_laboratory).equals("Deleted")){
                        settings.put("response", "true");
                    }else{
                        settings.put("response", "false");
                    } 
                    response.setContentType("application/json");                 
                    out.print(settings);
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
        //processRequest(request, response);
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
