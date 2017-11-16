//
//  LYStarLayer.h
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYStarState) {
    LYStarStateNotSelect,        // 没有选中
    LYStarStateMoietySelect,     // 选中一半
    LYStarStateFullSelect,       // 完全选中
};

@interface LYStarLayer : CALayer
@property (nonatomic,assign)LYStarState state;
@property (nonatomic,strong)UIColor *selectFillColor;
@property (nonatomic,strong)UIColor *defaultFillColor;
@property (nonatomic,strong)UIColor *selectStrokeColor;
@property (nonatomic,strong)UIColor *defaultStrokeColor;
@end
