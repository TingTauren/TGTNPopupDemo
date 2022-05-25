//
//  TGTNPopupLineDefaultView.h
//  TGTN
//
//  Created by TGTN on 2022/5/23.
//

#import "TGTNPopupDefaultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNPopupLineDefaultView : TGTNPopupDefaultView

/// 标题分割线颜色
@property (nonatomic, strong) UIColor *titleLineColor;
/// 标题分割线粗细
@property (nonatomic, assign) float titleLineThickness;
/// 标题分割线偏移
@property (nonatomic, assign) CGPoint titleLinePoint;

/// 内容分割线颜色
@property (nonatomic, strong) UIColor *contentLineColor;
/// 内容分割线粗细
@property (nonatomic, assign) float contentLineThickness;
/// 内容分割线偏移
@property (nonatomic, assign) CGPoint contentLinePoint;

/// 按钮分割线颜色
@property (nonatomic, strong) UIColor *buttonLineColor;
/// 按钮分割线粗细
@property (nonatomic, assign) float buttonLineThickness;
/// 按钮分割线偏移
@property (nonatomic, assign) CGPoint buttonLinePoint;

@end

NS_ASSUME_NONNULL_END
