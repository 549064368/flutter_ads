//
//  FlowView.m
//  mbads
//
//  Created by 吴奶强 on 2021/11/29.
//

#import "FlowView.h"
#import "AdItem.h"
#import "MJExtension.h"
#import "ViewIdConfig.h"
#import <BUAdSDK/BUAdSDK.h>

@interface FlowView()<BUNativeExpressAdViewDelegate>

@property(nonatomic,strong)NSString *userId;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSArray<AdItem *> *adItems;

@property(nonatomic,strong)UIView *flowView;

@property(nonatomic,strong)NSString *errorMsg;

@property(nonatomic,strong)FlutterMethodChannel *flutterMethodChannel;

@property(nonatomic,strong)BUNativeExpressAdManager *ttExpressAdManager;

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)NSString *msgCode;

@end

@implementation FlowView


- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    self = [super init];
    if(self){
        NSDictionary *dict = args;
        NSLog(@"%@",dict);
        self.flowView = [UIView new];
        self.userId = dict[@"userId"];
        self.width = [dict[@"width"] floatValue];
        self.index = 0;
        self.adItems = [AdItem mj_objectArrayWithKeyValuesArray:dict[@"adItems"]];
        
        self.flutterMethodChannel = [[FlutterMethodChannel alloc] initWithName:[NSString stringWithFormat:@"%@_%lld",flowViewId,viewId] binaryMessenger:messenger codec:[FlutterStandardMethodCodec sharedInstance]];
        [self loadFlow];
    }
    return self;
}


- (nonnull UIView *)view {
    return self.flowView;
}

/// 加载开屏
-(void)loadFlow{
    if(self.adItems.count <= self.index){
        [self.flutterMethodChannel invokeMethod:@"onError" arguments:@"失败" result:nil];
        return;
    }
    AdItem *adItem = self.adItems[self.index];
    self.index ++;
    NSString *codeNo = adItem.iosCodeNo;
    if([codeNo isEqual:nil] || [codeNo isEqualToString:@""] ){
        codeNo = adItem.codeNo;
    }
    if(adItem.plat == 1){
        BUAdSlot *slot = [[BUAdSlot alloc] init];
        slot.ID = codeNo;
        slot.AdType = BUAdSlotAdTypeFeed;
        BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
        slot.imgSize = imgSize;
        slot.position = BUAdSlotPositionFeed;
        self.ttExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot adSize:CGSizeMake(self.width,0)];
        self.ttExpressAdManager.delegate = self;
        [self.ttExpressAdManager loadAdDataWithCount:1];
    }
}



/// 失败
/// @param nativeExpressAdManager <#nativeExpressAdManager description#>
/// @param error <#error description#>
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager error:(NSError *)error{
    self.msgCode = [NSString stringWithFormat:@"%ld,%@",error.code,error.domain];
    [self loadFlow];
}


/// 点击
/// @param nativeExpressAdView <#nativeExpressAdView description#>
-(void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView{
    [self.flutterMethodChannel invokeMethod:@"onClick" arguments:@""  result:nil];
}



/// 显示
/// @param nativeExpressAdView <#nativeExpressAdView description#>
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView{
    [self.flutterMethodChannel invokeMethod:@"onShow" arguments:@""  result:nil];
    
}


/// 不喜欢
/// @param nativeExpressAdView <#nativeExpressAdView description#>
/// @param filterWords <#filterWords description#>
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords{
    [self.flowView removeFromSuperview];
    [self.flutterMethodChannel invokeMethod:@"onDisLike" arguments:@""  result:nil];
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView{
    NSLog(@"信息流渲染成功");
    NSLog(@"信息流:%f",nativeExpressAdView.frame.size.height);
    CGFloat height = nativeExpressAdView.frame.size.height;
    [self.flutterMethodChannel invokeMethod:@"onLoad" arguments:[NSNumber numberWithFloat:height]  result:nil];
}

- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAdManager views:(NSArray<__kindof BUNativeExpressAdView *> *)views{
    
    NSLog(@"信息流成功");
    BUNativeExpressAdView *adView = views[0];
    if (views.count) {
        [adView render];
    }
    [self.flowView addSubview:adView];
    
}



@end
