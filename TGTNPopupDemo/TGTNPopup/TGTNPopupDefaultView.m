//
//  TGTNPopupDefaultView.m
//  TGTN
//
//  Created by TGTN on 2022/5/20.
//

#import "TGTNPopupDefaultView.h"

@interface TGTNPopupDefaultView() {
    /// 标题高度
    float _titleHeight;
    /// 内容高度
    float _contentHeight;
}
/// 标题
@property (nonatomic, readwrite) UILabel *titleLabel;
/// 内容
@property (nonatomic, readwrite) UILabel *contentLabel;
/// 按钮一
@property (nonatomic, readwrite) UIButton *buttonOne;
/// 按钮二
@property (nonatomic, readwrite) UIButton *buttonTwo;
@end

@implementation TGTNPopupDefaultView

#pragma mark ------ set
- (UILabel *)titleLabel {
    if (_titleLabel) return _titleLabel;
    _titleLabel = [UILabel new];
    _titleLabel.font = _titleFont;
    _titleLabel.textColor = _titleColor;
    _titleLabel.textAlignment = _titleAlignment;
    _titleLabel.numberOfLines = _titleNumberOfLines;
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (_contentLabel) return _contentLabel;
    _contentLabel = [UILabel new];
    _contentLabel.textColor = _contentColor;
    _contentLabel.font = _contentFont;
    _contentLabel.textAlignment = _contentAlignment;
    _contentLabel.numberOfLines = _contentNumberOfLines;
    return _contentLabel;
}
- (UIButton *)buttonOne {
    if (_buttonOne) return _buttonOne;
    _buttonOne = [UIButton new];
    if ([_btn1BackObject isKindOfClass:[UIColor class]]) {
        _buttonOne.backgroundColor = _btn1BackObject;
    } else if ([_btn1BackObject isKindOfClass:[UIImage class]]) {
        [_buttonOne setBackgroundImage:_btn1BackObject forState:UIControlStateNormal];
    }
    if (_btn1Image) {
        [_buttonOne setImage:_btn1Image forState:UIControlStateNormal];
    }
    [_buttonOne setTitleColor:_btn1TitleColor forState:UIControlStateNormal];
    [_buttonOne.titleLabel setFont:_btn1TitleFont];
    if (_btn1BorderColor) {
        _buttonOne.layer.borderColor = _btn1BorderColor.CGColor;
    }
    if (_btn1BorderWidth > 0.0) {
        _buttonOne.layer.borderWidth = _btn1BorderWidth;
    }
    [_buttonOne addTarget:self action:@selector(buttonOneClick:) forControlEvents:UIControlEventTouchUpInside];
    return _buttonOne;
}
- (UIButton *)buttonTwo {
    if (_buttonTwo) return _buttonTwo;
    _buttonTwo = [UIButton new];
    if ([_btn2BackObject isKindOfClass:[UIColor class]]) {
        _buttonTwo.backgroundColor = _btn2BackObject;
    } else if ([_btn2BackObject isKindOfClass:[UIImage class]]) {
        [_buttonTwo setBackgroundImage:_btn2BackObject forState:UIControlStateNormal];
    }
    if (_btn2Image) {
        [_buttonTwo setImage:_btn2Image forState:UIControlStateNormal];
    }
    [_buttonTwo setTitleColor:_btn2TitleColor forState:UIControlStateNormal];
    [_buttonTwo.titleLabel setFont:_btn2TitleFont];
    if (_btn2BorderColor) {
        _buttonTwo.layer.borderColor = _btn2BorderColor.CGColor;
    }
    if (_btn2BorderWidth > 0.0) {
        _buttonTwo.layer.borderWidth = _btn2BorderWidth;
    }
    [_buttonTwo addTarget:self action:@selector(buttonTwoClick:) forControlEvents:UIControlEventTouchUpInside];
    return _buttonTwo;
}

