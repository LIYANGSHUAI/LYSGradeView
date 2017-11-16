//
//  ViewController.m
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSGradeView.h"

@interface ViewController ()<LYSGradeViewDelegate>

@end

@implementation ViewController
{
    LYSGradeView *starView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    starView = [[LYSGradeView alloc] initWithFrame:CGRectMake(100, 300, 200, 40) starNum:5 starSize:CGSizeMake(40, 40) style:[LYStarStyle style]];
    starView.delegate = self;
    [self.view addSubview:starView];
    
    [starView setUpdateValueBlock:^(LYSGradeView *gradeView, CGFloat value) {
        NSLog(@"%f",value);
    }];

}
//- (void)gradeView:(LYSGradeView *)gradeView didUpdateValue:(CGFloat)value{
//    NSLog(@"%f",value);
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
