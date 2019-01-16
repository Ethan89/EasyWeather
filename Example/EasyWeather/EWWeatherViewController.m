//
//  EWWeatherViewController.m
//  EasyWeather_Example
//
//  Created by Ethan Guo on 2019/1/16.
//  Copyright © 2019年 Ethan89. All rights reserved.
//

#import "EWWeatherViewController.h"
#import "EWWeatherInfoModel.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import <EasyWeather/EasyWeather.h>

static NSString *const cellId = @"kWeatherInfoCellId";

@interface EWWeatherViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSArray *> *dataSource;

@end

@implementation EWWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
    [self layoutViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private Method
- (void)setupViews {
    self.title = self.cityName;
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    
    [self.view addSubview:self.tableView];
}

- (void)layoutViews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupData {
    if (!self.cityName || self.cityName.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"城市名错误"];
        return;
    }
    
    
    EasyWeather *easyWeather = [[EasyWeather alloc] init];
    EWCityModel *cityModel = [easyWeather cityModelWithName:self.cityName];
    
    [SVProgressHUD show];
    __weak typeof(self) weakSelf = self;
    [easyWeather requestWeatherInfoWithCity:cityModel completion:^(NSError *error, NSDictionary *result) {
        __strong typeof(self) strongSelf = weakSelf;
        [SVProgressHUD dismiss];
        if (!error) {
            [strongSelf parseWeatherInfo:result];
        } else {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void)parseWeatherInfo:(NSDictionary *)responseDict {
    
    [self.dataSource removeAllObjects];
    
    // get city info
    NSDictionary *cityInfo = [responseDict objectForKey:@"cityInfo"];
    
    EWWeatherInfoModel *cityName = [[EWWeatherInfoModel alloc] initWithTitle:@"城市"
                                                                       value:cityInfo[@"city"]];
    EWWeatherInfoModel *cityId = [[EWWeatherInfoModel alloc] initWithTitle:@"城市编码"
                                                                       value:cityInfo[@"cityId"]];
    EWWeatherInfoModel *updateTime = [[EWWeatherInfoModel alloc] initWithTitle:@"更新时间"
                                                                         value:cityInfo[@"updateTime"]];
    EWWeatherInfoModel *parent = [[EWWeatherInfoModel alloc] initWithTitle:@"省份"
                                                                     value:cityInfo[@"parent"]];
    
    EWWeatherInfoModel *cityTitle = [[EWWeatherInfoModel alloc] initWithTitle:@"城市信息"
                                                                        value:@""];
    
    NSArray *cityInfoArray = @[cityTitle, cityName, cityId, updateTime, parent];
    [self.dataSource addObject:cityInfoArray];
    
    // get humidity
    EWWeatherInfoModel *humidity = [[EWWeatherInfoModel alloc] initWithTitle:@"湿度"
                                                                       value:responseDict[@"shidu"]];
    
    // get pm25
    EWWeatherInfoModel *pm25 = [[EWWeatherInfoModel alloc] initWithTitle:@"PM2.5"
                                                                   value:responseDict[@"pm25"]];
    
    // get pm10
    EWWeatherInfoModel *pm10 = [[EWWeatherInfoModel alloc] initWithTitle:@"PM10"
                                                                   value:responseDict[@"pm10"]];
    
    // get quality
    EWWeatherInfoModel *quality = [[EWWeatherInfoModel alloc] initWithTitle:@"空气质量"
                                                                      value:responseDict[@"quality"]];
    
    // get temperature
    NSString *tempString = [NSString stringWithFormat:@"%@℃", responseDict[@"wendu"]];
    EWWeatherInfoModel *temperature = [[EWWeatherInfoModel alloc] initWithTitle:@"温度"
                                                                          value:tempString];
    
    // get cold reminder
    EWWeatherInfoModel *coldReminder = [[EWWeatherInfoModel alloc] initWithTitle:@"感冒提醒"
                                                                           value:responseDict[@"ganmao"]];
    
    EWWeatherInfoModel *totalInfo = [[EWWeatherInfoModel alloc] initWithTitle:@"总览"
                                                                        value:@""];
    
    NSArray *totalInfoArray = @[totalInfo, humidity, pm25, pm10, quality, temperature, coldReminder];
    [self.dataSource addObject:totalInfoArray];
    
    // get yesterday weather info
    NSDictionary *yesterdayWeather = responseDict[@"yesterday"];
    [self.dataSource addObject:[self getWeatherInfoForDay:yesterdayWeather]];
    
    // get forecast
    NSArray *forecast = responseDict[@"forecast"];
    for (NSDictionary *dict in forecast) {
        [self.dataSource addObject:[self getWeatherInfoForDay:dict]];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSString *)cellContentWithInfo:(EWWeatherInfoModel *)model {
    return [NSString stringWithFormat:@"%@  %@", model.title, model.value];
}

- (NSArray *)getWeatherInfoForDay:(NSDictionary *)dict {
    // get day
    NSString *dayStr = [NSString stringWithFormat:@"%@日", dict[@"date"]];
    EWWeatherInfoModel *day = [[EWWeatherInfoModel alloc] initWithTitle:@"日期" value:dayStr];
    
    // get ymd
    EWWeatherInfoModel *ymd = [[EWWeatherInfoModel alloc] initWithTitle:@"年月日"
                                                                  value:dict[@"ymd"]];
    
    // get week
    EWWeatherInfoModel *week = [[EWWeatherInfoModel alloc] initWithTitle:@"星期"
                                                                   value:dict[@"week"]];
    
    // get sun rise
    EWWeatherInfoModel *sunRise = [[EWWeatherInfoModel alloc] initWithTitle:@"日出"
                                                                      value:dict[@"sunrise"]];
    
    // get sun set
    EWWeatherInfoModel *sunSet = [[EWWeatherInfoModel alloc] initWithTitle:@"日落"
                                                                     value:dict[@"sunset"]];
    
    // get high temperature
    EWWeatherInfoModel *high = [[EWWeatherInfoModel alloc] initWithTitle:@"最高温度"
                                                                   value:dict[@"high"]];
    
    // get low temperature
    EWWeatherInfoModel *low = [[EWWeatherInfoModel alloc] initWithTitle:@"最低温度"
                                                                  value:dict[@"low"]];
    
    // get aqi
    EWWeatherInfoModel *aqi = [[EWWeatherInfoModel alloc] initWithTitle:@"空气指数"
                                                                  value:dict[@"aqi"]];
    
    // get wind direction
    EWWeatherInfoModel *fx = [[EWWeatherInfoModel alloc] initWithTitle:@"风向"
                                                                 value:dict[@"fx"]];
    
    // get wind power
    EWWeatherInfoModel *fl = [[EWWeatherInfoModel alloc] initWithTitle:@"风力"
                                                                 value:dict[@"fl"]];
    
    // get weather type
    EWWeatherInfoModel *type = [[EWWeatherInfoModel alloc] initWithTitle:@"天气"
                                                                   value:dict[@"type"]];
    
    // get notice
    EWWeatherInfoModel *notice = [[EWWeatherInfoModel alloc] initWithTitle:@"天气描述"
                                                                     value:dict[@"notice"]];
    
    return @[day, ymd, week, sunRise, sunSet, high, low, aqi, fx, fl, type, notice];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource objectAtIndex:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    EWWeatherInfoModel *model = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = [self cellContentWithInfo:model];
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.rowHeight = 44.f;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        _tableView.tableFooterView = [[UIView alloc] init];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray<NSArray *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray<NSArray *> arrayWithCapacity:0];
    }
    return _dataSource;
}
@end
