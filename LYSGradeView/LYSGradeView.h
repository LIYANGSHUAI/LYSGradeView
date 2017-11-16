//
//  LYSGradeView.h
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYStarStyle.h"

@class LYSGradeView;

@protocol LYSGradeViewDelegate <NSObject>

/**
 实时检测评分值

 @param gradeView 视图
 @param value 数值
 */
- (void)gradeView:(LYSGradeView *)gradeView didUpdateValue:(CGFloat)value;
@end

@interface LYSGradeView : UIView

/**
 设置代理,处理监测事件
 */
@property (nonatomic,assign)id<LYSGradeViewDelegate> delegate;

/**
 监听评分回调
 */
@property (nonatomic,copy)void(^updateValueBlock)(LYSGradeView *gradeView,CGFloat value);
/**
 构造器创建评分视图

 @param frame 评分视图位置
 @param starNum 小星星个数
 @param starSize 小星星大小
 @param style 小星星样式
 @return 返回评分视图
 */
+ (instancetype)gradeViewWithFrame:(CGRect)frame
                           starNum:(NSInteger)starNum
                          starSize:(CGSize)starSize
                             style:(LYStarStyle *)style;

/**
 创建评分视图

 @param frame 评分视图位置
 @param starNum 小星星个数
 @param starSize 小星星大小
 @param style 小星星样式
 @return 返回评分视图
 */
- (instancetype)initWithFrame:(CGRect)frame
                      starNum:(NSInteger)starNum
                     starSize:(CGSize)starSize
                        style:(LYStarStyle *)style;
@end
