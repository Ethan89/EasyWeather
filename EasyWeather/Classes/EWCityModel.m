//
//  EWCityModel.m
//  EasyWeather
//
//  Created by Ethan Guo on 2019/1/10.
//

#import "EWCityModel.h"

@implementation EWCityModel

- (EWCityModel *)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        self.ID = [dict[@"id"] integerValue];
        self.cityName = dict[@"city_name"];
        self.cityCode = dict[@"city_code"];
        self.pid = [dict[@"pid"] integerValue];
    }
    
    return self;
}

@end
