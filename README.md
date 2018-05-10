# LYSGradeView
A simple score star component

[image](https://github.com/LIYANGSHUAI/LYSGradeView/blob/master/gif.gif)


使用方法:

1.直接下载demo

2.使用cocopods

pod 'LYSGradeView', '~> 0.0.2'


```objc
@class LYSGradeView,LYStarStyle;

@protocol LYSGradeViewDelegate <NSObject>

// 实时检测评分值
- (void)gradeView:(LYSGradeView *)gradeView didUpdateValue:(CGFloat)value;
@end

@interface LYSGradeView : UIView

// 设置代理,处理监测事件
@property (nonatomic,assign)id<LYSGradeViewDelegate> delegate;

@property (nonatomic,assign)CGFloat value;

// 监听评分回调
@property (nonatomic,copy)void(^updateValueBlock)(LYSGradeView *gradeView,CGFloat value);

// 构造器创建评分视图
+ (instancetype)gradeViewWithFrame:(CGRect)frame starNum:(NSInteger)starNum starSize:(CGSize)starSize style:(LYStarStyle *)style;

// 创建评分视图
- (instancetype)initWithFrame:(CGRect)frame starNum:(NSInteger)starNum starSize:(CGSize)starSize style:(LYStarStyle *)style;
@end

typedef NS_ENUM(NSUInteger, LYStarState) {
LYStarStateNotSelect,        // 没有选中
LYStarStateMoietySelect,     // 选中一半
LYStarStateFullSelect,       // 完全选中
};

@interface LYStarStyle : NSObject
// 满星颜色
@property (nonatomic,strong)UIColor *selectFillColor;
// 空星颜色
@property (nonatomic,strong)UIColor *defaultFillColor;

// 线宽
@property (nonatomic,assign)CGFloat strokeWidth;
// 满星线条颜色
@property (nonatomic,strong)UIColor *selectStrokeColor;
// 空星线条颜色
@property (nonatomic,strong)UIColor *defaultStrokeColor;

+ (instancetype)style;
@end
```
