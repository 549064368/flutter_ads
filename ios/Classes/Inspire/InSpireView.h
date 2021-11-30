//
//  InSpireView.h
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/29.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>


NS_ASSUME_NONNULL_BEGIN

@interface InSpireView : NSObject


//- (instancetype)initWithArguments:(id _Nullable)args;

+(instancetype)shareInstanceInspire;

-(void)initData:(id _Nullable)args;

-(void)showInpire;

@end

NS_ASSUME_NONNULL_END
