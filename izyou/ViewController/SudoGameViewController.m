//
//  SudoGameViewController.m
//  izyou
//
//  Created by wudi on 2/10/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "SudoGameViewController.h"
#import "SudoGameView.h"

@interface SudoGameViewController ()<SudoGameViewDelegate>
@property(nonatomic,strong)SudoGameView *sudoView;

@end

@implementation SudoGameViewController

- (instancetype)initWithLineNum:(NSInteger)lineNum{
    self = [super init];
    if (self) {
        _sudoView = [[SudoGameView alloc] initWithCellWidth:(izyScreenWidth - 60)/lineNum lineNum:lineNum];
        CGRect frame = _sudoView.frame;
        frame.origin.x = 60;
        frame.origin.y = 60;
        _sudoView.frame = frame;
        _sudoView.delegate = self;
        [self.view addSubview:_sudoView];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma mark delegate
- (void)sudoCellTouchUpInside:(UIButton *)sender{
    sender.backgroundColor = [UIColor redColor];
}

@end
