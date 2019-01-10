//
//  EWViewController.m
//  EasyWeather
//
//  Created by Ethan89 on 01/09/2019.
//  Copyright (c) 2019 Ethan89. All rights reserved.
//

#import "EWViewController.h"
#import <EasyWeather/EasyWeatherTest.h>

@interface EWViewController ()

@end

@implementation EWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    EasyWeatherTest *test = [[EasyWeatherTest alloc] init];
    [test testFunc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
