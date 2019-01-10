//
//  EasyWeather.m
//  EasyWeather
//
//  Created by Ethan Guo on 2019/1/10.
//

#import "EasyWeather.h"
#import "EWExceptionDefine.h"

@implementation EasyWeather

- (NSURL *)resourceBundleURL {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [bundle URLForResource:@"EasyWeather" withExtension:@"bundle"];
}

- (NSBundle *)resourceBundle {
    return [NSBundle bundleWithURL:[self resourceBundleURL]];
}

- (NSArray *)getCityList {
    NSBundle *resourceBundle = [self resourceBundle];
    NSString *cityFilePath = [resourceBundle pathForResource:@"city" ofType:@"json"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cityFilePath]) {
        @throw [NSException exceptionWithName:EasyWeather_CityFileUnavailable
                                       reason:@"城市列表文件不可用"
                                     userInfo:nil];
    }
    
    NSData *data = [NSData dataWithContentsOfFile:cityFilePath];
    
    NSError *err = nil;
    NSArray *cityArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&err];
    
    if (err) {
        @throw [NSException exceptionWithName:EasyWeather_CityListSerialization
                                       reason:@"城市列表序列号失败"
                                     userInfo:nil];
    }
    
    return cityArray;
}

- (EWCityModel *)cityModelWithName:(NSString *)cityName {
    EWCityModel *city = nil;
    
    @try {
        NSArray *cityList = [self getCityList];
        
        if (cityName && cityName.length > 0) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"city_name=%@", cityName];
            NSArray *result = [cityList filteredArrayUsingPredicate:pred];
            if (result.count == 1) {
                city = [[EWCityModel alloc] initWithDictionary:result[0]];
            }
        }
    } @catch (NSException *e) {
        @throw e;
    }
    
    return city;
}

- (void)requestWeatherInfoWithCity:(EWCityModel *)cityModel
                        completion:(void (^)(NSError *, NSDictionary *))completion {
    if (!cityModel || !cityModel.cityCode || cityModel.cityCode.length == 0) {
        NSError *err = [NSError errorWithDomain:@"EasyWeather.CityInfoError" code:0 userInfo:@{NSLocalizedDescriptionKey: @"城市信息错误"}];
        if (completion) {
            completion(err, nil);
        }
    }
    
    NSString *url = @"http://t.weather.sojson.com/api/weather/city/";
    url = [url stringByAppendingString:cityModel.cityCode];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:120.0];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        if (completion) {
                                                            completion(error, nil);
                                                        }
                                                    } else {
                                                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                                                        NSInteger status = [dict[@"status"] integerValue];
                                                        if (status == 200) {
                                                            if (completion) {
                                                                completion(nil, dict[@"data"]);
                                                            }
                                                        } else {
                                                            NSError *err = [NSError errorWithDomain:@"EasyWeather.responseError"
                                                                                               code:[dict[@"status"] integerValue]
                                                                                           userInfo:@{NSLocalizedDescriptionKey: dict[@"message"]}];
                                                            if (completion) {
                                                                completion(err, nil);
                                                            }
                                                        }
                                                    }
                                                }];
    [dataTask resume];
}

@end
