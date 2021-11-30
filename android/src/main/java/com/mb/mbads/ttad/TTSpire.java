package com.mb.mbads.ttad;

import android.app.Activity;
import android.content.Context;

import com.bytedance.sdk.openadsdk.AdSlot;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdNative;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.bytedance.sdk.openadsdk.TTRewardVideoAd;
import com.mb.mbads.MbEventPlugin;
import com.mb.mbads.MbadsPlugin;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;

import java.util.HashMap;
import java.util.Map;

public class TTSpire {

    private TTAdNative mTTAdNative;
    private TTRewardVideoAd ttRewardVideoAd;
    private String mClassify;
    private Map<String,Object> maps = new HashMap<>();

    public TTSpire(Context context, AdItem adItem,String classify, MbListener mbListener){
        mTTAdNative = TTAdSdk.getAdManager().createAdNative(context);
        this.mClassify = classify;
        maps.put("adType","inspireAd");
        maps.put("onAdMethod","onCache");
        maps.put("classify",mClassify);

        AdSlot adSlot = new AdSlot.Builder()
                .setCodeId(adItem.getCodeNo()) //广告位id
                .setSupportDeepLink(true)
                .setAdCount(1) //请求广告数量为1到3条
                .setExpressViewAcceptedSize(500,500)
                .setRewardAmount(3)
                //.setDownloadType(adModel.getDownType())
                .setOrientation(TTAdConstant.VERTICAL)
                .setRewardName("金豆")
                //.setUserID(adModel.getUserId())
                .setMediaExtra("media_extra")
                .build();
        mTTAdNative.loadRewardVideoAd(adSlot, new TTAdNative.RewardVideoAdListener() {
            @Override
            public void onError(int i, String s) {
                System.out.println("激励视频广告失败");
                mbListener.onError(String.valueOf(i),s);
            }

            @Override
            public void onRewardVideoAdLoad(TTRewardVideoAd ttAd) {
                System.out.println("激励视频广告加载成功");
                ttRewardVideoAd = ttAd;
                ttRewardVideoAd.setRewardAdInteractionListener(new TTRewardVideoAd.RewardAdInteractionListener() {
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

                    }

                    @Override
                    public void onVideoError() {

                    }

                    @Override
                    public void onRewardVerify(boolean b, int i, String s, int i1, String s1) {
                        maps.put("onAdMethod","onVerify");
                        MbadsPlugin.mbEventPlugin.setContext(maps);
                    }

                    @Override
                    public void onSkippedVideo() {

                    }
                });

            }

            @Override
            public void onRewardVideoCached() {
                System.out.println("激励视频缓冲成功");
                maps.put("onAdMethod","onCache");
                MbadsPlugin.mbEventPlugin.setContext(maps);
            }

            @Override
            public void onRewardVideoCached(TTRewardVideoAd ttAd) {

            }
        });
    }

    public void show(Activity activity){
        if (activity != null && ttRewardVideoAd != null){
            ttRewardVideoAd.showRewardVideoAd(activity);
        }
    }



    public void isDestroy(){
        if( ttRewardVideoAd != null){
            ttRewardVideoAd = null;
        }
    }
}
