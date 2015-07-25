//
//  MatrixViewController.m
//  邯郸规划设计院20层多功能厅
//
//  Created by wharlim on 15/7/25.
//  Copyright (c) 2015年 wharlim. All rights reserved.
//

#import "MatrixViewController.h"
#import "AppDelegate.h"

@interface MatrixViewController (){
    long matrix1_InputNum;
    long matrix2_InputNum;
    long matrix1_OutputNum;
    long matrix2_OutputNum;
}
@property (nonatomic,strong)NSMutableArray *matrix1Input;
@property (nonatomic,strong)NSMutableArray *matrix1Output;
@property (nonatomic,strong)NSMutableArray *matrix2Input;
@property (nonatomic,strong)NSMutableArray *matrix2Output;


@end

@implementation MatrixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    matrix1_InputNum = 0;
    matrix2_InputNum = 0;
    matrix1_OutputNum = 0;
    matrix2_OutputNum = 0;
    
    _matrix1Input = [[NSMutableArray alloc] init];
    _matrix1Output = [[NSMutableArray alloc] init];
    _matrix2Input = [[NSMutableArray alloc] init];
    _matrix2Output = [[NSMutableArray alloc] init];
    
    for (UIView *btn in self.view.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.layer.cornerRadius = 5.0f;
            btn.layer.masksToBounds = YES;
            if (btn.tag <= 1304) {
                [_matrix1Input addObject:btn];
            }else if (btn.tag <= 1308){
                [_matrix1Output addObject:btn];
            }else if (btn.tag <= 1358){
                [_matrix2Input addObject:btn];
            }else {
                [_matrix2Output addObject:btn];
            }
            [(UIButton *)btn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(UIButton *)sender {
    // NSLog(@"%ld",sender.tag);
    
    if (sender.tag <= 1304) {
        matrix1_InputNum = sender.tag - 1300;
        [self matrix_input:_matrix1Input withOutput:_matrix1Output currentInputBtn:sender];
    }else if (sender.tag <= 1308){
        if (![self isMatrixSelect:_matrix1Input]) {     //消息提示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息" message:@"请先选择输入，再选择输出。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        matrix1_OutputNum = sender.tag - 1304;
         [[AppDelegate app] sendCom:[NSString stringWithFormat:@"C11%ld%ld",matrix1_InputNum,matrix1_OutputNum]];
        [self matrix_output:_matrix1Output currentOutputBtn:sender];
       
    }else if (sender.tag <= 1358){
        matrix2_InputNum = sender.tag - 1350;
        [self matrix_input:_matrix2Input withOutput:_matrix2Output currentInputBtn:sender];
       
    }else {
        if (![self isMatrixSelect:_matrix2Input]) {     //消息提示
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"消息" message:@"请先选择输入，再选择输出。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            return;
        }
        matrix2_OutputNum = sender.tag - 1358;
        [[AppDelegate app] sendCom:[NSString stringWithFormat:@"C22%ld%ld",matrix2_InputNum,matrix2_OutputNum]];
        [self matrix_output:_matrix2Output currentOutputBtn:sender];
       
    }
    
}

- (void)matrix_input:(NSMutableArray *)input withOutput:(NSMutableArray *)output currentInputBtn:(UIButton *)btn{
    for (UIButton *btn_array in input) {
        if (btn == btn_array) {
            [btn_array setSelected:YES];
        }else{
            [btn_array setSelected:NO];
        }
    }
    for (UIButton *btn_array in output) {
            [btn_array setSelected:NO];
    
    }
    
}

- (void)matrix_output:(NSMutableArray *)output currentOutputBtn:(UIButton *)btn{

    for (UIButton *btn_array in output) {
        if (btn == btn_array) {
            [btn_array setSelected:YES];
        }else{
            [btn_array setSelected:NO];
        }
    }

    
}

-(BOOL)isMatrixSelect:(NSMutableArray *)input{
    BOOL Continue = NO;
    for (UIButton *btn_array in input) {
        if (btn_array.isSelected == YES) {
            Continue = YES;
        }
        
    }
    return Continue;
    
}














@end
