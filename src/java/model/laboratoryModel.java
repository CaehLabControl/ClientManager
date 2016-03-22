package model;

/**
 *
 * @author CARLOS ANTONIO
 */
public class laboratoryModel{
    private int pk_laboratory = 0;
    private String fl_name="";
    private String fl_description="";
    private String fl_cant_computers="";
    private String fl_row_create_date="";
    private String fl_row_update_date="";
    private userModel um;

    public laboratoryModel(userModel um) {
        this.um = um;
    }

    public int getPk_laboratory() {
        return pk_laboratory;
    }

    public void setPk_laboratory(int pk_laboratory) {
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

    public String getFl_cant_computers() {
        return fl_cant_computers;
    }

    public void setFl_cant_computers(String fl_cant_computers) {
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

    public userModel getUm() {
        return um;
    }

    public void setUm(userModel um) {
        this.um = um;
    }
    
}
