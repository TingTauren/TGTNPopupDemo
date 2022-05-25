//
//  TGTNPopupDefaultView.h
//  TGTN
//
//  Created by TGTN on 2022/5/20.
//

#import "TGTNPopupBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TGTNPopupDefaultView : TGTNPopupBaseView

/// 按钮1点击
@property (nonatomic, copy) dispatch_block_t buttonOneClickConfig;
/// 按钮2点击
@property (nonatomic, copy) dispatch_block_t buttonTwoClickConfig;

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

/// 按钮1背景
@property (nonatomic, strong) id btn1BackObject;
/// 按钮1图片
@property (nonatomic, strong) UIImage *btn1Image;
/// 按钮1标题颜色
@property (nonatomic, strong) UIColor *btn1TitleColor;
/// 按钮1标题大小
@property (nonatomic, strong) UIFont *btn1TitleFont;
/// 按钮1圆角
@property (nonatomic, assign) float btn1CornerRadius;
/// 按钮1边框颜色
@property (nonatomic, strong) UIColor *btn1BorderColor;
/// 按钮1边框宽度
@property (nonatomic, assign) float btn1BorderWidth;
/// 按钮1圆角方向
@property (nonatomic, assign) UIRectCorner btn1Corner;
/// 按钮1内容
@property (nonatomic, strong) id btn1ContentObject;
/// 按钮一
@property (nonatomic, readonly) UIButton *buttonOne;

/// 按钮2背景
@property (nonatomic, strong) id btn2BackObject;
/// 按钮2图片
@property (nonatomic, strong) UIImage *btn2Image;
/// 按钮2标题颜色
@property (nonatomic, strong) UIColor *btn2TitleColor;
/// 按钮2标题大小
@property (nonatomic, strong) UIFont *btn2TitleFont;
/// 按钮2圆角
@property (nonatomic, assign) float btn2CornerRadius;
/// 按钮2边框颜色
@property (nonatomic, strong) UIColor *btn2BorderColor;
/// 按钮2边框宽度
@property (nonatomic, assign) float btn2BorderWidth;
/// 按钮2圆角方向
@property (nonatomic, assign) UIRectCorner btn2Corner;
/// 按钮2内容
@property (nonatomic, strong) id btn2ContentObject;
/// 按钮二
@property (nonatomic, readonly) UIButton *buttonTwo;

/// 是否两个按钮
@property (nonatomic, assign) BOOL isDoubleButton;
/// 按钮中间间距
@property (nonatomic, assign) float buttonCenterSpacing;
/// 按钮高度
@property (nonatomic, assign) float buttonHeight;
/// 按钮偏移
@property (nonatomic, assign) CGPoint buttonPoint;
/// 按钮底部间距
@property (nonatomic, assign) float buttonBottomSpacing;

/// 添加按钮背景圆角,部分圆角需要设置按钮大小后设置
- (void)tgtnAddButtonOneCornerRadius;
/// 添加按钮背景圆角,部分圆角需要设置按钮大小后设置
- (void)tgtnAddButtonTwoCornerRadius;

@end

NS_ASSUME_NONNULL_END
