//
//  UIAlertController+Convience.m
//  Video
//
//  Created by xieyan on 2017/2/5.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "UIAlertController+Convience.h"

@implementation UIAlertController (XYConvience)
- (UIAlertAction *)actionTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)( UIAlertAction * action))handler{
    UIAlertAction* action = [UIAlertAction actionWithTitle:title style:style handler:handler];
    [self addAction:action];
    return action;
}
@end

@implementation UIViewController (XYAlert)

- (UIAlertController *)alertMsg:( NSString *)msg cancel:(void(^)())cancel{
    return [self alertMsg:msg cancel:cancel confirm:nil];
}
- (UIAlertController *)alertMsg:( NSString *)msg confirm:(void(^)())confirm{
    return [self alertMsg:msg cancel:nil confirm:confirm];
}
- (UIAlertController *)alertMsg:( NSString *)msg cancel:(void(^)())cancel confirm:(void(^)())confirm{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    if (cancel) {
        [alert actionTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            cancel();
        }];
    }
    if (confirm) {
        [alert actionTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            confirm();
        }];
    }
    [self presentViewController:alert animated:YES completion:nil];
    return alert;
}


@end


@implementation UIViewController (XYSheet)

-(UIAlertController *)sheetMsg:(id)msg title:(NSString *)title cancel:(void (^)())cancel confirm:(void (^)(NSInteger indexs))confirm{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:title preferredStyle:UIAlertControllerStyleActionSheet];
    if (cancel) {
        [alert actionTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            cancel();
        }];
    }
    
    if ([msg isKindOfClass:[NSString class]]) {
        [alert actionTitle:msg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            confirm(-1);
        }];
    }
    if ([msg isKindOfClass:[NSArray class]]) {
        for (NSInteger index = 0; index<[msg count]; index++) {
            [alert actionTitle:msg[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                confirm(index);
            }];
        }
    }
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
    return alert;
}

@end
