//
//  MbEventPlugin.h
//  mbads
//
//  Created by 吴奶强 on 2021/11/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface MbEventPlugin : NSObject

+(instancetype)shareInstanceEventPlugin;

-(void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;

-(void)sendEvent:(NSDictionary* )event;

@end

NS_ASSUME_NONNULL_END
