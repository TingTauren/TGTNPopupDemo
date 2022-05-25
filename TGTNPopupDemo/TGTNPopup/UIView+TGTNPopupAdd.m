//
//  UIView+TGTNPopupAdd.m
//  TGTN
//
//  Created by TGTN on 2022/5/23.
//

#import "UIView+TGTNPopupAdd.h"

@implementation UIView (TGTNPopupAdd)

/// 设置部分圆角(绝对布局)
/// @param corners 圆角位置
/// @param radius 圆角大小
- (void)tgtn_popubCornerRadiusCorners:(UIRectCorner) corners radius:(CGSize) radius {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radius];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

/// 设置部分圆角(相对布局)
/// @param corners 圆角位置
/// @param radius 圆角大小
/// @param rect 视图大小
- (void)tgtn_popubCornerRadiusCorners:(UIRectCorner) corners radius:(CGSize) radius viewRect:(CGRect) rect {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radius];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

@end
