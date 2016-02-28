/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author CARLOS ANTONIO
 */
public class userModel {
    int pk_user=0;
    String fl_date_created_acount="";
    String fl_user_name="";
    String fl_password="";
    String fl_mail="";
    String fl_mail_validated="";
    String fl_real_name="";
    String fl_patern_name="";
    String fl_matern_name="";
    String fl_status_acount="";
    String fl_key_request_new_password="";
    int fl_password_changed_count=0;

    public int getPk_user() {
        return pk_user;
    }

    public void setPk_user(int pk_user) {
        this.pk_user = pk_user;
    }

    public String getFl_date_created_acount() {
        return fl_date_created_acount;
    }

    public void setFl_date_created_acount(String fl_date_created_acount) {
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

    public String getFl_status_acount() {
        return fl_status_acount;
    }

    public void setFl_status_acount(String fl_status_acount) {
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
}
