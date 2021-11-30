//
//  SplashView.m
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/29.
//

#import "SplashView.h"
#import "MJExtension.h"
#import "AdItem.h"
#import "ViewIdConfig.h"
#import <BUAdSDK/BUAdSDK.h>

@interface SplashView()<BUSplashAdDelegate>

@property(nonatomic,strong)NSString *userId;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSArray<AdItem *> *adItems;

@property(nonatomic,strong)UIView *splashView;
@property(nonatomic,strong)BUSplashAdView *ttSplashView;

@property(nonatomic,strong)NSString *errorMsg;

@property(nonatomic,strong)FlutterMethodChannel *flutterMethodChannel;

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;

@end

@implementation SplashView

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    self = [super init];
    if(self){
        NSDictionary *dict = args;
        NSLog(@"%@",dict);
        self.splashView = [UIView new];
        self.userId = dict[@"userId"];
        self.width = [dict[@"width"] floatValue];
        self.height = [dict[@"height"] floatValue];
        self.index = 0;
        self.adItems = [AdItem mj_objectArrayWithKeyValuesArray:dict[@"adItems"]];
        
        self.flutterMethodChannel = [[FlutterMethodChannel alloc] initWithName:[NSString stringWithFormat:@"%@_%lld",splashViewId,viewId] binaryMessenger:messenger codec:[FlutterStandardMethodCodec sharedInstance]];
        
        [self loadSplash];
    }
    return self;
}

- (nonnull UIView *)view {
    return self.splashView;
}


/// 加载开屏
-(void)loadSplash{
    if(self.adItems.count <= self.index){
        [self.flutterMethodChannel invokeMethod:@"onError" arguments:@"加载" result:nil];
        return;
    }
    AdItem *adItem = self.adItems[self.index];
    self.index ++;
    NSString *codeNo = adItem.iosCodeNo;
    if([codeNo isEqual:nil] || [codeNo isEqualToString:@""] ){
        codeNo = adItem.codeNo;
    }
    if(adItem.plat == 1){
        
        if(self.width == 0){
            self.width =[UIScreen mainScreen].bounds.size.width;
        }
        if(self.height == 0){
            self.height =[UIScreen mainScreen].bounds.size.height;
        }
        CGRect frame = CGRectMake(0, 0, self.width, self.height);
        
        self.ttSplashView = [[BUSplashAdView alloc] initWithSlotID:codeNo frame:frame];
        self.ttSplashView.tolerateTimeout = 10;
        self.ttSplashView.delegate = self;
        [self.ttSplashView loadAdData];
        self.ttSplashView.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        [self.splashView addSubview:self.ttSplashView];
    }
}


/// 开屏失败
/// @param splashAd <#splashAd description#>
/// @param error <#error description#>
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error{
    
    self.errorMsg = [NSString stringWithFormat:@"%ld,%@",error.code,error.domain];
    [self loadSplash];
}


/// 加载显示
/// @param splashAd <#splashAd description#>
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd{
    [self.flutterMethodChannel invokeMethod:@"onLoad" arguments:@"开屏加载" result:nil];
    
}


/// 开屏显示
/// @param splashAd <#splashAd description#>
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd{
    [self.flutterMethodChannel invokeMethod:@"onShow" arguments:nil result:^(id  _Nullable result) {
        
    }];
}


/// 开屏倒计时
/// @param splashAd <#splashAd description#>
/// @param interactionType <#interactionType description#>
- (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType{
    [self.flutterMethodChannel invokeMethod:@"onSkip" arguments:nil result:^(id  _Nullable result) {
        
    }];
}

/// 点击跳过
/// @param splashAd <#splashAd description#>
- (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd{
    [self.flutterMethodChannel invokeMethod:@"onSkip" arguments:nil result:^(id  _Nullable result) {
        
    }];
}

/// 点击
/// @param splashAd <#splashAd description#>
- (void)splashAdDidClick:(BUSplashAdView *)splashAd{
    [self.flutterMethodChannel invokeMethod:@"onClick" arguments:nil result:^(id  _Nullable result) {
        
    }];
}


/// 倒计时结束
/// @param splashAd <#splashAd description#>
- (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd{
    [self.flutterMethodChannel invokeMethod:@"onOver" arguments:nil result:^(id  _Nullable result) {
        
    }];
}


@end


