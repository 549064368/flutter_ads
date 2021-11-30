
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbads/mb_method.dart';
import 'package:mbads/mbads.dart';

class SplashView extends StatefulWidget{

  var aditem;
  MbSplashCallBack callBack;
  double width;
  double height;
  String userId;
  SplashView({Key? key,required this.aditem,this.width = 0,this.height = 0,this.userId = "123",required this.callBack}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState(aditem,width,height,userId,callBack);

}
class SplashViewState extends State<SplashView>{

  String _viewType = "com.mb.mbads/MbSplash";
  late MethodChannel _methodChannel;
  var adItems;
  double width;
  double height;
  String userId;
  MbSplashCallBack callBack;
  SplashViewState(this.adItems,this.width,this.height,this.userId,this.callBack);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(Platform.isAndroid){
      return SizedBox(
        width: width == 0 ?  MediaQuery.of(context).size.width : width,
        height: height == 0 ? MediaQuery.of(context).size.height :height,
        child: AndroidView(
          viewType: _viewType,
          creationParams: {
            "adItems": adItems,
            "width":width,
            "height":height,
            "userId":userId,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if(Platform.isIOS){
      return SizedBox(
        width: width == 0 ?  MediaQuery.of(context).size.width : width,
        height: height == 0 ? MediaQuery.of(context).size.height :height,
        child: UiKitView(
          viewType: _viewType,
          creationParams:<String,dynamic>{
            "adItems": adItems,
            "width":width,
            "height":height,
            "userId":userId,
          },
          onPlatformViewCreated: _registerChannel,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else{
      return Container();
    }
  }

  //注册cannel
  void _registerChannel(int id) {

    _methodChannel = MethodChannel("${_viewType}_$id");
    _methodChannel.setMethodCallHandler(_platformCallHandler);
  }

  //监听原生view传值
  Future<dynamic> _platformCallHandler(MethodCall call) async {

    switch (call.method) {
      case MbMethod.onLoad:
        widget.callBack.onLoad!();
        break;
      case MbMethod.onShow:
        widget.callBack.onShow!();
        break;
      case MbMethod.onClick:
        widget.callBack.onClick!();
        break;
      case MbMethod.onError:
        widget.callBack.onError!(call.arguments);
        break;
      case MbMethod.onSkip:
        widget.callBack.onSkip!();
        break;
      case MbMethod.onOver:
        widget.callBack.onOver!();
        break;
    }
  }

}