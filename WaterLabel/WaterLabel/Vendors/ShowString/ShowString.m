//
//  ShowString.m
//  Xitu
//
//  Created by SGJ on 16/1/31.
//  Copyright © 2016年 huchunyuan. All rights reserved.
//

#import "ShowString.h"
#import "KLCPopup.h"

@implementation ShowString

+(ShowString *)sharedManager
{
    static ShowString *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[ShowString alloc]init];
    });
    return sharedManager;
}
- (void)showStringView:(NSString *)str {
    [KLCPopup dismissAllPopups];
    
    CGFloat width = [self widthForString:str fontSize:17.0];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width + 80, 50)];
    label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 6;
    label.layer.masksToBounds = YES;
    label.numberOfLines = 0;
    label.text = str;
    KLCPopup *view = [KLCPopup popupWithContentView:label showType:(KLCPopupShowTypeFadeIn) dismissType:(KLCPopupDismissTypeFadeOut) maskType:(KLCPopupMaskTypeNone) dismissOnBackgroundTouch:NO dismissOnContentTouch:YES];
    [view showWithDuration:0.5];
}

- (float)widthForString:(NSString *)value fontSize:(float)fontSize{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [value boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return  size.width;
}

@end
