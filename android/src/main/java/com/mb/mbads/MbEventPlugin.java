package com.mb.mbads;

import android.content.Context;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;

public class MbEventPlugin implements FlutterPlugin, EventChannel.StreamHandler{


    private EventChannel.EventSink eventSink;
    private EventChannel eventChannel;
    private Context context;

    public void setContext(Map<String,Object> maps) {
        //this.context = context;
        eventSink.success(maps);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink= null;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        eventChannel = new EventChannel(binding.getBinaryMessenger(), MbViewConfig.mbEvent);
        eventChannel.setStreamHandler(this);
        context = binding.getApplicationContext();
       
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        eventChannel = null;
        eventChannel.setStreamHandler(null);
    }

}