#pragma mark ------ get
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = _titleColor;
}
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    
    // 计算标题高度
    [self _tgtnCalculateTitleHeight];
}
- (void)setTitleAlignment:(NSTextAlignment)titleAlignment {
    _titleAlignment = titleAlignment;
    _titleLabel.textAlignment = _titleAlignment;
}
- (void)setTitleNumberOfLines:(NSInteger)titleNumberOfLines {
    _titleNumberOfLines = titleNumberOfLines;
    _titleLabel.numberOfLines = _titleNumberOfLines;
}
- (void)setTitleObject:(id)titleObject {
    _titleObject = titleObject;
    
    if ([_titleObject isKindOfClass:[NSMutableAttributedString class]]) {
        _titleLabel.attributedText = _titleObject;
    } else {
        _titleLabel.text = _titleObject;
    }
    // 计算标题高度
    [self _tgtnCalculateTitleHeight];
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    _contentLabel.textColor = _contentColor;
}
- (void)setContentFont:(UIFont *)contentFont {
    _contentFont = contentFont;
    _contentLabel.font = _contentFont;
    // 计算内容高度
    [self _tgtnCalculateContentHeight];
}
- (void)setContentAlignment:(NSTextAlignment)contentAlignment {
    _contentAlignment = contentAlignment;
    _contentLabel.textAlignment = _contentAlignment;
}
- (void)setContentNumberOfLines:(NSInteger)contentNumberOfLines {
    _contentNumberOfLines = contentNumberOfLines;
    _contentLabel.numberOfLines = _contentNumberOfLines;
}
- (void)setContentObject:(id)contentObject {
    _contentObject = contentObject;
    
    if ([_contentObject isKindOfClass:[NSMutableAttributedString class]]) {
        _contentLabel.attributedText = _contentObject;
    } else {
        _contentLabel.text = _contentObject;
    }
    // 计算内容高度
    [self _tgtnCalculateContentHeight];
}
- (void)setBtn1BackObject:(id)btn1BackObject {
    _btn1BackObject = btn1BackObject;
    if ([_btn1BackObject isKindOfClass:[UIColor class]]) {
        _buttonOne.backgroundColor = _btn1BackObject;
    } else if ([_btn1BackObject isKindOfClass:[UIImage class]]) {
        [_buttonOne setBackgroundImage:_btn1BackObject forState:UIControlStateNormal];
    }
}
- (void)setBtn1Image:(UIImage *)btn1Image {
    _btn1Image = btn1Image;
    [_buttonOne setImage:_btn1Image forState:UIControlStateNormal];
}
- (void)setBtn1TitleColor:(UIColor *)btn1TitleColor {
    _btn1TitleColor = btn1TitleColor;
    [_buttonOne setTitleColor:_btn1TitleColor forState:UIControlStateNormal];
}
- (void)setBtn1TitleFont:(UIFont *)btn1TitleFont {
    _btn1TitleFont = btn1TitleFont;
    [_buttonOne.titleLabel setFont:_btn1TitleFont];
}
- (void)setBtn1BorderColor:(UIColor *)btn1BorderColor {
    _btn1BorderColor = btn1BorderColor;
    _buttonOne.layer.borderColor = _btn1BorderColor.CGColor;
}
- (void)setBtn1BorderWidth:(float)btn1BorderWidth {
    _btn1BorderWidth = btn1BorderWidth;
    _buttonOne.layer.borderWidth = _btn1BorderWidth;
}
- (void)setBtn1ContentObject:(id)btn1ContentObject {
    _btn1ContentObject = btn1ContentObject;
    if ([_btn1ContentObject isKindOfClass:[NSMutableAttributedString class]]) {
        [_buttonOne setAttributedTitle:_btn1ContentObject forState:UIControlStateNormal];
    } else {
        [_buttonOne setTitle:_btn1ContentObject forState:UIControlStateNormal];
    }
}
- (void)setBtn2BackObject:(id)btn2BackObject {
    _btn2BackObject = btn2BackObject;
    if ([_btn2BackObject isKindOfClass:[UIColor class]]) {
        _buttonTwo.backgroundColor = _btn2BackObject;
    } else if ([_btn2BackObject isKindOfClass:[UIImage class]]) {
        [_buttonTwo setBackgroundImage:_btn2BackObject forState:UIControlStateNormal];
    }
}
- (void)setBtn2Image:(UIImage *)btn2Image {
    _btn2Image = btn2Image;
    [_buttonTwo setImage:_btn2Image forState:UIControlStateNormal];
}
- (void)setBtn2TitleColor:(UIColor *)btn2TitleColor {
    _btn2TitleColor = btn2TitleColor;
    [_buttonTwo setTitleColor:_btn2TitleColor forState:UIControlStateNormal];
}
- (void)setBtn2TitleFont:(UIFont *)btn2TitleFont {
    _btn2TitleFont = btn2TitleFont;
    [_buttonTwo.titleLabel setFont:_btn2TitleFont];
}
- (void)setBtn2BorderColor:(UIColor *)btn2BorderColor {
    _btn2BorderColor = btn2BorderColor;
    _buttonTwo.layer.borderColor = _btn2BorderColor.CGColor;
}
- (void)setBtn2BorderWidth:(float)btn2BorderWidth {
    _btn2BorderWidth = btn2BorderWidth;
    _buttonTwo.layer.borderWidth = _btn2BorderWidth;
}
- (void)setBtn2ContentObject:(id)btn2ContentObject {
    _btn2ContentObject = btn2ContentObject;
    if ([_btn2ContentObject isKindOfClass:[NSMutableAttributedString class]]) {
        [_buttonTwo setAttributedTitle:_btn2ContentObject forState:UIControlStateNormal];
    } else {
        [_buttonTwo setTitle:_btn2ContentObject forState:UIControlStateNormal];
    }
}

