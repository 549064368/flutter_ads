//
//  InsertView.m
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/30.
//

#import "InsertView.h"
#import "AdItem.h"
#import "MJExtension.h"
#import <BUAdSDK/BUAdSDK.h>
#import "MbEventPlugin.h"

@interface InsertView()<BUNativeExpressFullscreenVideoAdDelegate>

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSArray<AdItem *> *adItems;

@property(nonatomic,strong)NSString *classify;

@property(nonatomic,strong)NSString *errorMsg;

@property(nonatomic,assign)NSInteger orientation;

@property(nonatomic,strong)BUNativeExpressFullscreenVideoAd *ttFullscreenAd;

@end

@implementation InsertView


+ (instancetype)shareInstanceInspire{
    static InsertView *insertView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        insertView = [[InsertView alloc] init];
    });
    return insertView;
}


-(void)initData:(id)args{
    NSDictionary *dict = args;
    self.classify = dict[@"classify"];
    //self.orientation = dict[@"orientation"];
    self.index = 0;
    self.adItems = [AdItem mj_objectArrayWithKeyValuesArray:dict[@"adItems"]];
    [self loadInsert];
}


/// 加载激励视频
-(void)loadInsert{
    if(self.adItems.count <= self.index){
        MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
        NSDictionary *dict = @{@"onAdMethod":@"onError",@"adType":@"insertAd",@"errorMsg":self.errorMsg };
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
        
        BUAdSlot *slot = [[BUAdSlot alloc]init];
        [slot setID:codeNo];
        self.ttFullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:codeNo];
        self.ttFullscreenAd.delegate = self;
        [self.ttFullscreenAd loadAdData];
    }
}


/// 错误信息
/// @param fullscreenVideoAd <#fullscreenVideoAd description#>
/// @param error <#error description#>
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error{
    [self loadInsert];
}


/// 视频下载完成
/// @param fullscreenVideoAd <#fullscreenVideoAd description#>
- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd{
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onCache",@"adType":@"insertAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


/// 插屏广告关闭
/// @param fullscreenVideoAd <#fullscreenVideoAd description#>
- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd{
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onClose",@"adType":@"insertAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
    
}


/// 插屏播放完成
/// @param fullscreenVideoAd <#fullscreenVideoAd description#>
/// @param error <#error description#>
- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error{
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onComplete",@"adType":@"insertAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


/// 插屏点击跳过
/// @param fullscreenVideoAd <#fullscreenVideoAd description#>
- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd{
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onSkip",@"adType":@"insertAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


/// 插屏显示
/// @param fullscreenVideoAd <#fullscreenVideoAd description#>
- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd{
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    NSDictionary *dict = @{@"onAdMethod":@"onShow",@"adType":@"insertAd",@"classify":self.classify };
    [mbEventPlugin sendEvent:dict];
}


/// 显示插屏
- (void)showInsert{
    [self.ttFullscreenAd showAdFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}


@end
