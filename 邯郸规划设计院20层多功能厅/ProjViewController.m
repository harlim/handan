//
//  ProjViewController.m
//  邯郸规划设计院20层多功能厅
//
//  Created by wharlim on 15/7/25.
//  Copyright (c) 2015年 wharlim. All rights reserved.
//

#import "ProjViewController.h"
#import "AppDelegate.h"


@interface ProjViewController ()

@end

@implementation ProjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIView *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = 5.0f;
            btn.layer.masksToBounds = YES;
            [(UIButton *)btn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
            if (btn.tag == 1402) {
                UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLongPress:)];
                longPress.minimumPressDuration = 3.0;
                [btn addGestureRecognizer:longPress];
            }
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(UIButton *)sender {
    NSLog(@"D%ld",sender.tag);
    if (sender.tag == (long)1402) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息" message:@"请长按3秒" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        [[AppDelegate app] sendCom:[NSString stringWithFormat:@"D%ld",sender.tag]];   
    }
    
}

-(void)btnLongPress:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
         [[AppDelegate app] sendCom:[NSString stringWithFormat:@"D1402"]];  //投影机关机
    }
}
@end
