//
//  MbEventPlugin.m
//  mbads
//
//  Created by 吴奶强 on 2021/11/29.
//

#import "MbEventPlugin.h"


@interface MbEventPlugin()<FlutterStreamHandler>


@property(nonatomic,strong)FlutterEventSink flutterSink;

@end


@implementation MbEventPlugin

+ (instancetype)shareInstanceEventPlugin{
    static MbEventPlugin *eventPlugin;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        eventPlugin = [[MbEventPlugin alloc] init];
    });
    return eventPlugin;
}


- (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterEventChannel *eventChannel = [[FlutterEventChannel alloc]initWithName:@"com.mb.mbads/mbevent" binaryMessenger:[registrar messenger] codec:[FlutterStandardMethodCodec sharedInstance]];
    [eventChannel setStreamHandler:self];
}


- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {

    self.flutterSink = events;
    return nil;
}

-(void)sendEvent:(NSDictionary* )event {
    self.flutterSink(event);
}


@end
