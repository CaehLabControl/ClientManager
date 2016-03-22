package model;

/**
 *
 * @author CARLOS ANTONIO
 */
public class menuModel {
    int pk_item_menu=0;
    String fl_icon="";
    int fk_item_parent=0;
    String fl_text="";
    String fl_expanded="";
    int fl_section=0;
    public int getPk_item_menu() {
        return pk_item_menu;
    }

    public void setPk_item_menu(int pk_item_menu) {
        this.pk_item_menu = pk_item_menu;
    }

    public String getFl_icon() {
        return fl_icon;
    }

    public void setFl_icon(String fl_icon) {
        this.fl_icon = fl_icon;
    }

    public int getFk_item_parent() {
        return fk_item_parent;
    }

    public void setFk_item_parent(int fk_item_parent) {
        this.fk_item_parent = fk_item_parent;
    }

    public String getFl_text() {
        return fl_text;
    }

    public void setFl_text(String fl_text) {
        this.fl_text = fl_text;
    }

    public String getFl_expanded() {
        return fl_expanded;
    }

    public void setFl_expanded(String fl_expanded) {
        this.fl_expanded = fl_expanded;
    }

    public int getFl_section() {
        return fl_section;
    }

    public void setFl_section(int fl_section) {
        this.fl_section = fl_section;
    }
}
