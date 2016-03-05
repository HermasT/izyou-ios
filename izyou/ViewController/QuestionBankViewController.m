//
//  QuestionBankViewController.m
//  izyou
//
//  Created by wudi on 1/19/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "QuestionBankViewController.h"

@interface QuestionBankViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *roWDataArray;
@property (strong, nonatomic) NSArray *sectionArray;

@end

static NSString *cellIdentifier = @"cell";

@implementation QuestionBankViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"题库";
    [self setupRightBarItem];
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


- (void)setupRightBarItem{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:buttonItem];
}

- (void)setupTableView{
    _sectionArray = @[@"桥牌题目",@"数独题目"];
    _roWDataArray = @[@"桥牌一",@"桥牌二",@"桥牌三",@"桥牌四"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}


- (void)rightBarButtonClicked{
    
}

#pragma mark delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 100, 30)];
    label.text = [_sectionArray objectAtIndex:section];
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [self configureCell:cell withIndexPath:indexPath];
    return cell;
}

#pragma mark private
- (void)configureCell:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [_roWDataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = indexPath.row %2 ? [UIColor lightGrayColor] : [UIColor whiteColor];
    
}



@end
