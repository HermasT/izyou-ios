//
//  homePageViewController.m
//  CardPlay
//
//  Created by wudi on 1/8/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "homePageViewController.h"

@interface homePageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation homePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_imgView setImageWithURL:[NSURL URLWithString:@"http://www.uimaker.com/uploads/allimg/120801/1_120801005405_1.png"]];
    CTHTTPClient *client = [CTHTTPClient client];
    [client asyncJSONRequest:[CTHttpClientUtil URLRequestForSOAGet:[NSURL URLWithString:@"http://im.ctrip.com:5280/api/archive/13207174729"] parameters:nil] timeout:5 success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject) {
            
        }
        
    } faild:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    
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

@end
