//
//  EWTest.m
//  EasyWeather
//
//  Created by Ethan Guo on 2019/1/9.
//

#import "EasyWeatherTest.h"
#import "EasyWeather.h"

@implementation EasyWeatherTest

- (void)testFunc {
    @try {
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        EasyWeather *easyWeather = [[EasyWeather alloc] init];
        NSArray *cityArray = [easyWeather getCityList];
        CFAbsoluteTime time = (CFAbsoluteTimeGetCurrent() - startTime);
        NSLog(@"读取城市列表 in %f ms", time *1000.0);
        
        NSArray *cityNames = @[@"无锡", @"南京", @"上海", @"苏州", @"宁波",
                               @"马鞍山", @"日照", @"沈阳", @"呼和浩特", @"乌鲁木齐", @"济南"];
        
        for (NSString *cityName in cityNames) {
            startTime = CFAbsoluteTimeGetCurrent();
            EWCityModel *city = [easyWeather cityModelWithName:cityName];
            time = (CFAbsoluteTimeGetCurrent() - startTime);
            NSLog(@"查找%@所用时间 in %f ms, 查找结果: %@", cityName, time * 1000.0, city.cityCode);
        }
        
        EWCityModel *wuxi = [easyWeather cityModelWithName:@"上海1"];
        [easyWeather requestWeatherInfoWithCity:wuxi completion:^(NSError *error, NSDictionary *result) {
            if (!error) {
                NSLog(@"请求成功");
            } else {
                NSLog(@"ErrorCode: %ld, ErrorMessage: %@", error.code, error.localizedDescription);
            }
        }];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    }
}

- (int)getRandomNumber:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

@end
