//
//  EWCityModel.h
//  EasyWeather
//
//  Created by Ethan Guo on 2019/1/10.
//

#import <Foundation/Foundation.h>

@interface EWCityModel : NSObject

/**
 城市ID e.g. 1
 */
@property (nonatomic, assign) NSInteger ID;
/**
 城市名称 e.g. 北京
 */
@property (nonatomic, copy) NSString *cityName;
/**
 城市编码 查询天气使用城市编码
 e.g. 101010100
 */
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, assign) NSInteger pid;

- (EWCityModel *)initWithDictionary:(NSDictionary *)dict;

@end
