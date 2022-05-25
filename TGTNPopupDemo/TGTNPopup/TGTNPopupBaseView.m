//
//  TGTNPopupBaseView.m
//  TGTN
//
//  Created by TGTN on 2022/5/10.
//

#import "TGTNPopupBaseView.h"

#define TGTNPopupScreenWidth [UIScreen mainScreen].bounds.size.width
#define TGTNPopupScreenHeight [UIScreen mainScreen].bounds.size.height
#define TGTNPopupRootWindow [UIApplication sharedApplication].delegate.window

@interface TGTNPopupBaseView()<UIGestureRecognizerDelegate> {
    // 是否第一次设置
    BOOL _isFristLayoutSubviews;
    // 键盘监听前位置大小
    CGRect _oldBackImageFrame;
}
/// 背景
@property (nonatomic, readwrite) UIImageView *backImageView;

/// 动画类型
@property (nonatomic, assign) TGTNPopupAnimationType popupAnimationType;
@end

@implementation TGTNPopupBaseView

#pragma mark ------ get
- (UIImageView *)backImageView {
    if (_backImageView) return _backImageView;
    _backImageView = [UIImageView new];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.clipsToBounds = YES;
    return _backImageView;
}

#pragma mark ------ set
- (void)setTgtnBackObject:(id)tgtnBackObject {
    _tgtnBackObject = tgtnBackObject;
    
    if ([_tgtnBackObject isKindOfClass:[UIImage class]]) {
        _backImageView.image = _tgtnBackObject;
    } else if ([_tgtnBackObject isKindOfClass:[UIColor class]]) {
        _backImageView.backgroundColor = _tgtnBackObject;
    }
}
- (void)setTgtnBackCornerRadius:(float)tgtnBackCornerRadius {
    _tgtnBackCornerRadius = tgtnBackCornerRadius;
    [self tgtnAddBackImageCornerRadius];
}
- (void)setTgtnMonitorKeybord:(BOOL)tgtnMonitorKeybord {
    _tgtnMonitorKeybord = tgtnMonitorKeybord;
    if (_tgtnMonitorKeybord) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
}

#pragma mark ------ init
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect selfFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.bounds), floor(CGRectGetHeight(self.bounds)));
    if (!CGRectIsEmpty(self.frame) && _isFristLayoutSubviews) {
        
        _isFristLayoutSubviews = NO;
        
        // 设置视图大小
        self.frame = selfFrame;
        // 设置视图大小
        [self tgtnSetViewFrame:selfFrame];
        
        // 显示动画
        [self _tgtnShowPopupAnimation];
    } else {
        if (!CGRectEqualToRect(self.bounds, selfFrame)) {
            // 设置视图大小
            self.frame = selfFrame;
            // 设置视图大小
            [self tgtnSetViewFrame:selfFrame];
        }
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        
        [self _tgtnInitView];
        [self _tgtnInitEvent];
    }
    return self;
}
/// 初始化视图
- (void)_tgtnInitView {
    _isFristLayoutSubviews = YES;
    
    _tgtnBackObject = [UIColor whiteColor];
    _tgtnBackCorner = UIRectCornerAllCorners;
    _tgtnPositionType = TGTNPopupPositionTypeDefault;
    
    // 初始化数据
    [self tgtnInitDefaultAttribute];
    
    _tgtnMySelfBackColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.backgroundColor = _tgtnMySelfBackColor;
    
    [self addSubview:self.backImageView];
    
    // 添加其它视图
    [self tgtnAddOtherView];
}
/// 添加事件
- (void)_tgtnInitEvent {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick:)];
    tapGesture.delegate = self;
    [self addGestureRecognizer:tapGesture];
}

#pragma mark ------ UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (![touch.view isEqual:self]) {
        return NO;
    } else {
        return YES;
    }
}
- (void)tapGestureClick:(UIGestureRecognizer *) gesture {
    if (!CGRectContainsPoint(self.backImageView.frame, [gesture locationInView:self])) {
        if (!_tgtnBlankNotClosed) {
            // 关闭销毁视图
            [self tgtnDismissView];
            // 空白关闭回调
            if (self.tgtnBlankClosedClickConfig) {
                self.tgtnBlankClosedClickConfig();
            }
        }
    }
}

