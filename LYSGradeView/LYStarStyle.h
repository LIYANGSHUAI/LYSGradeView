//
//  LYStarStyle.h
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/15.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYStarStyle : NSObject
@property (nonatomic,strong)UIColor *selectFillColor;
@property (nonatomic,strong)UIColor *defaultFillColor;
@property (nonatomic,strong)UIColor *selectStrokeColor;
@property (nonatomic,strong)UIColor *defaultStrokeColor;

+ (instancetype)style;
@end
