


class MbMethod{

  ///stream中 广告方法
  static const String onAdMethod = "onAdMethod";

  ///广告加载状态 view使用
  ///广告加载成功
  static const String onLoad = "onLoad";

  ///广告点击
  static const String onClick = "onClick";

  ///广告展示
  static const String onShow = "onShow";

  ///广告跳过
  static const String onSkip = "onSkip";

  ///广告倒计时结束
  static const String onOver = "onOver";

  ///广告失败
  static const String onError = "onError";

  ///缓冲结束
  static const String onCache = "onCache";

  ///验证
  static const String onVerify = "onVerify";

  ///关闭
  static const String onClose = "onClose";

  ///不喜欢
  static const String onDisLike = "onDisLike";


  ///视频完成
  static const String onComplete = "onComplete";

}

///数据类型
class MbAdType {
  ///广告类型
  static const String adType = "adType";

  ///激励广告
  static const String inspireAd = "inspireAd";

  ///新插屏
  static const String insertAd = "insertAd";
}

class MbAdParameter{
  //广告类型
  static const String classify = "classify";

  //错误信息
  static const String errorMsg = "errorMsg";
}