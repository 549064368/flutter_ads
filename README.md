# 字节跳动穿山甲广告 Flutter版本

## 简介
mbadd是一款集成了穿山甲Android和iOSSDK的Flutter插件,**瀑布流广告**,方便直接调用穿山甲SDK方法开发

![](https://github.com/549064368/flutter_ads/blob/main/211638262978_.pic.jpg)

### 集成步骤
#### 1、pubspec.yaml
```Dart
mbads: ^0.0.3
```

## 引入
```Dart
import 'package:mbads/mbads.dart';
```


## 使用

#### 1、SDK初始化
```Dart
await Mbads.initConfig(
        androidTTId: "5236748",
        iosTTId: '5236749',
        appName: "xx", );
}; 
```



#### 2、开屏广告
```Dart
var adItems = <AdItem>[];
var adItem01 = AdItem("947146425","947146510",1);
adItems.add(adItem01);
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
    )
)
```
#### 3、信息流广告
```dart
var adItems = <AdItem>[];
var adItem01 = AdItem("947146425","947146510",1);
adItems.add(adItem01);
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
    )
),
```

#### 4、激励视频广告
预加载激励视频广告,支持预加载不显示，后面在显示
```Dart
var adItems = <AdItem>[];
var adItem01 = AdItem("947146078","947146512",1);
adItems.add(adItem01);
Mbads.inspireLoad(adItems: adItems);
```
显示激励视频广告
```dart
 await Mbads.inspireShow();;
```
监听激励视频结果

```Dart
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
);
```
#### 5、新模版渲染插屏广告  分为全屏和插屏
预加载新模版渲染插屏广告
```dart
var adItems = <AdItem>[];
var adItem01 = AdItem("947201348","947202035",1);
adItems.add(adItem01);
Mbads.insertLoad(adItems: adItems);
```

显示新模版渲染插屏广告
```dart
  await  Mbads.insertShow();
```

新模版渲染插屏广告结果监听
```dart
MbAdStream.initAdStrea(mbInsertCallBack: MbInsertCallBack(
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
    ),
);    
```


## 联系方式
* Email:2935288965@qq.com
* QQ群: 461100151
