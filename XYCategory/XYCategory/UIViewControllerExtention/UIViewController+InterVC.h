//
//  UIViewController+InterVC.h
//  XYCategory
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface UIStoryboard (XYInterVC)
+ (void)registClasses:(NSArray<NSString*>*)classnames inIB:(NSString*)ibName;
+ (void)registClass:(Class)classname inIB:(NSString*)ibName;
+ (UIViewController*)instantiateVC:(Class)classname;
@end

extern NSString* const keyVCTitle;
extern NSString* const keyVCMessage;

@interface UIViewController (XYInterVC)
@property(nonatomic,strong,nullable) NSDictionary<NSString*,id>* parma;
@property(nonatomic,strong,nullable)void(^callback)(NSDictionary<NSString*,id>* _Nullable message);
-(void)pushClass:(Class)cls parma:(NSDictionary<NSString*, id>* _Nullable)parma callBack:(void(^_Nullable)(NSDictionary<NSString*, id>* _Nullable message))callBack;

-(void)pop;
-(void)popDouble;
-(void)pop:(int)num;

@end
NS_ASSUME_NONNULL_END;
