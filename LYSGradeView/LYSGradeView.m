//
//  LYSGradeView.m
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSGradeView.h"
#import "LYStarLayer.h"

@interface LYSGradeView ()

@property (nonatomic,strong)NSMutableArray *starAry;
@property (nonatomic,assign)NSInteger starNum;
@property (nonatomic,assign)CGSize starSize;
@property (nonatomic,assign)CGFloat value;
@end

@implementation LYSGradeView

- (NSMutableArray *)starAry
{
    if (!_starAry) {
        _starAry = [NSMutableArray array];
    }
    return _starAry;
}

+ (instancetype)gradeViewWithFrame:(CGRect)frame starNum:(NSInteger)starNum starSize:(CGSize)starSize  style:(LYStarStyle *)style{
    return [[LYSGradeView alloc] initWithFrame:frame starNum:starNum starSize:starSize style:style];
}

- (instancetype)initWithFrame:(CGRect)frame starNum:(NSInteger)starNum starSize:(CGSize)starSize  style:(LYStarStyle *)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.starNum = starNum;
        self.starSize = starSize;
        self.value = 0;
        
        self.backgroundColor = [UIColor greenColor];
        
        for (int i = 0; i < starNum; i++)
        {
            LYStarLayer *star = [LYStarLayer layer];
            star.backgroundColor = [UIColor blackColor].CGColor;
            star.selectStrokeColor = style.selectStrokeColor;
            star.defaultStrokeColor = style.defaultStrokeColor;
            star.selectFillColor = style.selectFillColor;
            star.defaultFillColor = style.defaultFillColor;
            
            [self.layer addSublayer:star];
            [self.starAry addObject:star];
            
            star.bounds = CGRectMake(0, 0, starSize.width, starSize.height);
            star.state = LYStarStateNotSelect;
            
            CGFloat margin = (frame.size.width - (starNum * starSize.width)) / (starNum - 1) ;

            CGFloat x = (starSize.width / 2.0) + (starSize.width + margin) * i;
            CGFloat y = frame.size.height * 0.5;
            star.position = CGPointMake(x, y);
            
            [star setNeedsDisplay];
        }
        
    }
    return self;
}

- (void)setDefaultFillColor:(UIColor *)defaultFillColor{
    defaultFillColor = defaultFillColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    [self changeStyle:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self];
    [self changeStyle:point];
}

- (void)changeStyle:(CGPoint)point{
    
//    CGFloat margin = (self.frame.size.width - (self.starNum * self.starSize.width)) / (self.starNum - 1) ;
    
    NSNumber *indexValue = nil;
    
    for (int i = 0; i < self.starAry.count; i++) {
        if (point.x / (i * self.starSize.width) >= 1) {
            indexValue = @(i);
        }else {
            indexValue = nil;
        }
    }
    
    if (indexValue) {
        int index = [indexValue intValue];
        for (int i = 0; i < self.starAry.count; i++)
        {
            LYStarLayer *star = [self.starAry objectAtIndex:i];
            if (i < index)
            {
                star.state = LYStarStateFullSelect;
            }else
                if (i == index)
                {
                    if (i == 0)
                    {
                        if (point.x < 0)
                        {
                            star.state = LYStarStateNotSelect;
                        }else
                            if (point.x > self.starSize.width * 0.5)
                            {
                                star.state = LYStarStateFullSelect;
                            }else
                            {
                                star.state = LYStarStateMoietySelect;
                            }
                    }else
                    {
                        if (point.x - self.starSize.width * index > self.starSize.width * 0.5)
                        {
                            star.state = LYStarStateFullSelect;
                        }else
                        {
                            star.state = LYStarStateMoietySelect;
                        }
                    }
                }else
                {
                    star.state = LYStarStateNotSelect;
                }
            
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            [star setNeedsDisplay];
            [CATransaction commit];
        }
    }
    
    
    self.value = 0;
    for (int i = 0; i < self.starAry.count; i++)
    {
        
        LYStarLayer *star = [self.starAry objectAtIndex:i];
        
        switch (star.state) {
            case LYStarStateNotSelect:
            {
                self.value += 0;
            }
                break;
            case LYStarStateMoietySelect:
            {
                self.value += 0.5;
            }
                break;
            case LYStarStateFullSelect:
            {
                self.value += 1;
            }
                break;
            default:
                break;
        }
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(gradeView:didUpdateValue:)]) {
        [self.delegate gradeView:self didUpdateValue:self.value];
    }
    if (self.updateValueBlock) {
        self.updateValueBlock(self, self.value);
    }
    
}


@end
