package com.mb.mbads.tools;

import android.content.Context;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.mb.mbads.model.AdItem;

import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class MbSplashFactory extends PlatformViewFactory {
    /**
     * @param createArgsCodec the codec used to decode the args parameter of {@link #create}.
     */
    private Gson gson = new Gson();

    private BinaryMessenger binaryMessenger;

    public MbSplashFactory(MessageCodec<Object> createArgsCodec, BinaryMessenger binaryMessenger) {
        super(createArgsCodec);
        this.binaryMessenger = binaryMessenger;
    }

    @Override
    public PlatformView create(Context context, int viewId, Object args) {
        Map<String,Object> params = (Map<String, Object>) args;
        String json = (String) params.get("adItems");
        Double width = (Double) params.get("width");
        Double height = (Double) params.get("height");
        String userId = (String) params.get("userId");
        List<AdItem> adItems = gson.fromJson(json,new TypeToken<List<AdItem>>(){}.getType());
        return new MbSplash(context,adItems,width.floatValue(),height.floatValue(),userId,binaryMessenger,viewId);
    }
}
