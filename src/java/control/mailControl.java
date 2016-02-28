/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import model.userModel;

/**
 *
 * @author CARLOS ANTONIO
 */
public class mailControl {
    public static void main(String[] args) {
        
    }
    public String sendMailActiveAcount(userModel dataUser){
        String result;
        String email = dataUser.getFl_mail();
        String userName = dataUser.getFl_user_name();
        String password = dataUser.getFl_password();
        authControl auth =new authControl("sizlab.team@gmail.com", "sizlab2016");
        //Inicializamos las propiedades del envio del mail
        Properties prop=new Properties();
        prop.put("mail.transport.protocol", "smtp");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465"); 
        prop.put("mail.smtp.user", auth.userName);
        prop.put("mail.smtp.password", auth.password);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.starttls.enable", "true"); 
        //Inicializamos la clase de autentificacion
        //Creamos sesion
        Session session = Session.getInstance(prop, auth);
        String contentMail="";
        Message msg=new MimeMessage(session);
        String liga;
        String userNameSecurity = "userName";
        String emailSecuruty = "mail";
        String passwordSecuruty = "password";

        aes sec = new aes();
        sec.addKey("2015");
        try {
            liga = userNameSecurity+"="+userName+"&&"+emailSecuruty+"="+email+"&&"+passwordSecuruty+"="+password;
            InternetAddress[] emails = new InternetAddress[1];
            emails[0] = new InternetAddress(email);
            msg.setRecipients(Message.RecipientType.TO, emails);
            InternetAddress from=new InternetAddress(auth.userName);
            msg.setFrom(from);
            msg.setSubject("Sizlab Activación de cuenta");
            MimeBodyPart cuerpo=new MimeBodyPart();
            contentMail=contentMail+"<span style='float: left; padding-left: 15px; font-size: 70px; color: rgb(0, 74, 115); text-decoration: underline overline; margin-top: 5px'>Sizlab</span><br>";
            contentMail=contentMail+"<b><span style='font-style: italic;'>Sizlab te da la bienvenida por favor sigue las instrucciones de activación de tu cuenta</span></b><br><br>";
            contentMail=contentMail+"<b>Usuario</b>: <b>"+userName+"<br>";
            contentMail=contentMail+"<b>Contraseña</b>: <b>"+password+"<br><br>";
            contentMail=contentMail+"<b>Para iniciar sesión por primera ves en el <a href='http://192.168.1.73/ClientManager/acount-active.jsp?ac="+sec.encriptar(liga)+"'>Sistema click aquí.</a></b><br><br>";
            contentMail=contentMail+"<span><b>El mensaje se envió a </b><span>"+email+"</span></span><br><br><br>";
            contentMail=contentMail+"<b>Nota: </b><b><span style='font-style: italic; color:red;'>En caso de no ser el responsable de este correo favor de eliminarlo y pasar por alto el contenido...!</span><br><br><br><br>";
            contentMail=contentMail+"<b>Plaza Jorge Figueroa Sin Número, Palacio Municipal, Colonia Centro, C. P. 51860  Almoloya de Alquisiras Tel: 722-412-2746 </b>";
            cuerpo.setContent(contentMail, "text/html");
            Multipart mp=new MimeMultipart();
            mp.addBodyPart(cuerpo);
            msg.setContent(mp);
            //Instrucciones para enviar email
            Transport t = session.getTransport();
            t.connect("smtp.gmail.com",auth.userName, auth.password);
            msg.saveChanges();
            t.sendMessage(msg, msg.getAllRecipients());
            t.close();
            result="Success";
        } catch (AddressException e) {
            //e.printStackTrace();
            result = "InvalidMail";
        } catch( MessagingException e){
            //e.printStackTrace();
            result = "FailConnectionNetwork";
        }
        return result;
    }
    public String sendMailResetPassword(userModel dataUser){
        String result;
        String email = dataUser.getFl_mail();
        String userName = dataUser.getFl_user_name();
        int countChangePassword = dataUser.getFl_password_changed_count();
        authControl auth =new authControl("sizlab.team@gmail.com", "sizlab2016");
        //Inicializamos las propiedades del envio del mail
        Properties prop=new Properties();
        prop.put("mail.transport.protocol", "smtp");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465"); 
        prop.put("mail.smtp.user", auth.userName);
        prop.put("mail.smtp.password", auth.password);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.starttls.enable", "true"); 
        //Inicializamos la clase de autentificacion
        //Creamos sesion
        Session session = Session.getInstance(prop, auth);
        String contentMail="";
        Message msg=new MimeMessage(session);
        String liga;
        String userNameSecurity = "userName";
        String emailSecuruty = "mail";
        String countChangePassordSecuruty = "count";
        
        aes sec = new aes();
        sec.addKey("2015");
        try {
            liga = userNameSecurity+"="+userName+"&&"+emailSecuruty+"="+email+"&&"+countChangePassordSecuruty+"="+countChangePassword;
            InternetAddress[] emails = new InternetAddress[1];
            emails[0] = new InternetAddress(email);
            msg.setRecipients(Message.RecipientType.TO, emails);
            InternetAddress from=new InternetAddress(auth.userName);
            msg.setFrom(from);
            msg.setSubject("Solicitud de restauración de contraseña");
            MimeBodyPart cuerpo=new MimeBodyPart();
            contentMail=contentMail+"<span style='float: left; padding-left: 15px; font-size: 70px; color: rgb(0, 74, 115); text-decoration: underline overline; margin-top: 5px'>Sizlab</span><br>";
            contentMail=contentMail+"<b><span style='font-style: italic;'>Con Sizlab restaurar tu contraseña es muy facil, solo tienes que seguir los siguientes pasos...</span></b><br><br>";

            contentMail=contentMail+"<b>Para restaurar una nueva contraseña <a href='http://192.168.1.73/ClientManager/reset-password.jsp?rp="+sec.encriptar(liga)+"'> click aquí.</a></b><br><br>";
            contentMail=contentMail+"<span><b>El mensaje se envió a </b><span>"+email+"</span></span><br><br><br>";
            contentMail=contentMail+"<b>Nota: </b><b><span style='font-style: italic; color:red;'>En caso de no ser el responsable de este correo favor de eliminarlo y pasar por alto el contenido...!</span><br><br><br><br>";
            contentMail=contentMail+"<b>Plaza Jorge Figueroa Sin Número, Palacio Municipal, Colonia Centro, C. P. 51860  Almoloya de Alquisiras Tel: 722-412-2746 </b>";
            cuerpo.setContent(contentMail, "text/html");
            Multipart mp=new MimeMultipart();
            mp.addBodyPart(cuerpo);
            msg.setContent(mp);
            //Instrucciones para enviar email
            Transport t = session.getTransport();
            t.connect("smtp.gmail.com",auth.userName, auth.password);
            msg.saveChanges();
            t.sendMessage(msg, msg.getAllRecipients());
            t.close();
            result="Success";
            new userControl().resetKeyPasswordUser(userName);
            new userControl().resetPasswordUser(userName);
        } catch (AddressException e) {
            //e.printStackTrace();
            result = "InvalidMail";
        } catch( MessagingException e){
            //e.printStackTrace();
            result = "FailConnectionNetwork";
        }
        return result;
    }
}
