//
//  UIView+TGTNPopupAdd.h
//  TGTN
//
//  Created by TGTN on 2022/5/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TGTNPopupAdd)

/// 设置部分圆角(绝对布局)
/// @param corners 圆角位置
/// @param radius 圆角大小
- (void)tgtn_popubCornerRadiusCorners:(UIRectCorner) corners radius:(CGSize) radius;

/// 设置部分圆角(相对布局)
/// @param corners 圆角位置
/// @param radius 圆角大小
/// @param rect 视图大小
- (void)tgtn_popubCornerRadiusCorners:(UIRectCorner) corners radius:(CGSize) radius viewRect:(CGRect) rect;

@end

NS_ASSUME_NONNULL_END
