//
//  LYSGradeView.m
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYSGradeView.h"

@interface LYSGradeView ()

@property (nonatomic,assign)NSInteger starNum;
@property (nonatomic,assign)CGSize starSize;

@property (nonatomic,strong)NSMutableArray *starAry;
@property (nonatomic,strong)NSMutableArray *rectFrames;

@property (nonatomic,assign)CGFloat logicValue;

@end

@implementation LYSGradeView
@synthesize value = _value;

+ (instancetype)gradeViewWithFrame:(CGRect)frame starNum:(NSInteger)starNum starSize:(CGSize)starSize  style:(LYStarStyle *)style{
    return [[LYSGradeView alloc] initWithFrame:frame starNum:starNum starSize:starSize style:style];
}

- (instancetype)initWithFrame:(CGRect)frame starNum:(NSInteger)starNum starSize:(CGSize)starSize  style:(LYStarStyle *)style
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.starNum = starNum;
        self.starSize = starSize;
        
        CGFloat margin = (frame.size.width - (starNum * starSize.width)) / (starNum + 1) ;
        [self.rectFrames addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, margin, frame.size.height)]];
        
        for (int i = 0; i < starNum; i++)
        {
            LYStarLayer *star = [LYStarLayer layer];
            star.selectStrokeColor = style.selectStrokeColor;
            star.defaultStrokeColor = style.defaultStrokeColor;
            star.selectFillColor = style.selectFillColor;
            star.defaultFillColor = style.defaultFillColor;
            star.strokeWidth = style.strokeWidth;
            
            [self.layer addSublayer:star];
            [self.starAry addObject:star];
            
            star.bounds = CGRectMake(0, 0, starSize.width, starSize.height);
            star.state = LYStarStateNotSelect;
            
            CGFloat x = (starSize.width / 2.0 + margin) + (starSize.width + margin) * i;
            CGFloat y = frame.size.height * 0.5;
            star.position = CGPointMake(x, y);
            
            [self.rectFrames addObject:[NSValue valueWithCGRect:CGRectMake(star.frame.origin.x, 0, starSize.width / 2.0, frame.size.height)]];
            [self.rectFrames addObject:[NSValue valueWithCGRect:CGRectMake(star.frame.origin.x + starSize.width / 2.0, 0, starSize.width / 2.0, frame.size.height)]];
            [self.rectFrames addObject:[NSValue valueWithCGRect:CGRectMake(star.frame.origin.x + starSize.width, 0, margin, frame.size.height)]];
            
            [star setNeedsDisplay];
        }
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.starAry = [NSMutableArray array];
        self.rectFrames = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(CGFloat)value {
    _value = value;
    int num = (int)_value;
    for (int i = 0;  i < self.starAry.count; i++) {
        LYStarLayer *star = [self.starAry objectAtIndex:i];
        if (i <= (num - 1)) {
            star.state = LYStarStateFullSelect;
        } else {
            star.state = LYStarStateNotSelect;
        }
        [star setNeedsDisplay];
    }
    if (_value - (CGFloat)num != 0) {
        for (int i = 0;  i < self.starAry.count; i++) {
            LYStarLayer *star = [self.starAry objectAtIndex:i];
            if (i == num) {
                star.state = LYStarStateMoietySelect;
            }
            [star setNeedsDisplay];
        }
    }
}

