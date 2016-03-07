//
//  HomePageViewController.m
//  izyou
//
//  Created by wudi on 1/19/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "HomePageViewController.h"
#import "SudoGameViewController.h"
#import <SDCycleScrollView.h>

@interface HomePageViewController ()<SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet SDCycleScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *entraceCollectionView;
@end

static NSString *identifier = @"cell";
@implementation HomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"益智加";
    [self setupRightBarItem];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    
    _bannerScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 64, izyScreenWidth, 160)];
    [self.view addSubview:_bannerScrollView];
    _bannerScrollView.imageURLStringsGroup = imagesURLStrings;
    _bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _bannerScrollView.delegate = self;
    _bannerScrollView.titlesGroup = titles;
    _bannerScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    _entraceCollectionView.delegate = self;
    _entraceCollectionView.dataSource = self;
    _entraceCollectionView.backgroundColor = [UIColor clearColor];
    [_entraceCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    

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

#pragma mark action method
- (void)rightBarButtonClicked{
    
}

- (IBAction)playSudoGame:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:{
            SudoGameViewController *gameVC = [[SudoGameViewController alloc] initWithLineNum:6];
            [self.navigationController pushViewController:gameVC animated:YES];

  
        }
            break;
            
        default:{
            SudoGameViewController *gameVC = [[SudoGameViewController alloc] initWithLineNum:9];
            [self.navigationController pushViewController:gameVC animated:YES];
        }
            break;
    }
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [_entraceCollectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    CGRect frame = cell.frame;
    cell.frame = frame;
    
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((izyScreenWidth-30)/2, (izyScreenWidth-30)/2);
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%tu",indexPath.row);
}


@end
