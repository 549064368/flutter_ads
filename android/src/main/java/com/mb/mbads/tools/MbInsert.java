package com.mb.mbads.tools;

import android.app.Activity;
import android.content.Context;

import com.mb.mbads.MbadsPlugin;
import com.mb.mbads.enums.AdEnum;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;
import com.mb.mbads.ttad.TTInsert;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MbInsert {

    private List<AdItem> adItems;
    private int index = 0;
    private AdItem adItem;
    private Context context;
    private String classify;
    private TTInsert ttInsert;
    private String errorMsg;
    private Map<String,Object> maps = new HashMap<>();
    private int orientation;

    public MbInsert(Context context, List<AdItem> adItems, String classify,int orientation){
        this.context = context;
        this.adItems = adItems;
        this.classify = classify;
        this.orientation = orientation;
        loadTable();
    }

    /*
     *  加载激励视频
     * */
    private void loadTable(){
        if(adItems.size() <= index){
            maps.put("adType","insertAd");
            maps.put("onAdMethod","onError");
            maps.put("classify",classify);
            maps.put("errorMsg",errorMsg);
            MbadsPlugin.mbEventPlugin.setContext(maps);
            return;
        }
        adItem = adItems.get(index);
        index++;
        if(adItem.getPlat() == AdEnum.Panglin.getPlat()){
            ttInsert = new TTInsert(context,adItem,classify,orientation,new MbListener(){
                @Override
                public void onError(String code, String msg) {
                    ttInsert = null;
                    errorMsg = "错误码:" + code + "错误信息:" + msg;
                    loadTable();
                }
            });

        }
    }


    /*
     * 显示激励视频
     * */
    public void showInspire(Activity activity){
        if( ttInsert != null){
            ttInsert.show(activity);
        }

    }

}
