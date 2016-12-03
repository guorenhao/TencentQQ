//
//  ViewController.m
//  TencentQQ
//
//  Created by 郭人豪 on 2016/12/3.
//  Copyright © 2016年 Abner_G. All rights reserved.
//

#import "ViewController.h"
#import "QQFriendCell.h"

#define Cell_QQFriend   @"Cell_QQFriend_ID"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * sectionArr;
@property (nonatomic, strong) NSMutableArray * boolArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友列表";
    [self loadData];
    [self addSubviews];
    [self makeConstraintsForUI];
}

//加载数据
- (void)loadData {
    
    NSArray * secArr = @[@"我的好友", @"小学同学", @"初中同学", @"高中同学", @"大学同学"];
    NSArray * rowsArr = @[@(12), @(10), @(15), @(13), @(22)];
    
    for (int i = 0; i < secArr.count; i++) {
        
        NSMutableArray * friendArr = [[NSMutableArray alloc] init];
        for (int j = 0; j < [rowsArr[i] intValue]; j++) {
            
            [friendArr addObject:@(j)];
        }
        [self.dataArr addObject:friendArr];
        [self.sectionArr addObject:secArr[i]];
        [self.boolArr addObject:@NO];
    }
}

#pragma mark - add subviews

- (void)addSubviews {
    
    [self.view addSubview:self.tableView];
}

#pragma mark - make constraints

- (void)makeConstraintsForUI {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(@0);
    }];
}

#pragma mark - tableView delegate and dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.boolArr[section] boolValue] == NO) {
        
        return 0;
    }else {
        
        return [self.dataArr[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:Cell_QQFriend forIndexPath:indexPath];
    
    if (indexPath.row < [self.dataArr[indexPath.section] count]) {
        
        [cell configCellWithData:nil row:indexPath.row];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //创建header的view
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    headerView.tag = 2016 + section;
    headerView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    //添加imageview
    UIImageView * iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    
    //三目运算选择展开或者闭合时候的图标
    iv.image = [_boolArr[section] boolValue] ? [UIImage imageNamed:@"buddy_header_arrow_down"] : [UIImage imageNamed:@"buddy_header_arrow_right"];
    [headerView addSubview:iv];
    
    //添加标题label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, self.view.frame.size.width - 100, 50)];
    label.text = self.sectionArr[section];
    [headerView addSubview:label];
    
    //添加分组人数和在线人数显示的label
    UILabel * labelR = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, 0, 60, 50)];
    labelR.textAlignment = NSTextAlignmentCenter;
    labelR.text = [NSString stringWithFormat:@"%d/%lu", 0, [self.dataArr[section] count]];
    [headerView addSubview:labelR];
    
    //添加轻扣手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGR:)];
    [headerView addGestureRecognizer:tap];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

#pragma mark - action
- (void)tapGR:(UITapGestureRecognizer *)tapGR {
    
    //获取section
    NSInteger section = tapGR.view.tag - 2016;
    //判断改变bool值
    if ([_boolArr[section] boolValue] == YES) {
        [_boolArr replaceObjectAtIndex:section withObject:@NO];
    }else {
        [_boolArr replaceObjectAtIndex:section withObject:@YES];
    }
    //刷新某个section
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[QQFriendCell class] forCellReuseIdentifier:Cell_QQFriend];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)sectionArr {
    
    if (!_sectionArr) {
        
        _sectionArr = [[NSMutableArray alloc] init];
    }
    return _sectionArr;
}

- (NSMutableArray *)boolArr {
    
    if (!_boolArr) {
        
        _boolArr = [[NSMutableArray alloc] init];
    }
    return _boolArr;
}

@end
