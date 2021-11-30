//
//  InSpireView.m
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/29.
//

#import "InSpireView.h"
#import "AdItem.h"
#import "MJExtension.h"
#import <BUAdSDK/BUAdSDK.h>
#import "MbEventPlugin.h"

@interface InSpireView()<BUNativeExpressRewardedVideoAdDelegate>

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSArray<AdItem *> *adItems;
@property(nonatomic,strong)BUNativeExpressRewardedVideoAd *ttRewardAd;

@property(nonatomic,strong)NSString *classify;

@property(nonatomic,strong)NSString *errorMsg;

@end


@implementation InSpireView


+ (instancetype)shareInstanceInspire{
    static InSpireView *inSprieView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inSprieView = [[InSpireView alloc] init];
    });
    return inSprieView;
}




-(void)initData:(id)args{
    NSDictionary *dict = args;
    self.classify = dict[@"classify"];
    self.index = 0;
    self.adItems = [AdItem mj_objectArrayWithKeyValuesArray:dict[@"adItems"]];
    [self loadInspire];
}


/// 加载激励视频
-(void)loadInspire{
    if(self.adItems.count <= self.index){
        MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
        NSDictionary *dict = @{@"onAdMethod":@"onError",@"adType":@"inspireAd",@"errorMsg":self.errorMsg };
        [mbEventPlugin sendEvent:dict];
        return;
    }
    AdItem *adItem = self.adItems[self.index];
    self.index ++;
    NSString *codeNo = adItem.iosCodeNo;
    if([codeNo isEqual:nil] || [codeNo isEqualToString:@""]  ){
        codeNo = adItem.codeNo;
    }
    if(adItem.plat == 1){
        BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
        model.userId = @"tag123";
        NSLog(@"视频codeNo:%@",codeNo);
        self.ttRewardAd = [[BUNativeExpressRewardedVideoAd alloc]initWithSlotID:codeNo rewardedVideoModel:model];
        self.ttRewardAd.delegate = self;
        //self.ttRewardAd.rewardPlayAgainInteractionDelegate = self;
        [self.ttRewardAd loadAdData];
    }
}


/// 加载广告
/// @param rewardedVideoAd <#rewardedVideoAd description#>
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"视频加载完成");
    
}


/// 错误信息
/// @param rewardedVideoAd <#rewardedVideoAd description#>
/// @param error <#error description#>
- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error{
    NSLog(@"激励视频错误信息:%@",error);
    self.errorMsg = [NSString stringWithFormat:@"%ld,%@",error.code,error.domain];
    [self loadInspire];
}

/// 模版激励视频广告已经展示
/// @param rewardedVideoAd <#rewardedVideoAd description#>
- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"激励视频显示");
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onShow",@"adType":@"inspireAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd{
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onClose",@"adType":@"inspireAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *)error{
    NSLog(@"激励视频渲染失败信息:%@",error);
}


/// 可保证播放流畅和展示流畅，用户体验更好。
/// @param rewardedVideoAd <#rewardedVideoAd description#>
- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd{
    NSLog(@"激励视频素材下载完成");
    
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onCache",@"adType":@"inspireAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


/// 回调信息
/// @param rewardedVideoAd <#rewardedVideoAd description#>
/// @param verify <#verify description#>
- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"激励视频验证");
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onVerify",@"adType":@"inspireAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


- (void)showInpire{
    [self.ttRewardAd showAdFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}


@end
