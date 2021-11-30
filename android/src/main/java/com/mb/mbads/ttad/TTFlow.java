package com.mb.mbads.ttad;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdDislike;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTNativeExpressAd;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.enums.AdMethod;
import java.util.List;
import io.flutter.plugin.common.MethodChannel;
import com.mb.mbads.model.AdItem;

public class TTFlow {

    private TTAdNative mTTAdNative;
    private TTNativeExpressAd ttNativeExpressAd;


    public TTFlow(Activity activity, AdItem adItem, float width, float height, String userId, MbListener mbListener, MethodChannel methodChannel){

        mTTAdNative = TTAdSdk.getAdManager().createAdNative(activity);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(adItem.getCodeNo()) //广告位id
                .setSupportDeepLink(true)
                .setAdCount(1) //请求广告数量为1到3条
                .setUserID(userId)
                .setExpressViewAcceptedSize(width, height)
                //.setDownloadType(adModel.getDownType())
                .build();
        mTTAdNative.loadNativeExpressAd(adSlot, new TTAdNative.NativeExpressAdListener() {
            @Override
            public void onError(int i, String s) {
                mbListener.onError(String.valueOf(i),s);
            }

            @Override
            public void onNativeExpressAdLoad(List<TTNativeExpressAd> list) {
                if (list.isEmpty()){
                    mbListener.onError(String.valueOf(0),"穿山甲信息无数据");
                    return;
                }
                System.out.println("广告加载成功");
                ttNativeExpressAd = list.get(0);
                bindAdListener(activity,ttNativeExpressAd,mbListener,methodChannel);
                ttNativeExpressAd.render();

            }
        });
    }

    /*
     * 绑定穿山甲
     * */
    private void bindAdListener(Activity activity,TTNativeExpressAd ttNativeExpressAd,MbListener mbListener,MethodChannel methodChannel) {

        ttNativeExpressAd.setExpressInteractionListener(new TTNativeExpressAd.ExpressAdInteractionListener() {
            @Override
            public void onAdClicked(View view, int i) {
                methodChannel.invokeMethod(AdMethod.onClick.getMethod(),"");
            }

            @Override
            public void onAdShow(View view, int i) {
                methodChannel.invokeMethod(AdMethod.onShow.getMethod(),"");
            }

            @Override
            public void onRenderFail(View view, String s, int i) {
                mbListener.onError(String.valueOf(i),s);
            }

            @Override
            public void onRenderSuccess(View view, float v, float v1) {
                mbListener.onAdLoad(view,v1);
            }
        });

        ttNativeExpressAd.setDislikeCallback(activity, new TTAdDislike.DislikeInteractionCallback() {
            @Override
            public void onShow() {
            }

            @Override
            public void onSelected(int i, String s, boolean b) {
                mbListener.onClose();
                methodChannel.invokeMethod(AdMethod.onDisLike.getMethod(),"");
            }

            @Override
            public void onCancel() {

            }

        });
    }




    public void isDestroy(){
        if( ttNativeExpressAd != null){
            ttNativeExpressAd.destroy();
            ttNativeExpressAd = null;
        }
    }


}
