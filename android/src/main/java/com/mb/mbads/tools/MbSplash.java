package com.mb.mbads.tools;

import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import com.mb.mbads.MbViewConfig;
import com.mb.mbads.enums.AdEnum;
import com.mb.mbads.enums.AdMethod;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;
import com.mb.mbads.ttad.TTSplash;
import java.util.List;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class MbSplash implements PlatformView {

    private List<AdItem> adItems;
    private Context context;
    private FrameLayout frameLayout;
    private int index = 0;
    private AdItem adItem;
    private String errorMsg;
    private BinaryMessenger binaryMessenger;
    private MethodChannel methodChannel;
    private int viewId;
    private float width;
    private float height;
    private String userId;
    public MbSplash(Context context,List<AdItem> adItems,float width,float height,String userId, BinaryMessenger binaryMessenger,int viewId){
        this.context = context;
        this.adItems = adItems;
        this.binaryMessenger = binaryMessenger;
        this.viewId = viewId;
        this.width = width;
        this.height = height;
        this.userId = userId;
        frameLayout = new FrameLayout(context);
        methodChannel = new MethodChannel(binaryMessenger, MbViewConfig.splashAdView + "_" + viewId);
        loadSplash();
    }
    

    @Override
    public View getView() {
        
        System.out.println("返回实体数量：" + adItems.size());

        return frameLayout;
    }

    @Override
    public void dispose() {

    }
    
    /*
    * 加载广告
    * */
    public void loadSplash(){
        if(adItems.size() <= index){
            methodChannel.invokeMethod(AdMethod.onError.getMethod(),errorMsg);
            return;
        }
        adItem = adItems.get(index);
        index++;
        if(adItem.getPlat() == AdEnum.Panglin.getPlat()){
            new TTSplash(this.context, adItem,width,height,userId, new MbListener() {
                @Override
                public void onAdLoad(View view) {
                    frameLayout.addView(view);
                }

                @Override
                public void onError(String code, String msg) {
                    errorMsg = "错误码:" + code + "错误信息:" + msg;
                    loadSplash();
                }
            },methodChannel);
        }
        
    }
    
    
    
    
    
}
