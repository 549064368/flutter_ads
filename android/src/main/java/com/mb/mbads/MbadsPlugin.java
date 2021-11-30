package com.mb.mbads;

import android.app.Activity;
import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.bytedance.sdk.openadsdk.TTAdConfig;
import com.bytedance.sdk.openadsdk.TTAdConstant;
import com.bytedance.sdk.openadsdk.TTAdSdk;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.mb.mbads.interfaces.MbListener;
import com.mb.mbads.model.AdItem;
import com.mb.mbads.tools.MbAdSdk;
import com.mb.mbads.tools.MbInsert;
import com.mb.mbads.tools.MbSpire;
import com.mb.mbads.tools.MbSplashFactory;
import com.mb.mbads.tools.MbFlowFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.StandardMessageCodec;

/** MbadsPlugin */
public class MbadsPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;
  private Activity activity;
  private Gson gson = new Gson();
  public static  MbEventPlugin mbEventPlugin;
  private Map<String,MbSpire> mbSpireMap = new HashMap<>();
  private Map<String,MbInsert> mbInsertMap = new HashMap<>();
  private FlutterPluginBinding flutterPluginBinding;

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
    //注册信息流广告
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(MbViewConfig.flowAdView, new MbFlowFactory(new StandardMessageCodec(),activity,flutterPluginBinding.getBinaryMessenger()));

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    this.activity = null;
  }


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mbads");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
    this.flutterPluginBinding = flutterPluginBinding;

    mbEventPlugin = new MbEventPlugin();
    mbEventPlugin.onAttachedToEngine(flutterPluginBinding);

    //注册开屏广告
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(MbViewConfig.splashAdView, new MbSplashFactory(new StandardMessageCodec(),flutterPluginBinding.getBinaryMessenger()));

  }


  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

    if (call.method.equals("initConfig")) {
      String ttId = call.argument("androidTTId");
      String appName = call.argument("appName");
      Boolean debug = call.argument("debug");
      MbAdSdk.MbInit(context, appName, ttId, debug, new MbListener() {
        @Override
        public void onError(String code, String msg) {
          new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
              result.success(true);
            }
          });

        }

        @Override
        public void initSuccess() {
          new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
              result.success(false);
            }
          });
        }
      });


    } else if(call.method.equals("inspireLoad")) {
      String json = call.argument("adItems");
      String classify = call.argument("classify");

      List<AdItem> adItems = gson.fromJson(json,new TypeToken<List<AdItem>>(){}.getType());
      MbSpire mbSpire = new MbSpire(context, adItems,classify);
      mbSpireMap.put(classify,mbSpire);


      result.success(true);
    } else if(call.method.equals("inspireShow")){
      String classify = call.argument("classify");
      MbSpire mbSpire = mbSpireMap.get(classify);
      if(mbSpire != null){
        mbSpire.showInspire(activity);
        result.success(true);
      } else{
        result.success(false);
      }
    } else if(call.method.equals("insertLoad")) {
      String json = call.argument("adItems");
      String classify = call.argument("classify");
      int orientation = call.argument("orientation");
      List<AdItem> adItems = gson.fromJson(json,new TypeToken<List<AdItem>>(){}.getType());
      MbInsert mbInsert = new MbInsert(context, adItems,classify,orientation);
      mbInsertMap.put(classify,mbInsert);
      result.success(true);
    } else if(call.method.equals("insertShow")){
      String classify = call.argument("classify");
      MbInsert mbInsert = mbInsertMap.get(classify);
      if(mbInsert != null){
        mbInsert.showInspire(activity);
        result.success(true);
      } else{
        result.success(false);
      }
    } else{
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);

  }


}
