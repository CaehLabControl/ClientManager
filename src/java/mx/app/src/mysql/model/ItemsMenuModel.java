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
public class ItemsMenuModel{
    private Integer pk_item_menu = null;
    private String fl_icon = null;
    private Integer fk_item_parent= null;
    private String fl_text = null ;
    private String fl_expanded = null;
    private int fl_section = 0;

    public ItemsMenuModel() {
        
    }

    public Integer getPk_item_menu() {
        return pk_item_menu;
    }

    public void setPk_item_menu(Integer pk_item_menu) {
        this.pk_item_menu = pk_item_menu;
    }

    public String getFl_icon() {
        return fl_icon;
    }

    public void setFl_icon(String fl_icon) {
        this.fl_icon = fl_icon;
    }

    public Integer getFk_item_parent() {
        return fk_item_parent;
    }

    public void setFk_item_parent(Integer fk_item_parent) {
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

    @Override
    public String toString() {
        return "ItemsMenuModel{" + "pk_item_menu=" + pk_item_menu + ", fl_icon=" + fl_icon + ", fk_item_parent=" + fk_item_parent + ", fl_text=" + fl_text + ", fl_expanded=" + fl_expanded + ", fl_section=" + fl_section + '}';
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 61 * hash + Objects.hashCode(this.pk_item_menu);
        hash = 61 * hash + Objects.hashCode(this.fl_icon);
        hash = 61 * hash + Objects.hashCode(this.fk_item_parent);
        hash = 61 * hash + Objects.hashCode(this.fl_text);
        hash = 61 * hash + Objects.hashCode(this.fl_expanded);
        hash = 61 * hash + this.fl_section;
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
        final ItemsMenuModel other = (ItemsMenuModel) obj;
        if (this.fl_section != other.fl_section) {
            return false;
        }
        if (!Objects.equals(this.fl_icon, other.fl_icon)) {
            return false;
        }
        if (!Objects.equals(this.fl_text, other.fl_text)) {
            return false;
        }
        if (!Objects.equals(this.fl_expanded, other.fl_expanded)) {
            return false;
        }
        if (!Objects.equals(this.pk_item_menu, other.pk_item_menu)) {
            return false;
        }
        if (!Objects.equals(this.fk_item_parent, other.fk_item_parent)) {
            return false;
        }
        return true;
    }
    
}
