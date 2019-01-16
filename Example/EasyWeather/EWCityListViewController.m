//
//  EWCityListViewController.m
//  EasyWeather_Example
//
//  Created by Ethan Guo on 2019/1/16.
//  Copyright © 2019年 Ethan89. All rights reserved.
//

#import "EWCityListViewController.h"
#import "EWWeatherViewController.h"

#import <Masonry/Masonry.h>

static NSString *const cityCellId = @"kCityCellId";

@interface EWCityListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cityArray;

@end

@implementation EWCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
    [self layoutViews];
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
    self.title = @"DEMO";
    [self.view addSubview:self.tableView];
}

- (void)layoutViews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellId forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.cityArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cityName = [self.cityArray objectAtIndex:indexPath.row];
    
    EWWeatherViewController *next = [[EWWeatherViewController alloc] init];
    next.cityName = cityName;
    [self.navigationController pushViewController:next animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight = 45.f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCellId];
    }
    return _tableView;
}

- (NSArray *)cityArray {
    if (!_cityArray) {
        _cityArray = @[@"北京", @"上海", @"重庆", @"天津",
                       @"南京", @"广州", @"杭州", @"深圳",
                       @"苏州", @"宁波", @"沈阳", @"哈尔滨",
                       @"兰州", @"马鞍山", @"常州", @"镇江"];
    }
    return _cityArray;
}

@end
