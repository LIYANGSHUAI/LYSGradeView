//
//  LYStarLayer.m
//  LYSGradeViewDemo
//
//  Created by HENAN on 2017/11/14.
//  Copyright © 2017年 HENAN. All rights reserved.
//

#import "LYStarLayer.h"

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
            CGContextSetLineWidth(ctx, 1);
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
            CGContextSetLineWidth(ctx, 1);
            CGContextAddPath(ctx, starPath.CGPath);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            
            UIBezierPath *path = [self createIncompletenessStarWithCenter:CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5) radius:self.frame.size.width * 0.5 ctx:ctx];
            CGContextSetLineCap(ctx, kCGLineCapRound);
            CGContextSetLineJoin(ctx, kCGLineJoinRound);
            CGContextSetFillColorWithColor(ctx, self.selectFillColor.CGColor);
            CGContextSetStrokeColorWithColor(ctx, self.selectStrokeColor.CGColor);
            CGContextSetLineWidth(ctx, 1);
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
            CGContextSetLineWidth(ctx, 1);
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
