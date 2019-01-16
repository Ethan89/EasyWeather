//
//  EWWeatherInfoModel.m
//  EasyWeather_Example
//
//  Created by Ethan Guo on 2019/1/16.
//  Copyright © 2019年 Ethan89. All rights reserved.
//

#import "EWWeatherInfoModel.h"

@implementation EWWeatherInfoModel

- (instancetype)initWithTitle:(NSString *)title
                        value:(NSString *)value {
    
    self = [super init];
    
    if (self) {
        self.title = title;
        self.value = value;
    }
    return self;
}

@end
