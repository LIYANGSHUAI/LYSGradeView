//
//  LYStarStyle.m
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/15.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYStarStyle.h"

@implementation LYStarStyle
- (UIColor *)selectFillColor{
    if (!_selectFillColor) {
        _selectFillColor = [UIColor redColor];
    }
    return _selectFillColor;
}

- (UIColor *)defaultFillColor{
    if (!_defaultFillColor) {
        _defaultFillColor = [UIColor lightGrayColor];
    }
    return _defaultFillColor;
}

- (UIColor *)selectStrokeColor{
    if (!_selectStrokeColor) {
        _selectStrokeColor = [UIColor clearColor];
    }
    return _selectStrokeColor;
}

- (UIColor *)defaultStrokeColor{
    if (!_defaultStrokeColor) {
        _defaultStrokeColor = [UIColor clearColor];
    }
    return _defaultStrokeColor;
}

+ (instancetype)style{
    return [[LYStarStyle alloc] init];
}
@end
