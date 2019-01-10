//
//  EasyWeather.h
//  EasyWeather
//
//  Created by Ethan Guo on 2019/1/10.
//

#import <Foundation/Foundation.h>
#import "EWCityModel.h"

@interface EasyWeather : NSObject

/**
 获取EasyWeather资源包URL

 @return 返回EasyWeather资源包URL
 */
- (NSURL *)resourceBundleURL;

/**
 获取EasyWeather资源包

 @return 返回EasyWeather资源包
 */
- (NSBundle *)resourceBundle;

/**
 获取城市列表数据

 @return NSArray
 */
- (NSArray *)getCityList;

/**
 根据城市名查询获得对应的EWCityModel

 @param cityName 城市名称
 @return 返回EWCityModel
 */
- (EWCityModel *)cityModelWithName:(NSString *)cityName;

/**
 根据城市查询天气

 @param cityModel EWCityModel
 */
- (void)requestWeatherInfoWithCity:(EWCityModel *)cityModel
                        completion:(void(^)(NSError *error, NSDictionary *result))completion;
@end
