package com.mb.mbads.model;

import java.io.Serializable;

public class AdItem implements Serializable {
    private String codeNo;
    private int plat;

    public String getCodeNo() {
        return codeNo;
    }

    public void setCodeNo(String codeNo) {
        this.codeNo = codeNo;
    }

    public int getPlat() {
        return plat;
    }

    public void setPlat(int plat) {
        this.plat = plat;
    }
}
