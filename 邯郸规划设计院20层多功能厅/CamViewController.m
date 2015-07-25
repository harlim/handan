//
//  CamViewController.m
//  邯郸规划设计院20层多功能厅
//
//  Created by wharlim on 15/7/25.
//  Copyright (c) 2015年 wharlim. All rights reserved.
//

#import "CamViewController.h"
#import "AppDelegate.h"

@interface CamViewController ()

@end

@implementation CamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIView *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = 5.0f;
            btn.layer.masksToBounds = YES;
            [(UIButton *)btn addTarget:self action:@selector(cam1PanSendCom:) forControlEvents:UIControlEventTouchDown];    //按下事件
            [(UIButton *)btn addTarget:self action:@selector(cam1PanSendComStop:) forControlEvents:UIControlEventTouchUpInside];
            [(UIButton *)btn addTarget:self action:@selector(cam1PanSendComStop:) forControlEvents:UIControlEventTouchUpOutside];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cam1PanSendCom:(UIButton *)sender {
    [[AppDelegate app] sendCom:[NSString stringWithFormat:@"B%ld",sender.tag]];
}

- (IBAction)cam1PanSendComStop:(UIButton *)sender {
    [[AppDelegate app] sendCom:[NSString stringWithFormat:@"B%ld",sender.tag + 10]];
}

@end
