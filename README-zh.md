# EasyWeather

[![CI Status](https://img.shields.io/travis/Ethan89/EasyWeather.svg?style=flat)](https://travis-ci.org/Ethan89/EasyWeather)
[![Version](https://img.shields.io/cocoapods/v/EasyWeather.svg?style=flat)](https://cocoapods.org/pods/EasyWeather)
[![License](https://img.shields.io/cocoapods/l/EasyWeather.svg?style=flat)](https://cocoapods.org/pods/EasyWeather)
[![Platform](https://img.shields.io/cocoapods/p/EasyWeather.svg?style=flat)](https://cocoapods.org/pods/EasyWeather)

## 安装

通过Cocoapods来安装

```ruby
pod 'EasyWeather'
```

## 功能

* 查询当天天气。
* 查询未来三天的天气预报。
* 能够获取到的天气信息有：日出、日落、空气指数、最低（最高）气温、风力、风向、天气、温度、湿度、PM2.5、PM10、空气质量、感冒指数
* 网络请求缓存有效期为300秒

## 使用方法

```Objc
#import <EasyWeather/EasyWeather.h>

...

NSString *cityName = @"上海";
EasyWeather *easyWeather = [[EasyWeather alloc] init];
EWCityModel *cityModel = [easyWeather cityModelWithName:cityName];

[easyWeather requestWeatherInfoWithCity:cityModel completion:^(NSError *error, NSDictionary *result) {
    if (!error) {
        // get weather info from result
    } else {
        NSLog(@"ERROR: %@", error.localizedDescription);
        // get error info
    }
}];
```

## 作者

Ethan89, yaofeng.guo@gmail.com

## 感谢

[soゝso](https://www.sojson.com/blog/305.html)

## License

EasyWeather is available under the MIT license. See the LICENSE file for more info.


