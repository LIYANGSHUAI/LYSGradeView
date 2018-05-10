//
//  ViewController.m
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSGradeView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self customSubViews1];
    [self customSubViews2];
    [self customSubViews3];
    [self customSubViews4];
}

- (void)customSubViews1 {
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0 + 130, 100, 70, 40)];
    [self.view addSubview:valueLabel];
    valueLabel.textColor = [UIColor redColor];
    valueLabel.font = [UIFont systemFontOfSize:25];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.text = @"3.5分";
    
    LYSGradeView *starView = [[LYSGradeView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0-70, 100, 200, 40) starNum:5 starSize:CGSizeMake(40, 40) style:[LYStarStyle style]];
    starView.value = 3.5;
    [self.view addSubview:starView];

    [starView setUpdateValueBlock:^(LYSGradeView *gradeView, CGFloat value) {
        valueLabel.text = [NSString stringWithFormat:@"%.1f分",value];
    }];
    
}

- (void)customSubViews2 {
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0 + 130, 200, 70, 40)];
    [self.view addSubview:valueLabel];
    valueLabel.textColor = [UIColor redColor];
    valueLabel.font = [UIFont systemFontOfSize:25];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.text = @"4.0分";
    
    LYSGradeView *starView = [[LYSGradeView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0-70, 200, 200, 40) starNum:5 starSize:CGSizeMake(40, 40) style:[LYStarStyle style]];
    starView.value = 4.0;
    [self.view addSubview:starView];
    
    [starView setUpdateValueBlock:^(LYSGradeView *gradeView, CGFloat value) {
        valueLabel.text = [NSString stringWithFormat:@"%.1f分",value];
    }];
    
}

- (void)customSubViews3 {
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0 + 130, 300, 70, 40)];
    [self.view addSubview:valueLabel];
    valueLabel.textColor = [UIColor redColor];
    valueLabel.font = [UIFont systemFontOfSize:25];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.text = @"2.5分";
    
    LYStarStyle *style = [LYStarStyle style];
    style.selectStrokeColor = [UIColor blackColor];
    style.defaultStrokeColor = [UIColor blackColor];
    style.strokeWidth = 2;
    
    LYSGradeView *starView = [[LYSGradeView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0-70, 300, 200, 40) starNum:5 starSize:CGSizeMake(40, 40) style:style];
    starView.value = 2.5;
    [self.view addSubview:starView];

    [starView setUpdateValueBlock:^(LYSGradeView *gradeView, CGFloat value) {
        valueLabel.text = [NSString stringWithFormat:@"%.1f分",value];
    }];
}
- (void)customSubViews4 {
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0 + 130, 400, 70, 40)];
    [self.view addSubview:valueLabel];
    valueLabel.textColor = [UIColor redColor];
    valueLabel.font = [UIFont systemFontOfSize:25];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.text = @"1.0分";
    
    LYSGradeView *starView = [[LYSGradeView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)/2.0-70, 400, 200, 40) starNum:5 starSize:CGSizeMake(40, 40) style:[LYStarStyle style]];
    starView.value = 1.0;
    [self.view addSubview:starView];
    
    [starView setUpdateValueBlock:^(LYSGradeView *gradeView, CGFloat value) {
        valueLabel.text = [NSString stringWithFormat:@"%.1f分",value];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
