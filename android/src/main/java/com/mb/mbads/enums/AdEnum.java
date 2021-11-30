package com.mb.mbads.enums;

public enum AdEnum {
    Panglin(1,"穿山甲");

    private int plat;
    private String remark;
    

    AdEnum(int plat, String remark) {
        this.plat = plat;
        this.remark = remark;
    }

    public int getPlat() {
        return plat;
    }

    public void setPlat(int plat) {
        this.plat = plat;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }
}
