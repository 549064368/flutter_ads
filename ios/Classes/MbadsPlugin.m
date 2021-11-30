#import "MbadsPlugin.h"
#import <BUAdSDK/BUAdSDK.h>
#import "SplashFactory.h"
#import "ViewIdConfig.h"
#import "InSpireView.h"
#import "MbEventPlugin.h"
#import "FlowFactory.h"
#import "AdItem.h"
#import "MJExtension.h"
#import "InsertView.h"

@interface MbadsPlugin()

@property(nonatomic,strong)NSMutableDictionary *inspireDict;


@property(nonatomic,strong)NSMutableDictionary *insertDict;

@end


@implementation MbadsPlugin

//- (NSMutableDictionary *)inspireDict{
//    return [[NSMutableDictionary alloc]init];
//}


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"mbads"
            binaryMessenger:[registrar messenger]];
    MbadsPlugin* instance = [[MbadsPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];

    
    MbEventPlugin *mbEventPlugin = [MbEventPlugin shareInstanceEventPlugin];
    [mbEventPlugin registerWithRegistrar:registrar];
  
    
    //注册开屏
    [registrar registerViewFactory: [[SplashFactory alloc]initWithMessenger:[registrar messenger]] withId:splashViewId];
    //信息流
    [registrar registerViewFactory: [[FlowFactory alloc]initWithMessenger:[registrar messenger]] withId:flowViewId];
    
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"initConfig" isEqualToString:call.method]) {
      NSDictionary *dict = call.arguments;
      NSString *ttId = dict[@"iosTTId"];
      BOOL debug = dict[@"debug"];
      if(![ttId isEqualToString:@""]){
          BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
          configuration.territory = BUAdSDKTerritory_CN;
          configuration.GDPR = @(0);
          configuration.coppa = @(0);
          configuration.CCPA = @(1);
          //configuration.logLevel = debug ? BUAdSDKLogLevelVerbose : BUAdSDKLogLevelNone;
          configuration.logLevel = BUAdSDKLogLevelVerbose;
          configuration.appID = ttId;
          [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
              if (success) {
                  dispatch_async(dispatch_get_main_queue(), ^{
                      NSLog(@"穿山甲初始化成功");
                      result([NSNumber numberWithBool:true]);
                  });
              } else{
                  dispatch_async(dispatch_get_main_queue(), ^{
                      NSLog(@"穿山甲初始化失败");
                      result([NSNumber numberWithBool:false]);
                  });
              }
          }];
      }
  } else if([@"inspireLoad" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *classify = dict[@"classify"];
      InSpireView *inspireView = [[InSpireView alloc]init];
      [inspireView initData:call.arguments];
      if(self.inspireDict == NULL){
          self.inspireDict = [[NSMutableDictionary alloc]init];
      }
      [self.inspireDict setObject:inspireView forKey:classify];
      result([NSNumber numberWithBool:true]);
  } else if([@"inspireShow" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *classify = dict[@"classify"];

      InSpireView *inspireView = [self.inspireDict objectForKey:classify];
      if(inspireView != NULL){
          [inspireView showInpire];
          result([NSNumber numberWithBool:true]);
      } else{
          result([NSNumber numberWithBool:false]);
      }
  } else if([@"insertLoad" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *classify = dict[@"classify"];
      InsertView *insertView = [[InsertView alloc]init];
      [insertView initData:call.arguments];
      if(self.insertDict == NULL){
          self.insertDict = [[NSMutableDictionary alloc]init];
      }
      [self.insertDict setObject:insertView forKey:classify];
      result([NSNumber numberWithBool:true]);
  } else if([@"insertShow" isEqualToString:call.method]){
      NSDictionary *dict = call.arguments;
      NSString *classify = dict[@"classify"];

      InsertView *insertView = [self.insertDict objectForKey:classify];
      if(insertView != NULL){
          [insertView showInsert];
          result([NSNumber numberWithBool:true]);
      } else{
          result([NSNumber numberWithBool:false]);
      }
  } else {
      result(FlutterMethodNotImplemented);
  }
}




@end
