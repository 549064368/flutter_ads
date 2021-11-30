package com.mb.mbads.ttad;

import android.app.Activity;
import android.content.Context;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTFullScreenVideoAd;
import com.mb.mbads.MbadsPlugin;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;

import java.util.HashMap;
import java.util.Map;

public class TTInsert {

    private TTAdNative mTTAdNative;
    private TTFullScreenVideoAd ttFullScreenVideoAd;
    private String mClassify;
    private Map<String,Object> maps = new HashMap<>();

    public TTInsert(Context context, AdItem adItem, String classify,int orientation, MbListener mbListener){
        mTTAdNative = TTAdSdk.getAdManager().createAdNative(context);

        this.mClassify = classify;
        maps.put("adType","insertAd");
        maps.put("classify",mClassify);

        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(adItem.getCodeNo())
                //模板广告需要设置期望个性化模板广告的大小,单位dp,激励视频场景，只要设置的值大于0即可
                .setExpressViewAcceptedSize(500,500)
                .setSupportDeepLink(true)
                //.setUserID(adItem.getUserId())
                .setOrientation(orientation)//必填参数，期望视频的播放方向：TTAdConstant.HORIZONTAL 或 TTAdConstant.VERTICAL
                .build();
        mTTAdNative.loadFullScreenVideoAd(adSlot, new TTAdNative.FullScreenVideoAdListener() {
            @Override
            public void onError(int i, String s) {
                mbListener.onError(String.valueOf(i),s);
            }

            @Override
            public void onFullScreenVideoAdLoad(TTFullScreenVideoAd ad) {
                ttFullScreenVideoAd = ad;
                ttFullScreenVideoAd.setFullScreenVideoAdInteractionListener(new TTFullScreenVideoAd.FullScreenVideoAdInteractionListener() {
                    @Override
                    public void onAdShow() {
                        maps.put("onAdMethod","onShow");
                        MbadsPlugin.mbEventPlugin.setContext(maps);
                    }

                    @Override
                    public void onAdVideoBarClick() {

                    }

                    @Override
                    public void onAdClose() {
                        maps.put("onAdMethod","onClose");
                        MbadsPlugin.mbEventPlugin.setContext(maps);
                    }

                    @Override
                    public void onVideoComplete() {
                        maps.put("onAdMethod","onComplete");
                        MbadsPlugin.mbEventPlugin.setContext(maps);
                    }

                    @Override
                    public void onSkippedVideo() {
                        maps.put("onAdMethod","onSkip");
                        MbadsPlugin.mbEventPlugin.setContext(maps);
                    }
                });

            }

            @Override
            public void onFullScreenVideoCached() {
                System.out.println("激励视频缓冲成功");
                maps.put("onAdMethod","onCache");
                MbadsPlugin.mbEventPlugin.setContext(maps);
            }

            @Override
            public void onFullScreenVideoCached(TTFullScreenVideoAd ad) {



            }
        });
    }

    public void show(Activity activity){
        if (activity != null && ttFullScreenVideoAd != null){
            ttFullScreenVideoAd.showFullScreenVideoAd(activity);
        }
    }



    public void isDestroy(){
        if( ttFullScreenVideoAd != null){
            ttFullScreenVideoAd = null;
        }
    }
}
