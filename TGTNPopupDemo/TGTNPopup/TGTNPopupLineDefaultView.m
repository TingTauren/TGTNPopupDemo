//
//  TGTNPopupLineDefaultView.m
//  TGTN
//
//  Created by TGTN on 2022/5/23.
//

#import "TGTNPopupLineDefaultView.h"

@interface TGTNPopupLineDefaultView()
/// 标题分割线
@property (nonatomic, strong) UILabel *titleLine;
/// 内容分割线
@property (nonatomic, strong) UILabel *contentLine;
/// 按钮分割线
@property (nonatomic, strong) UILabel *buttonLine;
@end

@implementation TGTNPopupLineDefaultView

#pragma mark ------ get
- (UILabel *)titleLine {
    if (_titleLine) return _titleLine;
    _titleLine = [UILabel new];
    _titleLine.backgroundColor = _titleLineColor;
    return _titleLine;
}
- (UILabel *)contentLine {
    if (_contentLine) return _contentLine;
    _contentLine = [UILabel new];
    _contentLine.backgroundColor = _contentLineColor;
    return _contentLine;
}
- (UILabel *)buttonLine {
    if (_buttonLine) return _buttonLine;
    _buttonLine = [UILabel new];
    _buttonLine.backgroundColor = _buttonLineColor;
    return _buttonLine;
}

#pragma mark ------ set

#pragma mark ------ Super Method
/// 初始化数据
- (void)tgtnInitDefaultAttribute {
    [super tgtnInitDefaultAttribute];
    
    // 标题分割线颜色
    _titleLineColor = [UIColor whiteColor];
    // 标题分割线粗细
    _titleLineThickness = 1.0;
    // 标题分割线偏移
    _titleLinePoint = CGPointMake(0.0, 0.0);

    // 内容分割线颜色
    _contentLineColor = [UIColor whiteColor];
    // 内容分割线粗细
    _contentLineThickness = 1.0;
    // 内容分割线偏移
    _contentLinePoint = CGPointMake(0.0, 0.0);

    // 按钮分割线颜色
    _buttonLineColor = [UIColor whiteColor];
    // 按钮分割线粗细
    _buttonLineThickness = 1.0;
    // 按钮分割线偏移
    _buttonLinePoint = CGPointMake(0.0, 0.0);
}
/// 添加其它视图
- (void)tgtnAddOtherView {
    [super tgtnAddOtherView];
    
    [self.backImageView addSubview:self.titleLine];
    [self.backImageView addSubview:self.contentLine];
    [self.backImageView addSubview:self.buttonLine];
}
/// 设置视图大小
/// @param selfFrame 视图大小
- (void)tgtnSetViewFrame:(CGRect)selfFrame {
    [super tgtnSetViewFrame:selfFrame];
    
    selfFrame = CGRectMake(selfFrame.origin.x, selfFrame.origin.y, selfFrame.size.width - self.tgtnBackPoint.x * 2.0, selfFrame.size.height);
    
    _titleLine.frame = CGRectMake(_titleLinePoint.x, CGRectGetMaxY(self.titleLabel.frame) + _titleLinePoint.y, CGRectGetWidth(selfFrame) - _titleLinePoint.x * 2.0, _titleLineThickness);
    _contentLine.frame = CGRectMake(_contentLinePoint.x, CGRectGetMaxY(self.contentLabel.frame) + _contentLinePoint.y, CGRectGetWidth(selfFrame) - _contentLinePoint.x * 2.0 , _contentLineThickness);
    _buttonLine.frame = CGRectMake((CGRectGetWidth(selfFrame) - _buttonLineThickness)/2.0, CGRectGetMinY(self.buttonOne.frame) + _buttonLinePoint.y, _buttonLineThickness, CGRectGetHeight(self.buttonOne.frame) - _buttonLinePoint.y * 2.0);
    if (!self.isDoubleButton) {
        _buttonLine.hidden = YES;
    }
}

#pragma mark ------ Private

@end
