/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mx.app.src.mysql.model;
import java.util.Objects;

/**
 *
 * @author Carlos
 */
public class LaboratoriesModel{
    private Integer pk_laboratory = null;
    private String fl_name = null;
    private String fl_description = null;
    private int fl_cant_computers = 0;
    private String fl_row_create_date = null;
    private String fl_row_update_date = null;
    private UsersModel ml_user= null;

    public LaboratoriesModel() {
        
    }

    public Integer getPk_laboratory() {
        return pk_laboratory;
    }

    public void setPk_laboratory(Integer pk_laboratory) {
        this.pk_laboratory = pk_laboratory;
    }

    public String getFl_name() {
        return fl_name;
    }

    public void setFl_name(String fl_name) {
        this.fl_name = fl_name;
    }

    public String getFl_description() {
        return fl_description;
    }

    public void setFl_description(String fl_description) {
        this.fl_description = fl_description;
    }

    public int getFl_cant_computers() {
        return fl_cant_computers;
    }

    public void setFl_cant_computers(int fl_cant_computers) {
        this.fl_cant_computers = fl_cant_computers;
    }

    public String getFl_row_create_date() {
        return fl_row_create_date;
    }

    public void setFl_row_create_date(String fl_row_create_date) {
        this.fl_row_create_date = fl_row_create_date;
    }

    public String getFl_row_update_date() {
        return fl_row_update_date;
    }

    public void setFl_row_update_date(String fl_row_update_date) {
        this.fl_row_update_date = fl_row_update_date;
    }

    public UsersModel getMl_user() {
        return ml_user;
    }

    public void setMl_user(UsersModel ml_user) {
        this.ml_user = ml_user;
    }

    @Override
    public String toString() {
        return "LaboratoriesModel{" + "pk_laboratory=" + pk_laboratory + ", fl_name=" + fl_name + ", fl_description=" + fl_description + ", fl_cant_computers=" + fl_cant_computers + ", fl_row_create_date=" + fl_row_create_date + ", fl_row_update_date=" + fl_row_update_date + ", ml_user=" + ml_user + '}';
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + Objects.hashCode(this.pk_laboratory);
        hash = 89 * hash + Objects.hashCode(this.fl_name);
        hash = 89 * hash + Objects.hashCode(this.fl_description);
        hash = 89 * hash + this.fl_cant_computers;
        hash = 89 * hash + Objects.hashCode(this.fl_row_create_date);
        hash = 89 * hash + Objects.hashCode(this.fl_row_update_date);
        hash = 89 * hash + Objects.hashCode(this.ml_user);
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
        final LaboratoriesModel other = (LaboratoriesModel) obj;
        if (this.fl_cant_computers != other.fl_cant_computers) {
            return false;
        }
        if (!Objects.equals(this.pk_laboratory, other.pk_laboratory)) {
            return false;
        }
        if (!Objects.equals(this.fl_name, other.fl_name)) {
            return false;
        }
        if (!Objects.equals(this.fl_description, other.fl_description)) {
            return false;
        }
        if (!Objects.equals(this.fl_row_create_date, other.fl_row_create_date)) {
            return false;
        }
        if (!Objects.equals(this.fl_row_update_date, other.fl_row_update_date)) {
            return false;
        }
        if (!Objects.equals(this.ml_user, other.ml_user)) {
            return false;
        }
        return true;
    }
    
}
