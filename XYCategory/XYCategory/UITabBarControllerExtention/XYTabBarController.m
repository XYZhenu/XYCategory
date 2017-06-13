//
//  XYTabBarController.m
//  XYCategories
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "XYTabBarController.h"

@interface XYTabBarController ()

@end

@implementation XYTabBarController
-(BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}
@end
