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
import mx.app.src.dao.extend.aes;
import mx.app.src.dao.extend.mail;
import mx.app.src.mysql.control.UsersControl;
import mx.app.src.mysql.model.UsersModel;
import org.json.simple.JSONObject;

/**
 *
 * @author CARLOS ANTONIO
 */
@WebServlet(name = "UsersService", urlPatterns = {"/UsersService"})
public class UsersService extends HttpServlet {

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
                if(request.getParameter("login")!=null){
                    JSONObject data = new JSONObject();
                    HttpSession session = request.getSession();
                    if(request.getParameter("login").equals("in")){                    
                        UsersModel obj = new UsersModel();
                        obj.setFl_user_name(request.getParameter("user_name"));
                        obj.setFl_password(request.getParameter("user_password"));
                        ArrayList<UsersModel> list=new UsersControl().userLogin(obj);
                        if(list.size()>0){
                            for (UsersModel list1 : list) {
                                data.put("fl_user_name", list1.getFl_user_name());
                                data.put("fl_mail", list1.getFl_mail());
                                data.put("fl_status_acount", list1.getFl_status_acount());
                                data.put("status", "exist");
                                if (list1.getFl_status_acount()==1) {
                                    session.setAttribute("pk_user", list1.getPk_user());
                                    session.setAttribute("fl_user_name", list1.getFl_user_name());
                                    session.setAttribute("fl_mail", list1.getFl_mail());
                                }else{
                                    aes sec = new aes();
                                    sec.addKey("2015");
                                    String liga = "userName"+"="+request.getParameter("user_name");
                                    data.put("link", "ac="+sec.encriptar(liga));
                                    session.invalidate();
                                }
                            }
                        }else{
                            data.put("status", "notExist");
                        }                
                        out.print(data);  
                    }else{
                        data.put("status", "true");
                        session.invalidate();
                        out.print(data);
                    }                            
                }
                if(request.getParameter("mailOrUserName")!=null){
                    JSONObject data = new JSONObject();
                    if(request.getParameter("pt_user")!=null){
                        data.put("status", new UsersControl().mailOrUserNameValidate(request.getParameter("pt_user")));
                        out.print(data);
                    }                
                }
                if(request.getParameter("mailValidate")!=null){
                    JSONObject data = new JSONObject();
                    if(request.getParameter("pt_mail")!=null){
                        data.put("status", new UsersControl().mailValidate(request.getParameter("pt_mail")));
                        out.print(data);
                    }                
                }
                if(request.getParameter("userValidate")!=null){
                    JSONObject data = new JSONObject();
                    if(request.getParameter("pt_user")!=null){
                        data.put("status", new UsersControl().userValidate(request.getParameter("pt_user")));
                        out.print(data);
                    }                
                }
                if(request.getParameter("action")!=null && request.getParameter("action").equals("insert")){
                    JSONObject data = new JSONObject();
                    UsersModel obj = new UsersModel();
                    obj.setFl_user_name(request.getParameter("user_name"));
                    obj.setFl_mail(request.getParameter("user_mail"));
                    obj.setFl_password(request.getParameter("user_password"));
                    data.put("status", new UsersControl().Insert(obj));
                    data.put("sendMailStatus", new mail().sendMailActiveAcount(obj));
                    aes sec = new aes();
                    sec.addKey("2015");
                    String liga = "userName"+"="+request.getParameter("user_name");
                    data.put("link", "ac="+sec.encriptar(liga));
                    out.print(data);
                }
                if(request.getParameter("action")!=null && request.getParameter("action").equals("requestPassword")){
                    JSONObject data = new JSONObject();
                    UsersModel obj = new UsersModel();                
                    ArrayList<UsersModel> list=new UsersControl().selectUser(request.getParameter("user_name"));
                    for (UsersModel list1 : list) {
                        obj.setFl_user_name(list1.getFl_user_name());
                        obj.setFl_mail(list1.getFl_mail());
                        obj.setFl_password_changed_count((list1.getFl_password_changed_count()+1));
                    }
                    data.put("sendMailStatus", new mail().sendMailResetPassword(obj));
                    out.print(data);
                }
                if(request.getParameter("action")!=null && request.getParameter("action").equals("changePassword")){
                    JSONObject data = new JSONObject();
                    data.put("status", new UsersControl().changePasswordUser(request.getParameter("user_name"), request.getParameter("new_password")));
                    out.print(data);
                }
            }catch (DAOException ex) {
                out.print("Error DAOException: "+ ex);
            } catch (SQLException ex) {
                out.print("Error SQLException: "+ex);
            }catch (ClassNotFoundException ex) {
                Logger.getLogger(UsersService.class.getName()).log(Level.SEVERE, null, ex);
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
