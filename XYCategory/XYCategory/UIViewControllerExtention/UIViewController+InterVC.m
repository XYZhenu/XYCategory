//
//  UIViewController+InterVC.m
//  XYCategory
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIViewController+InterVC.h"
NSString* const keyVCTitle = @"vctitle";
NSString* const keyVCMessage = @"vcmessage";
NSString* const keyVCUrl = @"vcurl";
@implementation UIStoryboard (XYInterVC)
static NSMutableDictionary* ibs = nil;
static NSMutableDictionary* storys = nil;
+ (void)registClasses:(NSArray*)classnames inIB:(NSString*)ibName {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ibs = [NSMutableDictionary new];
        storys = [NSMutableDictionary new];
    });
    if (ibName && [ibName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0) {
        if (!storys[ibName]) {
            UIStoryboard*story = [UIStoryboard storyboardWithName:ibName bundle:[NSBundle mainBundle]];
            if (story) {
                storys[ibName] = story;
            }
        }
    }
    if (!storys[ibName]) {
        [NSException raise:@"ErrorStoryBoardName" format:@"can not find storyboard named %@",ibName];
        return;
    }else{
        for (NSString* classname in classnames) {
            if (![NSClassFromString(classname) isSubclassOfClass:[UIViewController class]]) {
                [NSException raise:@"ErrorClassRegistered" format:@"class %@ is not UIViewController class",classname];
                continue;
            }
            NSString* ident = [classname componentsSeparatedByString:@"."].lastObject;
            ibs[ident] = ibName;
        }
    }
    
}
+ (void)registClass:(Class)classname inIB:(NSString*)ibName {
    [self registClasses:@[NSStringFromClass(classname)] inIB:ibName];
}
+ (UIViewController*)instantiateVC:(Class)classname {
    NSString* identi = NSStringFromClass(classname);
    if (![classname isSubclassOfClass:[UIViewController class]]) {
        [NSException raise:@"ErrorClassRegistered" format:@"class %@ is not UIViewController class",identi];
        return nil;
    }
    identi = [identi componentsSeparatedByString:@"."].lastObject;
    NSString* storykey = ibs[identi];
    UIViewController* vc = nil;
    if (storykey) {
        UIStoryboard*story = storys[storykey];
        if (story) {
            vc = [story instantiateViewControllerWithIdentifier:identi];
        }
    }
    if (!vc) {
        vc = [classname new];
        NSLog(@"class %@ not found in storyboards already registered",NSStringFromClass(classname));
    }
    return vc;
}

@end
#import <objc/runtime.h>
@implementation UIViewController (XYInterVC)
static char parmakey;
-(void)setParma:(NSDictionary*)parma{
    objc_setAssociatedObject(self, &parmakey, parma, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//相关对象强应用
}
-(NSDictionary*)parma{
    return objc_getAssociatedObject(self, &parmakey);
}
static char callBackKey;
-(void)setCallback:(void (^)(NSDictionary<NSString*, id>*))callback{
    objc_setAssociatedObject(self, &callBackKey, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void (^)(NSDictionary<NSString*, id>*))callback{
    return objc_getAssociatedObject(self, &callBackKey);
}

-(void)pushClass:(Class)cls parma:(NSDictionary<NSString*, id>*)parma callBack:(void(^)(NSDictionary<NSString*, id>* message))callBack{
    UIViewController* obj = [UIStoryboard instantiateVC:cls];
    obj.callback = callBack;
    obj.parma = parma;
    if (parma && parma[keyVCTitle]) {
        obj.title = parma[keyVCTitle];
    }
    [self.navigationController pushViewController:obj animated:YES];
}

-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popDouble{
    [self pop:2];
}
-(void)pop:(int)num{
    NSArray* array = self.navigationController.viewControllers;
    if (array.count==0) {
        return;
    }
    UIViewController* vc;
    if (array.count>num) {
        vc = array[array.count-num-1];
    }else{
        vc = array[0];
    }
    [self.navigationController popToViewController:vc animated:YES];
}
- (UIViewController* _Nullable)previousVC:(NSInteger)indexFromBack{
    NSArray* array = self.navigationController.viewControllers;
    if (array && array.count>indexFromBack) {
        return array[array.count-indexFromBack-1];
    }
    return nil;
}
@end