#pragma mark ------ Super Method
/// 初始化数据
- (void)tgtnInitDefaultAttribute {
    // 标题文本颜色
    _titleColor = [UIColor whiteColor];
    // 标题文本大小
    _titleFont = [UIFont boldSystemFontOfSize:18.0];
    // 标题显示位置
    _titleAlignment = NSTextAlignmentCenter;
    // 标题偏移
    _titlePoint = CGPointZero;
    
    // 内容文本颜色
    _contentColor = [UIColor whiteColor];
    // 内容文本大小
    _contentFont = [UIFont systemFontOfSize:16.0];
    // 内容显示位置
    _contentAlignment = NSTextAlignmentLeft;
    // 内容偏移
    _contentPoint = CGPointMake(15.0, 15.0);
    
    // 按钮1背景
    _btn1BackObject = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    // 按钮1标题颜色
    _btn1TitleColor = [UIColor whiteColor];
    // 按钮1标题大小
    _btn1TitleFont = [UIFont boldSystemFontOfSize:16.0];
    // 按钮1边框颜色
    _btn1BorderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    // 按钮2背景
    _btn2BackObject = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    // 按钮2标题颜色
    _btn2TitleColor = [UIColor whiteColor];
    // 按钮2标题大小
    _btn2TitleFont = [UIFont boldSystemFontOfSize:16.0];
    // 按钮2边框颜色
    _btn2BorderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    // 是否两个按钮
    _isDoubleButton = YES;
    // 按钮中间间距
    _buttonCenterSpacing = 30.0;
    // 按钮高度
    _buttonHeight = 50.0;
    // 按钮偏移
    _buttonPoint = CGPointMake(15.0, 15.0);
    // 按钮底部间距
    _buttonBottomSpacing = 20.0;
}
/// 添加其它视图
- (void)tgtnAddOtherView {
    [self.backImageView addSubview:self.titleLabel];
    [self.backImageView addSubview:self.contentLabel];
    [self.backImageView addSubview:self.buttonOne];
    [self.backImageView addSubview:self.buttonTwo];
}
/// 设置视图大小
/// @param selfFrame 视图大小
- (void)tgtnSetViewFrame:(CGRect)selfFrame {
    selfFrame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width - self.tgtnBackPoint.x * 2.0, selfFrame.size.height);
    
    if (!CGPointEqualToPoint(_titlePoint, CGPointZero)) {
        // 计算标题高度
        [self _tgtnCalculateTitleHeight];
    }
    if (!CGPointEqualToPoint(_contentPoint, CGPointMake(15.0, 15.0))) {
        // 计算内容高度
        [self _tgtnCalculateContentHeight];
    }
    
    self.titleLabel.frame = CGRectMake(_titlePoint.x, _titlePoint.y, CGRectGetWidth(selfFrame) - _titlePoint.x * 2.0, _titleHeight);
    
    self.contentLabel.frame = CGRectMake(_contentPoint.x, CGRectGetMaxY(_titleLabel.frame) + _contentPoint.y, CGRectGetWidth(selfFrame) - _contentPoint.x * 2.0, _contentHeight);
    
    float buttonWidth = (CGRectGetWidth(selfFrame) - _buttonPoint.x * 2.0 - _buttonCenterSpacing) / 2.0;
    if (!_isDoubleButton) {
        buttonWidth = CGRectGetWidth(selfFrame) - _buttonPoint.x * 2.0;
    }
    
    self.buttonOne.frame = CGRectMake(_buttonPoint.x, CGRectGetMaxY(_contentLabel.frame) + _buttonPoint.y, buttonWidth, _buttonHeight);
    if (_isDoubleButton) {
        self.buttonTwo.frame = CGRectMake(CGRectGetMaxX(self.buttonOne.frame) + _buttonCenterSpacing, CGRectGetMinY(self.buttonOne.frame), buttonWidth, _buttonHeight);
    } else {
        self.buttonTwo.hidden = YES;
    }
    
    float backHeight = CGRectGetMaxY(_buttonOne.frame) + _buttonBottomSpacing;
    
    // 设置背景视图位置
    [self tgtnSetBackImageViewFrame:selfFrame backImageSize:CGSizeMake(CGRectGetWidth(selfFrame), backHeight)];
    
    // 添加背景圆角,部分圆角需要设置BackImage大小后设置
    [self tgtnAddBackImageCornerRadius];
    
    // 添加按钮背景圆角,部分圆角需要设置按钮大小后设置
    [self tgtnAddButtonOneCornerRadius];
    // 添加按钮背景圆角,部分圆角需要设置按钮大小后设置
    [self tgtnAddButtonTwoCornerRadius];
}

