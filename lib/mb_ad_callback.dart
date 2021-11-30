part of 'mbads.dart';

///加载成功
typedef OnLoad = void Function();

///点击
typedef OnClick = void Function();

///显示
typedef OnShow = void Function();

///跳过
typedef OnSkip = void Function();

///广告倒计时结束
typedef OnOver = void Function();

///广告关闭
typedef OnDisLike= void Function();

///广告错误
typedef OnError = void Function(dynamic message);

///广告关闭
typedef OnClose = void Function(dynamic message);

///视频显示
typedef OnShowVideo = void Function(dynamic message);

///广告关闭
typedef OnCache = void Function(dynamic message);

///校验
typedef OnVerify = void Function(dynamic message);

///广告错误
typedef OnErrorVideo = void Function(dynamic message,dynamic msg);

///加载信息成功
typedef OnFlowLoad = void Function();

///加载信息成功
typedef OnComplete = void Function(dynamic message);


///跳过
typedef OnSkipVideo = void Function(dynamic message);

///
///开屏广告回调
///
class MbSplashCallBack {
  OnLoad? onLoad;
  OnShow? onShow;
  OnClick? onClick;
  OnOver? onOver;
  OnSkip? onSkip;
  OnError? onError;


  MbSplashCallBack(
      {this.onLoad,
        this.onShow,
        this.onClick,
        this.onOver,
        this.onSkip,
        this.onError});
}

///
///激励广告回调
///
class MbInspireCallBack {
  OnShowVideo? onShow;
  OnCache? onCache;
  OnClose? onClose;
  OnVerify? onVerify;
  OnErrorVideo? onError;

  MbInspireCallBack(
      {this.onShow,
        this.onCache,
        this.onClose,
      this.onVerify,
      this.onError});
}

///
///信息流
///
class MbFlowCallBack {
  OnLoad? onLoad;
  OnShow? onShow;
  OnClick? onClick;
  OnDisLike? onDisLike;
  OnError? onError;

  MbFlowCallBack(
      {this.onLoad,
        this.onShow,
        this.onClick,
        this.onDisLike,
        this.onError});
}

///
///插屏回调
///
class MbInsertCallBack {
  OnShowVideo? onShow;
  OnCache? onCache;
  OnClose? onClose;
  OnComplete? onComplete;
  OnSkipVideo? onSkip;
  OnErrorVideo? onError;

  MbInsertCallBack(
      {this.onShow,
        this.onCache,
        this.onClose,
        this.onComplete,
        this.onSkip,
        this.onError});
}

