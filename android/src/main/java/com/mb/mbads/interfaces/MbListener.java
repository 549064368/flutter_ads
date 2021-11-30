package com.mb.mbads.interfaces;

import android.view.View;

/**
 * @author: 吴奶强
 * @date: 2020-07-14
 * @description: 适配器点击监听
 */
public interface MbListener {

    default void onAdLoad(View view){}
    default void onAdLoad(View view,float height){}
    default void onClose(){}
    default void initSuccess(){}
    void onError(String code,String msg);

}
