package com.mb.mbads.tools;

import android.content.Context;
import android.text.TextUtils;

import com.bytedance.sdk.openadsdk.TTAdConfig;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.mb.mbads.interfaces.MbListener;

public class MbAdSdk {

    private static Context mbContext;
    private static String mbTtid = "";
    private static String mbAppName = "";
    private static Boolean mbDebug = false;
    private static MbListener mbListener;

    public static void MbInit(Context context, String appName, String ttId, Boolean debug, MbListener listener){
        mbContext = context;
        mbAppName = appName;
        mbTtid = ttId;
        mbDebug = debug;
        mbListener = listener;

        if(!TextUtils.isEmpty(mbTtid)){
            TTinit();
        } else{
            listener.initSuccess();
        }

    }

    public static void TTinit(){
        TTAdConfig config = new TTAdConfig.Builder()
                .appId(mbTtid)
                .appName(mbAppName)
                .useTextureView(true) //使用TextureView控件播放视频,默认为SurfaceView,当有SurfaceView冲突的场景，可以使用TextureView
                .allowShowNotify(true) //是否允许sdk展示通知栏提示
                .debug(false) //测试阶段打开，可以通过日志排查问题，上线时去除该调用
                .directDownloadNetworkType() //允许直接下载的网络状态集合
                .supportMultiProcess(false)//是否支持多进程
                .needClearTaskReset()
                .build();
        TTAdSdk.init(mbContext, config, new TTAdSdk.InitCallback() {
            @Override
            public void success() {
                mbListener.initSuccess();
                System.out.println("初始化成功");
            }

            @Override
            public void fail(int i, String s) {
                mbListener.onError(String.valueOf(i),s);
                System.out.println("初始化失败:错误码" + i  +",错误信息：" + s);
            }
        });
    }
}
