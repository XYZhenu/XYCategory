//
//  LocationManager.h
//  qunyao
//
//  Created by xieyan on 16/4/29.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kLocationManager  [LocationManager Instance]
@interface LocationManager : NSObject
+(instancetype)Instance;
@property(nonatomic,assign)CLLocation *location;
@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;
-(void)updateOnce:(BOOL)once;
@end
