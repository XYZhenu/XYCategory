//
//  LocationManager.m
//  qunyao
//
//  Created by xieyan on 16/4/29.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CLLocationManager.h>
@interface LocationManager ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager* locationManager;
@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,assign)BOOL shouldUpdateOnce;
@end
@implementation LocationManager
+(instancetype)Instance{
    static LocationManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LocationManager alloc] init];
    });
    return manager;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];

        _geocoder = [[CLGeocoder alloc] init];
        _locationManager.delegate = self;
        _shouldUpdateOnce = YES;
    }
    return self;
}
-(void)setLocation:(CLLocation *)location{
    [self willChangeValueForKey:@"location"];
    _location = location;
    self.longitude = _location.coordinate.longitude;
    self.latitude = _location.coordinate.latitude;
    [self didChangeValueForKey:@"location"];
}

-(void)updateOnce:(BOOL)once{
    self.shouldUpdateOnce = once;
    if ([CLLocationManager authorizationStatus]<3) {
//        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    NSLog(@"开始更新位置");
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    // 获取经纬度
    self.location = locations.lastObject;
    // 停止位置更新
    if (self.shouldUpdateOnce) {
        [manager stopUpdatingLocation];
        [self.geocoder reverseGeocodeLocation:self.location
                       completionHandler:^(NSArray *placemarks, NSError *error){
                           for (CLPlacemark *place in placemarks) {
                               NSLog(@"位置名,%@",place.name);                       // 位置名
//                               [self xyzPrint:@"街道,%@",place.thoroughfare];       // 街道
//                               [self xyzPrint:@"子街道,%@",place.subThoroughfare]; // 子街道
//                               [self xyzPrint:@"市,%@",place.locality];               // 市
//                               [self xyzPrint:@"区,%@",place.subLocality];         // 区
//                               [self xyzPrint:@"国家,%@",place.country];                 // 国家
                               self.city = [place.locality stringByReplacingOccurrencesOfString:@"市" withString:@""];
                               self.address=[NSString stringWithFormat:@"%@%@",place.locality,place.subLocality];

                           }
                       }];
    }else{
        NSLog(@"locationUpdate:%@",self.location.description);
    }
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationUpdateFailed:%@",error);
}
@end
