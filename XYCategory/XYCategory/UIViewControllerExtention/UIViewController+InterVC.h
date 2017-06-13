//
//  UIViewController+InterVC.h
//  XYCategories
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface UIStoryboard (XYInterVC)
+ (void)registClasses:(NSArray*)classnames inIB:(NSString*)ibName;
+ (void)registClass:(Class)classname inIB:(NSString*)ibName;
+ (UIViewController*)instantiateVC:(Class)classname;
@end

static NSString* keyVCTitle = @"vctitle";
static NSString* keyVCMessage = @"vcmessage";

@interface UIViewController (XYInterVC)
@property(nonatomic,strong,nullable) NSDictionary* parma;
@property(nonatomic,strong,nullable)void(^callback)(NSDictionary* _Nullable message);
-(void)pushClass:(Class)cls parma:(NSDictionary* _Nullable)parma callBack:(void(^_Nullable)(NSDictionary* _Nullable message))callBack;

-(void)pop;
-(void)popDouble;
-(void)pop:(int)num;

@end
NS_ASSUME_NONNULL_END;