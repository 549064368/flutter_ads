import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mbads/mbads.dart';
import 'package:mbads_example/splash_page.dart';
import 'package:mbads_example/toast.dart';

import 'flow_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    Mbads.initConfig(
      androidTTId: "5236748",
      iosTTId: '5236749',
      appName: "每日猜歌", );

    MbAdStream.initAdStream(mbInspireCallBack: MbInspireCallBack(
      onShow: (classify){
        ToastUtils.show("激励显示:" + classify);
      },
      onCache: (classify){
        ToastUtils.show("激励视频加载成功:" + classify);
      },
      onVerify: (classify){
        ToastUtils.show("激励视频领取奖励:" + classify);
      },
      onClose: (classify){
        ToastUtils.show("激励视频关闭:" + classify);
      },
      onError: (classify,msg){
        ToastUtils.show("激励视频错误:" + classify + "," + msg);
      }
    ),mbInsertCallBack: MbInsertCallBack(
        onShow: (classify){
          ToastUtils.show("新插屏显示:" + classify);
        },
        onCache: (classify){
          ToastUtils.show("新插屏加载成功:" + classify);
        },
        onComplete: (classify){
          ToastUtils.show("新插屏领取奖励:" + classify);
        },
        onSkip: (classify){
          ToastUtils.show("新插屏领取奖励:" + classify);
        },
        onClose: (classify){
          ToastUtils.show("新插屏关闭:" + classify);
        },
        onError: (classify,msg){
          ToastUtils.show("新插屏错误:" + classify + "," + msg);
        }
    ));



  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('猫呗 瀑布流广告'),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: const Text("初始化按钮"),
                onPressed: (){

                  Mbads.initConfig(
                      androidTTId: "5236748",
                      iosTTId: '5236749',
                      appName: "xx", );
                },
                textColor: Colors.white,
                color: Colors.blue,
                minWidth: 270,
              ),
              MaterialButton(
                child: const Text("开屏"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashPage()));
                },
                textColor: Colors.white,
                color: Colors.blue,
                minWidth: 270,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: const Text("激励视频"),
                    onPressed: (){
                      var adItems = <AdItem>[];
                      var adItem01 = AdItem("947146078","947146512",1);
                      adItems.add(adItem01);
                      Mbads.inspireLoad(adItems: adItems);
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    minWidth: 130
                  ),
                  const SizedBox(width: 10,),
                  MaterialButton(
                    child: const Text("显示激励视频"),
                    onPressed: (){
                      Mbads.inspireShow();
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    minWidth: 130,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      child: const Text("激励视频2"),
                      onPressed: (){
                        var adItems = <AdItem>[];
                        var adItem01 = AdItem("947146412","947146499",1);
                        adItems.add(adItem01);
                        Mbads.inspireLoad(adItems: adItems,classify: "xx");
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      minWidth: 130,
                    ),
                    const SizedBox(width: 10,),
                    MaterialButton(
                      child: const Text("显示激励视频2",),
                      onPressed: (){
                        Mbads.inspireShow(classify: "xx");
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      minWidth: 130,
                    ),
                ],
              ),

              MaterialButton(
                child: const Text("信息流"),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FlowPage()));
                },
                textColor: Colors.white,
                color: Colors.blue,
                minWidth: 270,
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    child: const Text("新插屏"),
                    onPressed: (){
                      var adItems = <AdItem>[];
                      var adItem01 = AdItem("947201348","947202035",1);
                      adItems.add(adItem01);
                      Mbads.insertLoad(adItems: adItems);
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    minWidth: 130,
                  ),
                  const SizedBox(width: 10,),
                  MaterialButton(
                    child: const Text("新插屏显示",),
                    onPressed: (){
                      Mbads.insertShow();
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    minWidth: 130,
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
