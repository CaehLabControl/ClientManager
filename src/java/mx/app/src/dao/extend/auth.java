/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.dao.extend;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 *
 * @author CARLOS
 */
public class auth extends Authenticator{
    public String userName=null;
    public String password=null;
    public auth(String userName, String password){
        this.userName=userName;
        this.password = password;
    }

    /**
     *
     * @return
     */
    @Override
    protected PasswordAuthentication getPasswordAuthentication(){
        return new PasswordAuthentication(userName, password);
    }
}
