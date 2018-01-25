//
//  XYRemotePush.m
//  shell
//
//  Created by xyzhenu on 2016/11/1.
//  Copyright © 2016年 xieyan. All rights reserved.
//
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#import "XYRemotePush.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
@interface XYRemotePush ()<UNUserNotificationCenterDelegate>{
    NSMutableDictionary* _handlerDic;
    NSUInteger _pushOption;
}
@property (nonatomic,strong)void(^pushtokenBlock)(NSString* token,NSData* tokenData);
@property (nonatomic,strong)NSData* pushTokenData;
@end
@implementation XYRemotePush
@synthesize pushToken = _pushToken;
+ (instancetype)Instance{
    static XYRemotePush* pushManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pushManager = [[self alloc] init];
    });
    return pushManager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _handlerDic = @{}.mutableCopy;
    }
    return self;
}

-(BOOL)isActive{ return  [[UIApplication sharedApplication] isRegisteredForRemoteNotifications]; }

- (void)closeAPNs{ [[UIApplication sharedApplication] unregisterForRemoteNotifications]; }
- (void)openAPNs_Badge:(BOOL)openBadge Sound:(BOOL)openSound Alert:(BOOL)openAlert{
    UIApplication* app = [UIApplication sharedApplication];
    NSUInteger option = 0;
    if (openBadge) {option|=1<<0;}
    if (openSound) {option|=1<<1;}
    if (openAlert) {option|=1<<2;}
    _pushOption = option;
    if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:option completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error && granted){
                [app registerForRemoteNotifications];
            }
        }];
    }else if (SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"8.0")){
        [app registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:option categories:nil]];
    }
}

-(void)setPushToken:(NSString *)pushToken {
    _pushToken = pushToken;
    [[NSUserDefaults standardUserDefaults] setValue:pushToken forKey:@"RemotePushNotificationToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.pushtokenBlock) {
        self.pushtokenBlock(pushToken,self.pushTokenData);
    }
}
-(NSString *)pushToken {
    if (!_pushToken) {
        _pushToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"RemotePushNotificationToken"];
        if (!_pushToken) {
            _pushToken = @"";
        }
    }
    return _pushToken;
}
- (void)setPushTokenBlock:(void(^)(NSString* token,NSData* tokenData))block {
    self.pushtokenBlock = block;
}


- (void)registIdentifier:(NSString*)identifier Handler:(void(^)(NSDictionary* userInfo,UIApplicationState state))handler{
    NSAssert(nil != identifier, @"");
    NSAssert(nil != handler, @"");
    [_handlerDic setValue:handler forKey:identifier];
}
- (void)unregistIdentifier:(NSString*)identifier{
    NSAssert(nil != identifier, @"");
    [_handlerDic removeObjectForKey:identifier];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    return completionHandler(_pushOption);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler { // selected an notification
    NSLog(@"received notification \n%@",response.notification.request.content.userInfo);
    [self receivedUserInfo:response.notification.request.content.userInfo state:[UIApplication sharedApplication].applicationState];
    completionHandler();
}


- (void)receivedUserInfo:(NSDictionary*)userInfo state:(UIApplicationState)state{
    [_handlerDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        ((void(^)(NSDictionary*,UIApplicationState))obj)(userInfo,state);
    }];
}

@end

@implementation UIApplication (XYRemotePush)

- (void)loadRemotePush:(NSDictionary *)launchOptions {
    if (![[XYRemotePush Instance] isActive]) [[XYRemotePush Instance] openAPNs_Badge:YES Sound:YES Alert:YES];
    
    NSDictionary*userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[XYRemotePush Instance] receivedUserInfo:userInfo state:UIApplicationStateInactive];
            NSLog(@"received notification on lanuch \n%@",userInfo);
        });
    }
#ifdef DEBUG
    [[XYRemotePush Instance] registIdentifier:@"moniter" Handler:^(NSDictionary * _Nonnull userInfo,UIApplicationState state) {
        NSLog(@"received notification \n%@",userInfo);
    }];
#endif
}

@end


@interface UIResponder (XYRemotePush)

@end

@implementation UIResponder (XYRemotePush)
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString * token=[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]; //去掉"<>"
    token=[[token description] stringByReplacingOccurrencesOfString:@" " withString:@""]; //去掉中间空格
    [XYRemotePush Instance].pushTokenData = deviceToken;
    [XYRemotePush Instance].pushToken = token;
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"fail to register for remoteNotifications %@",error);
    [XYRemotePush Instance].pushTokenData = [NSData data];
    [XYRemotePush Instance].pushToken = @"";
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo { // - 10
//    will not be invoked if application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler implemented;
//    but that method also invoked when app resume or lanuched again;
//    NSLog(@"didReceiveRemoteNotification this method should not be invoked anymore");
    NSLog(@"received notification \n%@",userInfo);
    [[XYRemotePush Instance] receivedUserInfo:userInfo state:application.applicationState];
    
}


//if "remote-notification" background mode enabled，this should open
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler { // silent remote notifications + 7 launched or resumed
//    NSLog(@"received notification \n%@",userInfo);
//    [[XYRemotePush Instance] receivedUserInfo:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler { // 9 - 10 selected an notification
    NSLog(@"received notification \n%@",userInfo);
    [[XYRemotePush Instance] receivedUserInfo:userInfo state:application.applicationState];
    completionHandler();
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler { // 8 - 10 selected an notification
    NSLog(@"received notification \n%@",userInfo);
    [[XYRemotePush Instance] receivedUserInfo:userInfo state:application.applicationState];
    completionHandler();
}
@end
