//
//  TGTNPopupCloseView.h
//  TGTN
//
//  Created by TGTN on 2022/5/25.
//

#import "TGTNPopupBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNPopupCloseView : TGTNPopupBaseView

/// 按钮点击
@property (nonatomic, copy) dispatch_block_t closeButtonClickConfig;

/// 标题文本颜色
@property (nonatomic, strong) UIColor *titleColor;
/// 标题文本大小
@property (nonatomic, strong) UIFont *titleFont;
/// 标题显示位置
@property (nonatomic, assign) NSTextAlignment titleAlignment;
/// 标题行数
@property (nonatomic, assign) NSInteger titleNumberOfLines;
/// 标题数据
@property (nonatomic, strong) id titleObject;
/// 标题偏移
@property (nonatomic, assign) CGPoint titlePoint;
/// 标题
@property (nonatomic, readonly) UILabel *titleLabel;

/// 内容文本颜色
@property (nonatomic, strong) UIColor *contentColor;
/// 内容文本大小
@property (nonatomic, strong) UIFont *contentFont;
/// 内容显示位置
@property (nonatomic, assign) NSTextAlignment contentAlignment;
/// 内容行数
@property (nonatomic, assign) NSInteger contentNumberOfLines;
/// 内容数据
@property (nonatomic, strong) id contentObject;
/// 内容偏移
@property (nonatomic, assign) CGPoint contentPoint;
/// 内容
@property (nonatomic, readonly) UILabel *contentLabel;

/// 按钮背景
@property (nonatomic, strong) id btnBackObject;
/// 按钮图片
@property (nonatomic, strong) UIImage *btnImage;
/// 按钮标题颜色
@property (nonatomic, strong) UIColor *btnTitleColor;
/// 按钮标题大小
@property (nonatomic, strong) UIFont *btnTitleFont;
/// 按钮圆角
@property (nonatomic, assign) float btnCornerRadius;
/// 按钮边框颜色
@property (nonatomic, strong) UIColor *btnBorderColor;
/// 按钮边框宽度
@property (nonatomic, assign) float btnBorderWidth;
/// 按钮圆角方向
@property (nonatomic, assign) UIRectCorner btn1Corner;
/// 按钮内容
@property (nonatomic, strong) id btnContentObject;
/// 按钮一
@property (nonatomic, readonly) UIButton *closeButton;

/// 按钮偏移
@property (nonatomic, assign) CGPoint buttonPoint;
/// 按钮大小
@property (nonatomic, assign) CGSize buttonSize;
/// 底部间距
@property (nonatomic, assign) float bottomSpacing;

@end

NS_ASSUME_NONNULL_END
