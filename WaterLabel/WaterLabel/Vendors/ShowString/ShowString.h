//
//  ShowString.h
//  Xitu
//
//  Created by SGJ on 16/1/31.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowString : NSObject
/** 仿MBP */
+ (ShowString *)sharedManager;
- (void)showStringView:(NSString *)str;

@end
