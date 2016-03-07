/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package services;

import control.laboratoryControl;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.laboratoryModel;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS ANTONIO
 */
@WebServlet(name = "laboratoriesServices", urlPatterns = {"/laboratoriesServices"})
public class laboratoriesServices extends HttpServlet {

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
                ArrayList<laboratoryModel> list=new laboratoryControl().selectLaboratories(pk_user, pt_order, pt_type);
                if(list.size()>0){
                    for (laboratoryModel list1 : list) {
                        JSONObject data = new JSONObject();
                        data.put("pk_laboratory", list1.getPk_laboratory());
                        data.put("pk_user", list1.getPk_user());
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
                    laboratoryModel obj = new laboratoryModel();
                    obj.setFl_name(request.getParameter("fl_name"));
                    obj.setFl_description(request.getParameter("fl_description"));
                    obj.setPk_user(pk_user);
                    if(new laboratoryControl().addLaboratory(obj)){
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
                laboratoryModel obj = new laboratoryModel();
                obj.setPk_laboratory(Integer.parseInt(request.getParameter("pk_laboratory")));
                if(new laboratoryControl().deleteLaboratory(obj)){
                    settings.put("response", "true");
                }else{
                    settings.put("response", "false");
                } 
                response.setContentType("application/json");                 
                out.print(settings);
                out.flush(); 
                out.close();
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
