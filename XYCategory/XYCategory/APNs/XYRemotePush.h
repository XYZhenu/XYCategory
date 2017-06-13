//
//  XYRemotePush.h
//  shell
//
//  Created by xyzhenu on 2016/11/1.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface XYRemotePush : NSObject
+ (instancetype)Instance;

@property(nonatomic, assign, readonly) BOOL isActive;

- (void)closeAPNs;
- (void)openAPNs_Badge:(BOOL)openBadge Sound:(BOOL)openSound Alert:(BOOL)openAlert;

@property(nonatomic, strong) NSString* pushToken;
- (void)setPushTokenBlock:(void(^)(NSString* token))block;

- (void)registIdentifier:(NSString*)identifier Handler:(void(^)(NSDictionary* userInfo,UIApplicationState state))handler;
- (void)unregistIdentifier:(NSString*)identifier;

- (void)receivedUserInfo:(NSDictionary*)userInfo state:(UIApplicationState)state;
@end

@interface UIApplication (XYRemotePush)
- (void)loadRemotePush:(NSDictionary *)launchOptions;
@end
NS_ASSUME_NONNULL_END;
