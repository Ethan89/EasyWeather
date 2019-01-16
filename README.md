# EasyWeather

[![CI Status](https://img.shields.io/travis/Ethan89/EasyWeather.svg?style=flat)](https://travis-ci.org/Ethan89/EasyWeather)
[![Version](https://img.shields.io/cocoapods/v/EasyWeather.svg?style=flat)](https://cocoapods.org/pods/EasyWeather)
[![License](https://img.shields.io/cocoapods/l/EasyWeather.svg?style=flat)](https://cocoapods.org/pods/EasyWeather)
[![Platform](https://img.shields.io/cocoapods/p/EasyWeather.svg?style=flat)](https://cocoapods.org/pods/EasyWeather)

[中文](https://github.com/Ethan89/EasyWeather/blob/master/README-zh.md)

## Installation

EasyWeather is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyWeather'
```

## Features

* Get the weather of the day.
* Get the weather forecast for the next three days.
* Check sunrise, sunset, maximum temperature, minimum temperature, air index, wind power, wind direction, weather.
* The network cache is valid for 300 seconds.

## Usage

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

## Author

Ethan89, yaofeng.guo@gmail.com

## Thanks

[soゝso](https://www.sojson.com/blog/305.html)

## License

EasyWeather is available under the MIT license. See the LICENSE file for more info.


