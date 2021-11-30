
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbads/mb_method.dart';
import 'package:mbads/mbads.dart';

class FlowView extends StatefulWidget{

  var aditem;
  MbFlowCallBack callBack;
  double width;
  double height;
  String userId;
  FlowView({Key? key,required this.aditem,this.width = 0,this.height = 0,this.userId = "123",required this.callBack}) : super(key: key);

  @override
  FlowViewState createState() => FlowViewState(aditem,width,height,userId,callBack);

}
class FlowViewState extends State<FlowView>{

  String _viewType = "com.mb.mbads/MbFlow";
  late MethodChannel _methodChannel;
  var adItems;
  double width;
  double height;
  String userId;
  double viewHeight = 0;
  MbFlowCallBack callBack;
  FlowViewState(this.adItems,this.width,this.height,this.userId,this.callBack);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewHeight = height == 0 ? 50 : height;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    if(Platform.isAndroid){

      return SizedBox(
        height: viewHeight,
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
        height: viewHeight,
        child: UiKitView(
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
        setState(() {
          viewHeight = call.arguments;
        });
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
      case MbMethod.onDisLike:
        setState(() {
          viewHeight = 0;
        });
        widget.callBack.onDisLike!();
        break;
    }
  }

}