//
//  MoreViewController.m
//  izyou
//
//  Created by wudi on 1/19/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "MoreViewController.h"
#import "UserInfoTableViewCell.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *roWDataArray;
@property (strong, nonatomic) NSArray *sectionArray;

@end

static NSString *cellIdentifier = @"cell";
static NSString *userInfocellIdentifier = @"userInfo";

static NSUInteger sectionHeight = 10.f;

@implementation MoreViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"更多";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupTableView{
    _sectionArray = @[@"",@"桥牌题目",@"数独题目",@""];
    _roWDataArray = @[@[@""],@[@"信息设置",@"关于版本",@"反馈意见"],@[@"版本更新",@"删除缓存"],@[@"退出登录"]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"UserInfoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:userInfocellIdentifier];
}

#pragma mark delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *rowInfo = [_roWDataArray objectAtIndex:section];
    return rowInfo.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, sectionHeight)];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return sectionHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [_tableView dequeueReusableCellWithIdentifier:userInfocellIdentifier];
    }
    else{
        cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

#pragma mark private
- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *rowInfo = [_roWDataArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [rowInfo objectAtIndex:indexPath.row];
}

@end
