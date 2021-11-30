
import 'package:flutter/material.dart';
import 'package:mbads/mbads.dart';
import 'package:mbads_example/toast.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashPageState();
  }
}

class SplashPageState extends State{

  var adItems = <AdItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var adItem01 = AdItem("887625901","887626231",1);
    adItems.add(adItem01);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Mbads.splashAd(
            adItems: adItems,
            callBack:MbSplashCallBack(
          onLoad: (){
            print("加载成功");
            ToastUtils.show("加载成功");
          },
          onShow: (){
            print("显示成功");
            ToastUtils.show("显示成功");
          },
          onClick: (){
            ToastUtils.show("点击");
          },
          onError: (msg){
            ToastUtils.show(msg);
          },
          onSkip: (){
            ToastUtils.show("跳过");
            Navigator.pop(context);
          },
          onOver: (){
            Navigator.pop(context);
            ToastUtils.show("倒计时结束");
          },
        ))
      ],
    );
  }

}



