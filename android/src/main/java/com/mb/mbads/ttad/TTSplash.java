package com.mb.mbads.ttad;

import android.content.Context;
import android.view.View;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTSplashAd;
import com.mb.mbads.enums.AdMethod;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;

import io.flutter.plugin.common.MethodChannel;

public class TTSplash {

    private TTAdNative mTTAdNative;
    private TTSplashAd ttSplashAd;
    private MethodChannel mMethodChannel;

    public TTSplash(Context context, AdItem adItem, float width, float height, String userId, MbListener mbSplashListener, MethodChannel methodChannel){
//        if( overTime == 0){
//            overTime = 4000;
//        }
        if( width == 0f){
            width = 1080;
        }
        if( height == 0f){
            height = 1920;
        }
        this.mMethodChannel = methodChannel;
        mTTAdNative = TTAdSdk.getAdManager().createAdNative(context);
        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(adItem.getCodeNo())
                //模板广告需要设置期望个性化模板广告的大小,单位dp,代码位是否属于个性化模板广告，请在穿山甲平台查看
                //view宽高等于图片的宽高
                .setExpressViewAcceptedSize(width, height)
                .setUserID(userId)
                //.setDownloadType(adModel.getDownType())
                .build();
        mTTAdNative.loadSplashAd(adSlot, new TTAdNative.SplashAdListener() {
            @Override
            public void onError(int i, String s) {
                mbSplashListener.onError(String.valueOf(i),s);
            }

            @Override
            public void onTimeout() {
                mbSplashListener.onError("-1","穿山甲开屏加载超时");
            }

            @Override
            public void onSplashAdLoad(TTSplashAd ad) {
                
                System.out.println("开屏成功");
                ttSplashAd = ad;
                mbSplashListener.onAdLoad(ttSplashAd.getSplashView());
                mMethodChannel.invokeMethod(AdMethod.onLoad.getMethod(),"");
                ttSplashAd.setSplashInteractionListener(new TTSplashAd.AdInteractionListener() {
                    @Override
                    public void onAdClicked(View view, int i) {
                        mMethodChannel.invokeMethod(AdMethod.onClick.getMethod(),"");
                    }

                    @Override
                    public void onAdShow(View view, int i) {
                        mMethodChannel.invokeMethod(AdMethod.onShow.getMethod(),"");
                    }

                    @Override
                    public void onAdSkip() {
                        mMethodChannel.invokeMethod(AdMethod.onSkip.getMethod(),"");
                    }

                    @Override
                    public void onAdTimeOver() {
                        mMethodChannel.invokeMethod(AdMethod.onOver.getMethod(),"");
                    }
                });
            }
        },4000);
    }
}
