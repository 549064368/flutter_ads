import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mbads/mb_method.dart';
import 'mbads.dart';

/// @Author: gstory
/// @CreateDate: 2021/5/25 7:45 下午
/// @Description: 广告结果监听

const EventChannel adEventEvent = EventChannel("com.mb.mbads/mbevent");

class MbAdStream {

  ///注册stream监听原生返回的信息
  static StreamSubscription initAdStream({
    MbInspireCallBack? mbInspireCallBack,MbInsertCallBack ? mbInsertCallBack}) {
    StreamSubscription _adStream = adEventEvent.receiveBroadcastStream().listen((data) {
      switch (data[MbAdType.adType]){
          ///激励广告
        case MbAdType.inspireAd:
          switch (data[MbMethod.onAdMethod]) {
            case MbMethod.onShow:
              mbInspireCallBack?.onShow!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onCache:
              mbInspireCallBack?.onCache!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onVerify:
              mbInspireCallBack?.onVerify!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onClose:
              mbInspireCallBack?.onClose!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onError:
              mbInspireCallBack?.onError!(data[MbAdParameter.classify],data[MbAdParameter.errorMsg]);
              break;
          }
          break;
        case MbAdType.insertAd:
          switch (data[MbMethod.onAdMethod]) {
            case MbMethod.onShow:
              mbInsertCallBack?.onShow!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onCache:
              mbInsertCallBack?.onCache!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onComplete:
              mbInsertCallBack?.onComplete!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onSkip:
              mbInsertCallBack?.onSkip!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onClose:
              mbInsertCallBack?.onClose!(data[MbAdParameter.classify]);
              break;
            case MbMethod.onError:
              mbInsertCallBack?.onError!(data[MbAdParameter.classify],data[MbAdParameter.errorMsg]);
              break;
          }

      }
    });
    return _adStream;
  }

  static void deleteAdStream(StreamSubscription stream) {
    stream.cancel();
  }
}