- (CGFloat)value {
    return self.logicValue;
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
    
    NSInteger index = 0;
    for (int i = 0; i < self.rectFrames.count; i++) {
        CGRect rect = [self.rectFrames[i] CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
            index = i;
        }
    }
    
    for (int i = 0;  i < self.starAry.count; i++) {
        LYStarLayer *star = [self.starAry objectAtIndex:i];
        NSInteger firstIndex = 1 + 3 * i;
        NSInteger lastIndex = 2 + 3 * i;
        if (index > lastIndex || index == lastIndex) {
            star.state = LYStarStateFullSelect;
        }
        else if (index == firstIndex) {
            star.state = LYStarStateMoietySelect;
        }
        else {
            star.state = LYStarStateNotSelect;
        }
        [star setNeedsDisplay];
    }
    
    self.logicValue = 0;
    for (int i = 0; i < self.starAry.count; i++)
    {
        LYStarLayer *star = [self.starAry objectAtIndex:i];
        switch (star.state) {
            case LYStarStateNotSelect:
            {
                self.logicValue += 0;
            }
                break;
            case LYStarStateMoietySelect:
            {
                self.logicValue += 0.5;
            }
                break;
            case LYStarStateFullSelect:
            {
                self.logicValue += 1;
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

@implementation LYStarStyle
+ (instancetype)style{
    
    LYStarStyle *style = [[LYStarStyle alloc] init];
    
    style.selectFillColor = [UIColor redColor];
    style.defaultFillColor = [UIColor lightGrayColor];
    style.strokeWidth = 0;
    style.selectStrokeColor = [UIColor clearColor];
    style.defaultStrokeColor = [UIColor clearColor];
    
    return style;
}
@end

@implementation LYStarLayer

- (void)drawInContext:(CGContextRef)ctx{
    self.shouldRasterize = YES;
    switch (self.state) {
        case LYStarStateNotSelect:
        {
            UIBezierPath *path = [self createStarWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 ctx:ctx];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetFillColorWithColor(ctx, self.defaultFillColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx, self.defaultStrokeColor.CGColor);
            CGContextSetLineWidth(ctx, self.strokeWidth);
            CGContextAddPath(ctx, path.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
        }
            break;
        case LYStarStateMoietySelect:
        {
            UIBezierPath *starPath = [self createStarWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 ctx:ctx];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetFillColorWithColor(ctx, self.defaultFillColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx, self.defaultStrokeColor.CGColor);
            CGContextSetLineWidth(ctx, self.strokeWidth);
            CGContextAddPath(ctx, starPath.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            
            UIBezierPath *path = [self createIncompletenessStarWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 ctx:ctx];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetFillColorWithColor(ctx, self.selectFillColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx, self.selectStrokeColor.CGColor);
            CGContextSetLineWidth(ctx, 0);
            CGContextAddPath(ctx, path.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
        }
            break;
        case LYStarStateFullSelect:
        {
            UIBezierPath *starPath = [self createStarWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 ctx:ctx];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetFillColorWithColor(ctx, self.selectFillColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx, self.selectStrokeColor.CGColor);
            CGContextSetLineWidth(ctx, self.strokeWidth);
            CGContextAddPath(ctx, starPath.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
        }
            break;
        default:
            break;
    }
    
}

// 创建一个不完整的星星
- (UIBezierPath *)createIncompletenessStarWithCenter:(CGPoint)center radius:(CGFloat)radius ctx:(CGContextRef)ctx
{
    UIBezierPath *starPath = [UIBezierPath bezierPath];
    
    CGFloat xx = sin((3.14159265359 * 36)/ 180) * radius;
    CGFloat yy = cos((3.14159265359 * 36)/ 180) * radius;
    
    CGFloat mm = sin((3.14159265359 * 72)/ 180) * radius;
    CGFloat nn = cos((3.14159265359 * 72)/ 180) * radius;
    
    CGPoint a = CGPointMake(center.x, center.y - radius);
    CGPoint c = CGPointMake(center.x - xx, center.y + yy);
    CGPoint b = CGPointMake(center.x - mm, center.y - nn);
    
    CGFloat oo = sin((3.14159265359 * 18)/ 180) * radius;
    CGFloat pp = tan((3.14159265359 * 36)/ 180) * oo;
    
    CGFloat qq = sqrt(oo * oo + pp * pp);
    
    CGFloat ss = sin((3.14159265359 * 18)/ 180) * qq;
    CGFloat dd = cos((3.14159265359 * 18)/ 180) * qq;
    
    CGPoint i = CGPointMake(center.x - pp, center.y - oo);
    CGPoint f = CGPointMake(center.x, center.y + qq);
    CGPoint j = CGPointMake(center.x - dd, center.y + ss);
    
    [starPath moveToPoint:a];
    [starPath addLineToPoint:i];
    [starPath addLineToPoint:b];
    [starPath addLineToPoint:j];
    [starPath addLineToPoint:c];
    [starPath addLineToPoint:f];
    [starPath addLineToPoint:a];
    
    return starPath;
}

// 创建一个完整的星星
- (UIBezierPath *)createStarWithCenter:(CGPoint)center radius:(CGFloat)radius ctx:(CGContextRef)ctx
{
    UIBezierPath *starPath = [UIBezierPath bezierPath];
    
    CGFloat xx = sin((3.14159265359 * 36)/ 180) * radius;
    CGFloat yy = cos((3.14159265359 * 36)/ 180) * radius;
    
    CGFloat mm = sin((3.14159265359 * 72)/ 180) * radius;
    CGFloat nn = cos((3.14159265359 * 72)/ 180) * radius;
    
    CGPoint a = CGPointMake(center.x, center.y - radius);
    CGPoint c = CGPointMake(center.x - xx, center.y + yy);
    CGPoint e = CGPointMake(center.x + mm, center.y - nn);
    CGPoint b = CGPointMake(center.x - mm, center.y - nn);
    CGPoint d = CGPointMake(center.x + xx, center.y + yy);
    
    CGFloat oo = sin((3.14159265359 * 18)/ 180) * radius;
    CGFloat pp = tan((3.14159265359 * 36)/ 180) * oo;
    
    CGFloat qq = sqrt(oo * oo + pp * pp);
    
    CGFloat ss = sin((3.14159265359 * 18)/ 180) * qq;
    CGFloat dd = cos((3.14159265359 * 18)/ 180) * qq;
    
    CGPoint i = CGPointMake(center.x - pp, center.y - oo);
    CGPoint h = CGPointMake(center.x + pp, center.y - oo);
    CGPoint f = CGPointMake(center.x, center.y + qq);
    CGPoint j = CGPointMake(center.x - dd, center.y + ss);
    CGPoint g = CGPointMake(center.x + dd, center.y + ss);
    
    [starPath moveToPoint:a];
    [starPath addLineToPoint:i];
    [starPath addLineToPoint:b];
    [starPath addLineToPoint:j];
    [starPath addLineToPoint:c];
    [starPath addLineToPoint:f];
    [starPath addLineToPoint:d];
    [starPath addLineToPoint:g];
    [starPath addLineToPoint:e];
    [starPath addLineToPoint:h];
    [starPath addLineToPoint:a];
    
    return starPath;
}
@end

