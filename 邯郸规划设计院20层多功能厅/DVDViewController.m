//
//  DVDViewController.m
//  邯郸规划设计院20层多功能厅
//
//  Created by wharlim on 15/7/25.
//  Copyright (c) 2015年 wharlim. All rights reserved.
//

#import "DVDViewController.h"
#import "AppDelegate.h"

@interface DVDViewController ()

@end

@implementation DVDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIView *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = 5.0f;
            btn.layer.masksToBounds = YES;
            [(UIButton *)btn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(UIButton *)sender {
    NSLog(@"A%ld",sender.tag);
    [[AppDelegate app] sendCom:[NSString stringWithFormat:@"A%ld",sender.tag]];
}

@end
