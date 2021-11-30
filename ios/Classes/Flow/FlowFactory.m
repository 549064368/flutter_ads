//
//  FlowFactory.m
//  mbads
//
//  Created by 吴奶强 on 2021/11/29.
//

#import "FlowFactory.h"
#import "FlowView.h"

@interface FlowFactory()

@property(nonatomic,strong) NSObject<FlutterBinaryMessenger> *messager;

@end


@implementation FlowFactory


- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messager = messager;
    }
    return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    return [[FlowView alloc]initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messager];
}

- (NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

@end
