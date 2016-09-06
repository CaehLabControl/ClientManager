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
public class ComputersModel {
    private Integer pk_computer = null;
    private  String fl_name = null;
    private LaboratoriesModel ml_laboratory = null;

    public ComputersModel() {
        
    }
    
    public Integer getPk_computer() {
        return pk_computer;
    }

    public void setPk_computer(Integer pk_computer) {
        this.pk_computer = pk_computer;
    }

    public String getFl_name() {
        return fl_name;
    }

    public void setFl_name(String fl_name) {
        this.fl_name = fl_name;
    }

    public LaboratoriesModel getMl_laboratory() {
        return ml_laboratory;
    }

    public void setMl_laboratory(LaboratoriesModel ml_laboratory) {
        this.ml_laboratory = ml_laboratory;
    }

    @Override
    public String toString() {
        return "ComputersModel{" + "pk_computer=" + pk_computer + ", fl_name=" + fl_name + ", ml_laboratory=" + ml_laboratory + '}';
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.pk_computer);
        hash = 53 * hash + Objects.hashCode(this.fl_name);
        hash = 53 * hash + Objects.hashCode(this.ml_laboratory);
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
        final ComputersModel other = (ComputersModel) obj;
        if (!Objects.equals(this.fl_name, other.fl_name)) {
            return false;
        }
        if (!Objects.equals(this.pk_computer, other.pk_computer)) {
            return false;
        }
        if (!Objects.equals(this.ml_laboratory, other.ml_laboratory)) {
            return false;
        }
        return true;
    }
    
}
