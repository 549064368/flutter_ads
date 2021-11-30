package com.mb.mbads.enums;

public enum AdMethod {
    onLoad("onLoad","广告加载成功"),
    onClick("onClick","广告点击"),
    onShow("onShow","广告展示"),
    onSkip("onSkip","广告跳过"),
    onOver("onOver","广告倒计时结束"),
    onError("onError","广告失败"),
    onCache("onCache","广告缓冲结束"),
    onDisLike("onDisLike","不喜欢");

    private String method;
    private String title;

    AdMethod(String method, String title) {
        this.method = method;
        this.title = title;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
