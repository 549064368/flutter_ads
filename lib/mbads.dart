
import 'dart:async';
export 'package:mbads/mb_ad_stream.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:mbads/splash/splash_view.dart';

import 'flow/flow_view.dart';
part 'package:mbads/mb_ad_callback.dart';
part 'package:mbads/aditem.dart';



class Mbads {
  static const MethodChannel _channel = MethodChannel('mbads');

  /// # SDK注册初始化
  ///
  ///[androidTTId] 穿山甲广告 Android appid
  ///
  ///[iosTTId] 穿山甲广告 ios appid
  ///
  ///[appname] 必填
  ///
  ///[debug] 是否打开日志
  ///

  static Future<bool?> initConfig({
    required String androidTTId,
    required String iosTTId,
    required String appName,
    bool debug = false}) async{

    return await _channel.invokeMethod("initConfig",{
      "androidTTId":androidTTId,
      "iosTTId":iosTTId,
      "appName":appName,
      "debug":debug,
    });
  }

  /// # 开屏广告
  ///
  ///[width] 宽度，默认可以不传，不传全屏
  ///
  ///[height] 高度，默认可以不传，不传全屏
  ///
  ///[userId] 用户id,
  ///
  ///[callBack] 回调开屏状态
  ///

  static Widget splashAd({
     required List<AdItem> adItems,
     double width = 0,
     double height = 0,
     String userId = "123",
     required MbSplashCallBack callBack}){
     String ads = json.encode(adItems);
     return SplashView(aditem: ads,
       width: width,
       height: height,
       userId: userId,
       callBack: callBack,);
  }

  /// # 开屏广告
  ///
  ///[width] 宽度，必填
  ///
  ///[height] 高度，默认可以不传，不传全屏
  ///
  ///[userId] 用户id,
  ///
  ///[callBack] 回调开屏状态
  ///

  static Widget flowAd({
    required List<AdItem> adItems,
    required double width,
    double height = 0,
    String userId = "123",
    required MbFlowCallBack callBack}){
    String ads = json.encode(adItems);
    return FlowView(aditem: ads,
      width: width,
      height: height,
      userId: userId,
      callBack: callBack,);
  }

  /// # 加载激励视频
  ///
  ///[adItems]  必传
  ///
  ///[classify] 分类，如遇到多个激励视频，可用classif区分，可以实现预加载，先不显示，
  ///
  ///
  static inspireLoad({
    required List<AdItem> adItems,
    String classify = "mb"}) async{
    String ads = json.encode(adItems);
    return await _channel.invokeMethod("inspireLoad",{
      "adItems":ads,
      "classify":classify
    });
  }

  /// # 显示激励视频
  ///
  ///[adItems]  必传
  ///
  ///[classify] 分类，如遇到多个激励视频，可用classif区分，可以实现预加载，先不显示，
  ///
  ///

  static inspireShow({
    String classify = "mb"}) async{
    return await _channel.invokeMethod("inspireShow",{
      "classify":classify
    });
  }

  /// # 加载新插屏广告
  ///
  ///[adItems]  必传
  ///
  ///[classify] 分类，如遇到多个激励视频，可用classif区分
  ///
  /// [orientation] 视频方向，默认是竖屏，1：竖屏，2:横屏
  ///
  static insertLoad({
    required List<AdItem> adItems,
    String classify = "mb",
    int orientation = 1}) async{
    String ads = json.encode(adItems);
    return await _channel.invokeMethod("insertLoad",{
      "adItems":ads,
      "classify":classify,
      "orientation":orientation
    });
  }

  /// # 显示新插屏广告
  ///
  ///[adItems]  必传
  ///
  ///[classify] 分类，如遇到多个激励视频，可用classif区分
  ///
  ///
  static insertShow({
    String classify = "mb"}) async{
    return await _channel.invokeMethod("insertShow",{
      "classify":classify
    });
  }

}
