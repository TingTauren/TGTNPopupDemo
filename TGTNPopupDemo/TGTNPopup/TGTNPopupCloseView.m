//
//  TGTNPopupCloseView.m
//  TGTN
//
//  Created by TGTN on 2022/5/25.
//

#import "TGTNPopupCloseView.h"

@interface TGTNPopupCloseView() {
    /// 标题高度
    float _titleHeight;
    /// 内容高度
    float _contentHeight;
}
/// 标题
@property (nonatomic, readwrite) UILabel *titleLabel;
/// 内容
@property (nonatomic, readwrite) UILabel *contentLabel;
/// 关闭按钮
@property (nonatomic, readwrite) UIButton *closeButton;
@end

@implementation TGTNPopupCloseView

#pragma mark ------ get
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
- (UIButton *)closeButton {
    if (_closeButton) return _closeButton;
    _closeButton = [UIButton new];
    if ([_btnBackObject isKindOfClass:[UIColor class]]) {
        _closeButton.backgroundColor = _btnBackObject;
    } else if ([_btnBackObject isKindOfClass:[UIImage class]]) {
        [_closeButton setBackgroundImage:_btnBackObject forState:UIControlStateNormal];
    }
    if (_btnImage) {
        [_closeButton setImage:_btnImage forState:UIControlStateNormal];
    }
    [_closeButton setTitleColor:_btnTitleColor forState:UIControlStateNormal];
    [_closeButton.titleLabel setFont:_btnTitleFont];
    if (_btnBorderColor) {
        _closeButton.layer.borderColor = _btnBorderColor.CGColor;
    }
    if (_btnBorderWidth > 0.0) {
        _closeButton.layer.borderWidth = _btnBorderWidth;
    }
    [_closeButton addTarget:self action:@selector(closeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return _closeButton;
}

#pragma mark ------ set
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
- (void)setBtnBackObject:(id)btnBackObject {
    _btnBackObject = btnBackObject;
    if ([_btnBackObject isKindOfClass:[UIColor class]]) {
        _closeButton.backgroundColor = _btnBackObject;
    } else if ([_btnBackObject isKindOfClass:[UIImage class]]) {
        [_closeButton setBackgroundImage:_btnBackObject forState:UIControlStateNormal];
    }
}
- (void)setBtnImage:(UIImage *)btnImage {
    _btnImage = btnImage;
    [_closeButton setImage:_btnImage forState:UIControlStateNormal];
}
- (void)setBtnTitleColor:(UIColor *)btnTitleColor {
    _btnTitleColor = btnTitleColor;
    [_closeButton setTitleColor:_btnTitleColor forState:UIControlStateNormal];
}
- (void)setBtnTitleFont:(UIFont *)btnTitleFont {
    _btnTitleFont = btnTitleFont;
    [_closeButton.titleLabel setFont:_btnTitleFont];
}
- (void)setBtnBorderColor:(UIColor *)btnBorderColor {
    _btnBorderColor = btnBorderColor;
    _closeButton.layer.borderColor = _btnBorderColor.CGColor;
}
- (void)setBtnBorderWidth:(float)btnBorderWidth {
    _btnBorderWidth = btnBorderWidth;
    _closeButton.layer.borderWidth = _btnBorderWidth;
}
- (void)setBtnContentObject:(id)btnContentObject {
    _btnContentObject = btnContentObject;
    if ([_btnContentObject isKindOfClass:[NSMutableAttributedString class]]) {
        [_closeButton setAttributedTitle:_btnContentObject forState:UIControlStateNormal];
    } else {
        [_closeButton setTitle:_btnContentObject forState:UIControlStateNormal];
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
    
    // 按钮背景
    _btnBackObject = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    // 按钮标题颜色
    _btnTitleColor = [UIColor whiteColor];
    // 按钮标题大小
    _btnTitleFont = [UIFont boldSystemFontOfSize:16.0];
    // 按钮边框颜色
    _btnBorderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    
    // 按钮偏移
    _buttonPoint = CGPointMake(-15.0, 15.0);
    // 按钮大小
    _buttonSize = CGSizeMake(20.0, 20.0);
    // 底部间距
    _bottomSpacing = 15.0;
}
/// 添加其它视图
- (void)tgtnAddOtherView {
    [self.backImageView addSubview:self.titleLabel];
    [self.backImageView addSubview:self.contentLabel];
    [self.backImageView addSubview:self.closeButton];
}
/// 设置视图大小
/// @param selfFrame 视图大小
- (void)tgtnSetViewFrame:(CGRect) selfFrame {
    selfFrame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width - self.tgtnBackPoint.x * 2.0, selfFrame.size.height);
    
    if (!CGPointEqualToPoint(_titlePoint, CGPointZero)) {
        // 计算标题高度
        [self _tgtnCalculateTitleHeight];
    }
    if (!CGPointEqualToPoint(_contentPoint, CGPointMake(15.0, 15.0))) {
        // 计算内容高度
        [self _tgtnCalculateContentHeight];
    }
    
    float buttonX = CGRectGetWidth(selfFrame) + _buttonPoint.x - _buttonSize.width;
    self.closeButton.frame = CGRectMake(buttonX, _buttonPoint.y, _buttonSize.width, _buttonSize.height);
    
    self.titleLabel.frame = CGRectMake(_titlePoint.x, _titlePoint.y, CGRectGetWidth(selfFrame) - _titlePoint.x * 2.0, _titleHeight);
    
    self.contentLabel.frame = CGRectMake(_contentPoint.x, CGRectGetMaxY(_titleLabel.frame) + _contentPoint.y, CGRectGetWidth(selfFrame) - _contentPoint.x * 2.0, _contentHeight);
    
    float backHeight = CGRectGetMaxY(_contentLabel.frame) + _bottomSpacing;
    
    // 设置背景视图位置
    [self tgtnSetBackImageViewFrame:selfFrame backImageSize:CGSizeMake(CGRectGetWidth(selfFrame), backHeight)];
}

#pragma mark ------ Click
/// 关闭按钮点击
- (void)closeButtonClick:(UIButton *) button {
    if (_closeButtonClickConfig) {
        _closeButtonClickConfig();
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

@end
