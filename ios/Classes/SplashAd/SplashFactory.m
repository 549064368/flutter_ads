//
//  SplashFactory.m
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/29.
//

#import "SplashFactory.h"
#import "SplashView.h"


@interface SplashFactory()

@property(nonatomic,strong) NSObject<FlutterBinaryMessenger> *messager;

@end

@implementation SplashFactory

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messager = messager;
    }
    return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {    
    return [[SplashView alloc]initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messager];
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

@end
