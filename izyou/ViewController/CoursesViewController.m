//
//  CoursesViewController.m
//  izyou
//
//  Created by wudi on 1/19/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "CoursesViewController.h"
#import "LoginViewController.h"

@interface CoursesViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segetmentControl;
/**
 *  每个section中row的数据源，是个二维数组
 */
@property (strong, nonatomic) NSArray *roWDataArray;

@end

static NSString *cellIdentifier = @"cell";

@implementation CoursesViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    self.title = @"课程";
    self.navigationController.navigationBar.translucent = NO;
    [self setupRightBarItem];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_segetmentControl addTarget:self action:@selector(segmentControlClicked:) forControlEvents:UIControlEventValueChanged];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UI

- (void)setupRightBarItem{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"+" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBarButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:buttonItem];
}


- (void)setupTableView{
    _roWDataArray = @[@"桥牌一",@"桥牌二",@"桥牌三",@"桥牌四"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}


#pragma mark action

- (void)rightBarButtonClicked{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (void)segmentControlClicked:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 1) {
        _roWDataArray = @[@"数独一",@"数独二",@"数独三",@"数独四"];
        [_tableView reloadData];
    }
    else{
        _roWDataArray = @[@"桥牌一",@"桥牌二",@"桥牌三",@"桥牌四"];
        [_tableView reloadData];
    }
}

#pragma mark datasource &delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _roWDataArray.count;
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
