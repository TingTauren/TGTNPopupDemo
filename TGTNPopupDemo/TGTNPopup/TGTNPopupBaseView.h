//
//  TGTNPopupBaseView.h
//  TGTN
//
//  Created by TGTN on 2022/5/10.
//

#import <UIKit/UIKit.h>

#import "NSString+TGTNPopupAdd.h"
#import "UIView+TGTNPopupAdd.h"

NS_ASSUME_NONNULL_BEGIN

/// 显示动画方向
typedef NS_ENUM(NSInteger, TGTNPopupAnimationType) {
    TGTNPopupAnimationTypeDefault = 0, /// 中心缩放
    TGTNPopupAnimationTypeBottom, /// 底部弹出
    TGTNPopupAnimationTypeTop, /// 顶部弹出
    TGTNPopupAnimationTypeLeft, /// 左部弹出
    TGTNPopupAnimationTypeRight /// 右部弹出
};

/// 显示位置
typedef NS_ENUM(NSInteger, TGTNPopupPositionType) {
    TGTNPopupPositionTypeDefault = 0, /// 中间
    TGTNPopupPositionTypeBottom, /// 底部
    TGTNPopupPositionTypeTop, /// 顶部
    TGTNPopupPositionTypeLeft, /// 左部
    TGTNPopupPositionTypeRight /// 右部
};

@interface TGTNPopupBaseView : UIView

/// 空白关闭回调
@property (nonatomic, copy) dispatch_block_t tgtnBlankClosedClickConfig;

/// 视图透明度颜色
@property (nonatomic, strong) UIColor *tgtnMySelfBackColor;

/// 背景
@property (nonatomic, strong) id tgtnBackObject;
/// 背景圆角方向
@property (nonatomic, assign) UIRectCorner tgtnBackCorner;
/// 背景圆角
@property (nonatomic, assign) float tgtnBackCornerRadius;
/// 背景偏移
@property (nonatomic, assign) CGPoint tgtnBackPoint;
/// 空白是否不关闭
@property (nonatomic, assign) BOOL tgtnBlankNotClosed;
/// 是否监听键盘
@property (nonatomic, assign) BOOL tgtnMonitorKeybord;
/// 显示位置
@property (nonatomic, assign) TGTNPopupPositionType tgtnPositionType;

/// 背景视图
@property (nonatomic, readonly) UIImageView *backImageView;
/// 显示父视图
@property (nonatomic, weak) UIViewController *tgtnShowPopupController;

/// 显示方法
/// @param type 显示动画方向
- (void)tgtnShowPopupAnimationType:(TGTNPopupAnimationType) type;
/// 关闭方法
- (void)tgtnDismissView;

/// 添加背景圆角,部分圆角需要设置BackImage大小后设置
- (void)tgtnAddBackImageCornerRadius;
/// 设置背景视图位置
/// @param selfFrame 父视图大小
/// @param bgSize 视图大小
- (void)tgtnSetBackImageViewFrame:(CGRect) selfFrame backImageSize:(CGSize) bgSize;

@end

#pragma mark ------ 分割线

@interface TGTNPopupBaseView (TGTNPopupBaseViewAdd)

/// 初始化数据
- (void)tgtnInitDefaultAttribute;
/// 添加其它视图
- (void)tgtnAddOtherView;
/// 设置视图大小
/// @param selfFrame 视图大小
- (void)tgtnSetViewFrame:(CGRect)selfFrame;

@end

NS_ASSUME_NONNULL_END
