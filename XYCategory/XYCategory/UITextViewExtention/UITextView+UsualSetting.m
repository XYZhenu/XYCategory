//
//  UITextView+UsualSetting.m
//  XYCategories
//
//  Created by xieyan on 2017/6/5.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UITextView+UsualSetting.h"

@implementation UITextView (UsualSetting)
- (void)setUsualSetting:(BOOL)usualSetting {
    self.autocorrectionType = usualSetting ? UITextAutocorrectionTypeNo : UITextAutocorrectionTypeDefault;//自动纠错 关闭
    self.autocapitalizationType = usualSetting ? UITextAutocapitalizationTypeNone : UITextAutocapitalizationTypeSentences;// 首写字母大写  关闭
}
-(BOOL)usualSetting {
    return NO;
}
@end