#pragma mark ------ Click
/// 按钮1点击
- (void)buttonOneClick:(UIButton *) button {
    if (_buttonOneClickConfig) {
        _buttonOneClickConfig();
    }
}
/// 按钮2点击
- (void)buttonTwoClick:(UIButton *) button {
    if (_buttonTwoClickConfig) {
        _buttonTwoClickConfig();
    }
}

#pragma mark ------ Private
/// 计算标题高度
- (void)_tgtnCalculateTitleHeight {
    if (!_titleObject || !_titleFont) {
        return;
    }
    float maxWidth = CGRectGetWidth(self.bounds);
    if (maxWidth <= 0.0) {
        maxWidth = HUGE;
    }
    if (!CGPointEqualToPoint(_titlePoint, CGPointZero)) {
        maxWidth = maxWidth - _titlePoint.x * 2.0;
    }
    if (!CGPointEqualToPoint(self.tgtnBackPoint, CGPointZero)) {
        maxWidth = maxWidth - self.tgtnBackPoint.x * 2.0;
    }
    
    if ([self.titleObject isKindOfClass:[NSMutableAttributedString class]]) {
        self->_titleHeight = [NSString tgtn_popubBoundingAttribute:self.titleObject kernSpacing:0.0 lineSpacing:0.0 paragraphSpacing:0.0 font:self.titleFont maxSize:CGSizeMake(maxWidth, HUGE)].height;
    } else {
        self->_titleHeight = [NSString tgtn_popubBoundingString:self.titleObject maxSize:CGSizeMake(maxWidth, HUGE) font:self.titleFont kernSpacing:0.0 lineSpacing:0.0].height;
    }
}
/// 计算内容高度
- (void)_tgtnCalculateContentHeight {
    if (!_contentObject || !_contentFont) {
        return;
    }
    float maxWidth = CGRectGetWidth(self.bounds);
    if (maxWidth <= 0.0) {
        maxWidth = HUGE;
    }
    if (!CGPointEqualToPoint(_contentPoint, CGPointZero)) {
        maxWidth = maxWidth - _contentPoint.x * 2.0;
    }
    if (!CGPointEqualToPoint(self.tgtnBackPoint, CGPointZero)) {
        maxWidth = maxWidth - self.tgtnBackPoint.x * 2.0;
    }
    
    if ([self.contentObject isKindOfClass:[NSMutableAttributedString class]]) {
        self->_contentHeight = [NSString tgtn_popubBoundingAttribute:self.contentObject kernSpacing:0.0 lineSpacing:0.0 paragraphSpacing:0.0 font:self.contentFont maxSize:CGSizeMake(maxWidth, HUGE)].height;
    } else {
        self->_contentHeight = [NSString tgtn_popubBoundingString:self.contentObject maxSize:CGSizeMake(maxWidth, HUGE) font:self.contentFont kernSpacing:0.0 lineSpacing:0.0].height;
    }
}

#pragma mark ------ Public
/// 添加按钮背景圆角,部分圆角需要设置按钮大小后设置
- (void)tgtnAddButtonOneCornerRadius {
    if (_btn1Corner != UIRectCornerAllCorners && _btn1CornerRadius > 0.0) {
        [_buttonOne tgtn_popubCornerRadiusCorners:_btn1Corner radius:CGSizeMake(_btn1CornerRadius, _btn1CornerRadius)];
    } else {
        _buttonOne.layer.cornerRadius = _btn1CornerRadius;
    }
}
/// 添加按钮背景圆角,部分圆角需要设置按钮大小后设置
- (void)tgtnAddButtonTwoCornerRadius {
    if (_btn2Corner != UIRectCornerAllCorners && _btn2CornerRadius > 0.0) {
        [_buttonTwo tgtn_popubCornerRadiusCorners:_btn2Corner radius:CGSizeMake(_btn2CornerRadius, _btn2CornerRadius)];
    } else {
        _buttonTwo.layer.cornerRadius = _btn2CornerRadius;
    }
}

@end
