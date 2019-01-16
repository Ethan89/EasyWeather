//
//  EWWeatherInfoModel.h
//  EasyWeather_Example
//
//  Created by Ethan Guo on 2019/1/16.
//  Copyright © 2019年 Ethan89. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWWeatherInfoModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;

- (instancetype)initWithTitle:(NSString *)title
                        value:(NSString *)value;

@end
