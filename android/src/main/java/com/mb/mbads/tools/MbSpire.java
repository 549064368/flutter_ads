package com.mb.mbads.tools;

import android.app.Activity;
import android.content.Context;

import com.mb.mbads.MbadsPlugin;
import com.mb.mbads.enums.AdEnum;
import com.mb.mbads.enums.AdMethod;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;
import com.mb.mbads.ttad.TTSpire;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MbSpire {

    private List<AdItem> adItems;
    private int index = 0;
    private AdItem adItem;
    private Context context;
    private String classify;
    private TTSpire ttSpire;
    private String errorMsg;
    private Map<String,Object> maps = new HashMap<>();

    public MbSpire(Context context,List<AdItem> adItems,String classify){
        this.context = context;
        this.adItems = adItems;
        this.classify = classify;
        loadInspire();
    }

    /*
    *  加载激励视频
    * */
    private void loadInspire(){
        if(adItems.size() <= index){
            maps.put("adType","inspireAd");
            maps.put("onAdMethod","onError");
            maps.put("classify",classify);
            maps.put("errorMsg",errorMsg);
            MbadsPlugin.mbEventPlugin.setContext(maps);
            return;
        }
        adItem = adItems.get(index);
        index++;
        if(adItem.getPlat() == AdEnum.Panglin.getPlat()){
            ttSpire = new TTSpire(context,adItem,classify,new MbListener(){
                @Override
                public void onError(String code, String msg) {
                    ttSpire = null;
                    errorMsg = "错误码:" + code + "错误信息:" + msg;
                    loadInspire();
                }
            });

        }
    }


    /*
    * 显示激励视频
    * */
    public void showInspire(Activity activity){
        if(ttSpire != null){
            ttSpire.show(activity);
        }

    }

}
