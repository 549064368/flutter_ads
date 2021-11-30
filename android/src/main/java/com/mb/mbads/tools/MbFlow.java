package com.mb.mbads.tools;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import com.mb.mbads.MbViewConfig;
import com.mb.mbads.enums.AdEnum;
import com.mb.mbads.enums.AdMethod;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;
import com.mb.mbads.ttad.TTFlow;
import com.mb.mbads.ttad.TTSplash;
import java.util.List;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class MbFlow implements PlatformView {

    private List<AdItem> adItems;
    private Activity activity;
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
    public MbFlow(Context context,Activity activity, List<AdItem> adItems, float width, float height, String userId, BinaryMessenger binaryMessenger, int viewId){
        this.activity = activity;
        this.adItems = adItems;
        this.binaryMessenger = binaryMessenger;
        this.viewId = viewId;
        this.width = width;
        this.height = height;
        this.userId = userId;
        frameLayout = new FrameLayout(context);
        methodChannel = new MethodChannel(binaryMessenger, MbViewConfig.flowAdView + "_" + viewId);
        loadSplash();
    }
    

    @Override
    public View getView() {

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
            new TTFlow(activity, adItem,width,height,userId, new MbListener() {

                @Override
                public void onAdLoad(View view, float height) {
                    methodChannel.invokeMethod(AdMethod.onLoad.getMethod(),height);
                    frameLayout.addView(view);
                }

                @Override
                public void onClose() {
                    frameLayout.removeAllViews();
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
