/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.mysql.model;

import java.sql.Date;
import java.util.Objects;


/**
 *
 * @author Carlos
 */
public class UsersModel{
    private Integer pk_user = null;
    private Date fl_date_created_acount = null;
    private String fl_user_name = null;
    private String fl_password = null;
    private String fl_mail = null;
    private String fl_mail_validated = null;
    private String fl_real_name = null;
    private String fl_patern_name = null;
    private String fl_matern_name = null;
    private int fl_status_acount = 0;
    private String fl_key_request_new_password = null;
    private int fl_password_changed_count = 0;

    public UsersModel() {
        
    }
    
    public Integer getPk_user() {
        return pk_user;
    }

    public void setPk_user(Integer pk_user) {
        this.pk_user = pk_user;
    }

    public Date getFl_date_created_acount() {
        return fl_date_created_acount;
    }

    public void setFl_date_created_acount(Date fl_date_created_acount) {
        this.fl_date_created_acount = fl_date_created_acount;
    }

    public String getFl_user_name() {
        return fl_user_name;
    }

    public void setFl_user_name(String fl_user_name) {
        this.fl_user_name = fl_user_name;
    }

    public String getFl_password() {
        return fl_password;
    }

    public void setFl_password(String fl_password) {
        this.fl_password = fl_password;
    }

    public String getFl_mail() {
        return fl_mail;
    }

    public void setFl_mail(String fl_mail) {
        this.fl_mail = fl_mail;
    }

    public String getFl_mail_validated() {
        return fl_mail_validated;
    }

    public void setFl_mail_validated(String fl_mail_validated) {
        this.fl_mail_validated = fl_mail_validated;
    }

    public String getFl_real_name() {
        return fl_real_name;
    }

    public void setFl_real_name(String fl_real_name) {
        this.fl_real_name = fl_real_name;
    }

    public String getFl_patern_name() {
        return fl_patern_name;
    }

    public void setFl_patern_name(String fl_patern_name) {
        this.fl_patern_name = fl_patern_name;
    }

    public String getFl_matern_name() {
        return fl_matern_name;
    }

    public void setFl_matern_name(String fl_matern_name) {
        this.fl_matern_name = fl_matern_name;
    }

    public int getFl_status_acount() {
        return fl_status_acount;
    }

    public void setFl_status_acount(int fl_status_acount) {
        this.fl_status_acount = fl_status_acount;
    }

    public String getFl_key_request_new_password() {
        return fl_key_request_new_password;
    }

    public void setFl_key_request_new_password(String fl_key_request_new_password) {
        this.fl_key_request_new_password = fl_key_request_new_password;
    }

    public int getFl_password_changed_count() {
        return fl_password_changed_count;
    }

    public void setFl_password_changed_count(int fl_password_changed_count) {
        this.fl_password_changed_count = fl_password_changed_count;
    }

    @Override
    public String toString() {
        return "UsersModel{" + "pk_user=" + pk_user + ", fl_date_created_acount=" + fl_date_created_acount + ", fl_user_name=" + fl_user_name + ", fl_password=" + fl_password + ", fl_mail=" + fl_mail + ", fl_mail_validated=" + fl_mail_validated + ", fl_real_name=" + fl_real_name + ", fl_patern_name=" + fl_patern_name + ", fl_matern_name=" + fl_matern_name + ", fl_status_acount=" + fl_status_acount + ", fl_key_request_new_password=" + fl_key_request_new_password + ", fl_password_changed_count=" + fl_password_changed_count + '}';
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 71 * hash + Objects.hashCode(this.pk_user);
        hash = 71 * hash + Objects.hashCode(this.fl_date_created_acount);
        hash = 71 * hash + Objects.hashCode(this.fl_user_name);
        hash = 71 * hash + Objects.hashCode(this.fl_password);
        hash = 71 * hash + Objects.hashCode(this.fl_mail);
        hash = 71 * hash + Objects.hashCode(this.fl_mail_validated);
        hash = 71 * hash + Objects.hashCode(this.fl_real_name);
        hash = 71 * hash + Objects.hashCode(this.fl_patern_name);
        hash = 71 * hash + Objects.hashCode(this.fl_matern_name);
        hash = 71 * hash + this.fl_status_acount;
        hash = 71 * hash + Objects.hashCode(this.fl_key_request_new_password);
        hash = 71 * hash + this.fl_password_changed_count;
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final UsersModel other = (UsersModel) obj;
        if (this.fl_status_acount != other.fl_status_acount) {
            return false;
        }
        if (this.fl_password_changed_count != other.fl_password_changed_count) {
            return false;
        }
        if (!Objects.equals(this.fl_user_name, other.fl_user_name)) {
            return false;
        }
        if (!Objects.equals(this.fl_password, other.fl_password)) {
            return false;
        }
        if (!Objects.equals(this.fl_mail, other.fl_mail)) {
            return false;
        }
        if (!Objects.equals(this.fl_mail_validated, other.fl_mail_validated)) {
            return false;
        }
        if (!Objects.equals(this.fl_real_name, other.fl_real_name)) {
            return false;
        }
        if (!Objects.equals(this.fl_patern_name, other.fl_patern_name)) {
            return false;
        }
        if (!Objects.equals(this.fl_matern_name, other.fl_matern_name)) {
            return false;
        }
        if (!Objects.equals(this.fl_key_request_new_password, other.fl_key_request_new_password)) {
            return false;
        }
        if (!Objects.equals(this.pk_user, other.pk_user)) {
            return false;
        }
        if (!Objects.equals(this.fl_date_created_acount, other.fl_date_created_acount)) {
            return false;
        }
        return true;
    }
    
}
