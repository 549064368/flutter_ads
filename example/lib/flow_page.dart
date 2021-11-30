
import 'package:flutter/material.dart';
import 'package:mbads/mbads.dart';
import 'package:mbads_example/toast.dart';

class FlowPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FlowPageState();
  }
}

class FlowPageState extends State{

  var adItems = <AdItem>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var adItem01 = AdItem("947146425","947146510",1);
    adItems.add(adItem01);


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar:AppBar(
        title: const Text('信息流'),
      ),
      body:Column(
        children: [
          Mbads.flowAd(adItems: adItems,
              width: MediaQuery.of(context).size.width,
              callBack: MbFlowCallBack(
                  onLoad: (){
                    print("加载成功");
                    ToastUtils.show("加载成功");
                  },
                  onShow: (){
                    print("加载显示");
                    ToastUtils.show("显示");
                  },
                  onError: (msg){
                    print("加载失败");
                    ToastUtils.show("错误：" + msg);
                  },
                  onClick: (){
                    ToastUtils.show("点击");
                  },
                  onDisLike: (){
                    ToastUtils.show("不喜欢");
                  }
              )),
        ],
      ),
    );
  }

}



