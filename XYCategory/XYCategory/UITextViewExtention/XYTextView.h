//
//  XYTextView.h
//  XYCategory
//
//  Created by xieyan on 2017/6/5.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE;
@interface XYTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy)IBInspectable NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong)IBInspectable UIColor *placeholderColor;
@end