#pragma mark ------ Private
/// 动画方法
/// @param rect 坐标大小
/// @param isShow 是否显示
- (void)_tgtnAnimationMethodRect:(CGRect) rect isShow:(BOOL) isShow {
    [UIView animateWithDuration:0.3f animations:^{
        if (self.popupAnimationType == TGTNPopupAnimationTypeDefault) {
            if (isShow) {
                self.backImageView.transform = CGAffineTransformMake(1.0f, 0, 0, 1.0f, 0, 0);
            } else {
                self.backImageView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, 0.0, 0.0);
            }
        } else {
            self.backImageView.frame = rect;
        }
        if (isShow) {
            self.backgroundColor = self.tgtnMySelfBackColor;
        } else {
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        }
    } completion:^(BOOL finished) {
        if (!isShow) {
            [self removeFromSuperview];
        }
    }];
}
/// 显示动画
- (void)_tgtnShowPopupAnimation {
    if (_popupAnimationType == TGTNPopupAnimationTypeDefault) { // 中心缩放
        self.backImageView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, 0.0, 0.0);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        // 显示
        [self _tgtnAnimationMethodRect:CGRectZero isShow:YES];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeBottom) { // 底部弹出
        CGRect oldRect = self.backImageView.frame;
        self.backImageView.frame = CGRectMake(CGRectGetMinX(oldRect), TGTNPopupScreenHeight, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        // 显示
        [self _tgtnAnimationMethodRect:oldRect isShow:YES];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeTop) { // 顶部弹出
        CGRect oldRect = self.backImageView.frame;
        self.backImageView.frame = CGRectMake(CGRectGetMinX(oldRect), -TGTNPopupScreenHeight, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        // 显示
        [self _tgtnAnimationMethodRect:oldRect isShow:YES];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeLeft) { // 左部弹出
        CGRect oldRect = self.backImageView.frame;
        self.backImageView.frame = CGRectMake(oldRect.origin.x - TGTNPopupScreenWidth, oldRect.origin.y, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        // 显示
        [self _tgtnAnimationMethodRect:oldRect isShow:YES];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeRight) { // 右部弹出
        CGRect oldRect = self.backImageView.frame;
        self.backImageView.frame = CGRectMake(oldRect.origin.x + TGTNPopupScreenWidth, oldRect.origin.y, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        // 显示
        [self _tgtnAnimationMethodRect:oldRect isShow:YES];
    }
}

#pragma mark ------ Public
/// 显示方法
/// @param type 显示动画方向
- (void)tgtnShowPopupAnimationType:(TGTNPopupAnimationType) type {
    _popupAnimationType = type;
    
    if (_tgtnShowPopupController) {
        [_tgtnShowPopupController.view addSubview:self];
    } else {
        [TGTNPopupRootWindow addSubview:self];
    }
}
/// 关闭方法
- (void)tgtnDismissView {
    if (_popupAnimationType == TGTNPopupAnimationTypeDefault) {
        // 显示
        [self _tgtnAnimationMethodRect:CGRectZero isShow:NO];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeBottom) {
        CGRect oldRect = self.backImageView.frame;
        
        CGRect aniMationRect = CGRectMake(CGRectGetMinX(oldRect), TGTNPopupScreenHeight, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        // 显示
        [self _tgtnAnimationMethodRect:aniMationRect isShow:NO];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeTop) {
        CGRect oldRect = self.backImageView.frame;
        
        CGRect aniMationRect = CGRectMake(CGRectGetMinX(oldRect), -CGRectGetMaxY(oldRect), CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        // 显示
        [self _tgtnAnimationMethodRect:aniMationRect isShow:NO];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeLeft) { // 左部弹出
        CGRect oldRect = self.backImageView.frame;
        
        CGRect aniMationRect = CGRectMake(oldRect.origin.x - TGTNPopupScreenWidth, oldRect.origin.y, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        // 显示
        [self _tgtnAnimationMethodRect:aniMationRect isShow:NO];
    } else if (_popupAnimationType == TGTNPopupAnimationTypeRight) { // 右部弹出
        CGRect oldRect = self.backImageView.frame;
        
        CGRect aniMationRect = CGRectMake(oldRect.origin.x + TGTNPopupScreenWidth, oldRect.origin.y, CGRectGetWidth(oldRect), CGRectGetHeight(oldRect));
        // 显示
        [self _tgtnAnimationMethodRect:aniMationRect isShow:NO];
    }
}
/// 添加背景圆角,部分圆角需要设置BackImage大小后设置
- (void)tgtnAddBackImageCornerRadius {
    if (_tgtnBackCorner != UIRectCornerAllCorners && _tgtnBackCornerRadius > 0.0) {
        [_backImageView tgtn_popubCornerRadiusCorners:_tgtnBackCorner radius:CGSizeMake(_tgtnBackCornerRadius, _tgtnBackCornerRadius)];
    } else {
        _backImageView.layer.cornerRadius = _tgtnBackCornerRadius;
    }
}
/// 设置背景视图位置
/// @param selfFrame 父视图大小
/// @param bgSize 视图大小
- (void)tgtnSetBackImageViewFrame:(CGRect) selfFrame backImageSize:(CGSize) bgSize {
    float x = 0.0;
    float y = 0.0;
    
    float width = bgSize.width;
    float height = bgSize.height;
    
    if (_tgtnPositionType == TGTNPopupPositionTypeDefault) { // 中间显示
        x = (CGRectGetWidth(selfFrame) - width) / 2.0;
        y = (CGRectGetHeight(selfFrame) - height) / 2.0;
    } else if (_tgtnPositionType == TGTNPopupPositionTypeBottom) { // 底部显示
        x = (CGRectGetWidth(selfFrame) - width) / 2.0;
        y = CGRectGetHeight(selfFrame) - height;
    } else if (_tgtnPositionType == TGTNPopupPositionTypeTop) { // 顶部显示
        x = (CGRectGetWidth(selfFrame) - width) / 2.0;
    } else if (_tgtnPositionType == TGTNPopupPositionTypeLeft) { // 左部显示
        y = (CGRectGetHeight(selfFrame) - height) / 2.0;
    } else if (_tgtnPositionType == TGTNPopupPositionTypeRight) { // 右部显示
        x = CGRectGetWidth(selfFrame) - width;
        y = (CGRectGetHeight(selfFrame) - height) / 2.0;
    }
    
    // 增加偏移
    x = x + _tgtnBackPoint.x;
    y = y + _tgtnBackPoint.y;
    
    _backImageView.frame = CGRectMake(x, y, width, height);
}

#pragma mark ------ Notification
- (void)keyboardWillChangeFrame:(NSNotification *) notification {
    if ([notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height) {
        if ([notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y == TGTNPopupScreenHeight) {
            CGFloat closeTime = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]; // 动画持续时间
            if (_oldBackImageFrame.size.height > 0) {
                [UIView animateWithDuration:closeTime animations:^{
                    self.backImageView.frame = self->_oldBackImageFrame;
                }];
            }
        } else {
            CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
            CGFloat closeTime = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]; // 动画持续时间
            if (keyboardHeight < CGRectGetMaxY(self.backImageView.frame)) { // 遮住提示框了
                _oldBackImageFrame = self.backImageView.frame; // 记录原位置
                
                CGFloat keyBoardY = TGTNPopupScreenHeight-keyboardHeight;
                
                [UIView animateWithDuration:closeTime animations:^{
                    CGRect backImageFrame = self.backImageView.frame;
                    backImageFrame.origin.y = keyBoardY-CGRectGetHeight(self->_oldBackImageFrame);
                    self.backImageView.frame = backImageFrame;
                }];
            }
        }
    }
}

@end

@implementation TGTNPopupBaseView (TGTNPopupBaseViewAdd)

/// 初始化数据
- (void)tgtnInitDefaultAttribute {
    
}
/// 添加其它视图
- (void)tgtnAddOtherView {
}
/// 设置视图大小
/// @param selfFrame 视图大小
- (void)tgtnSetViewFrame:(CGRect)selfFrame {
    // 设置背景视图位置
    [self tgtnSetBackImageViewFrame:selfFrame backImageSize:CGSizeMake(CGRectGetWidth(selfFrame), 200.0)];
    
    // 添加背景圆角,部分圆角需要设置BackImage大小后设置
    [self tgtnAddBackImageCornerRadius];
}

@end
