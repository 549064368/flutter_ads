//
//  SplashFactory.h
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface SplashFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messager;

@end



NS_ASSUME_NONNULL_END
