//
//  AdItem.h
//  fluttertoast
//
//  Created by 吴奶强 on 2021/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdItem : NSObject

//代码位
@property(nonatomic,copy)NSString *codeNo;
//ios 代码位
@property(nonatomic,copy)NSString *iosCodeNo;

//平台
@property(nonatomic,assign)NSInteger plat;

@end

NS_ASSUME_NONNULL_END
