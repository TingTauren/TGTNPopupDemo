//
//  NSString+TGTNPopupAdd.m
//  TGTN
//
//  Created by TGTN on 2022/5/20.
//

#import "NSString+TGTNPopupAdd.h"

@implementation NSString (TGTNPopupAdd)

/// 计算富文本大小
/// @param attribute 副文本
/// @param kSpacing 字间距
/// @param lSpacing 行间距
/// @param paragraphSpacing 段落间距
/// @param font 字体大小
/// @param maxSize 限制大小
+ (CGSize)tgtn_popubBoundingAttribute:(NSMutableAttributedString *) attribute kernSpacing:(float) kSpacing lineSpacing:(float) lSpacing paragraphSpacing:(float) paragraphSpacing font:(UIFont * _Nullable) font maxSize:(CGSize) maxSize {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置行间距
    paraStyle.lineSpacing = lSpacing;
    // 段落间距
    paraStyle.paragraphSpacing = paragraphSpacing;
    // 设置字间距和字体大小和行间距
    NSDictionary *dict = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kSpacing)};
    // 计算字符大小
    CGSize attributedStringSize = [attribute.string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    attributedStringSize = CGSizeMake(ceil(attributedStringSize.width) + 1.0, ceil(attributedStringSize.height) + 1.0);
    return attributedStringSize;
}

/// 计算字符串的大小
/// @param string 字符串
/// @param maxSize 限制大小
/// @param font 字体大小
/// @param lSpacing 行间距
/// @param kSpacing 字间距
+ (CGSize)tgtn_popubBoundingString:(NSString *) string maxSize:(CGSize) maxSize font:(UIFont *) font kernSpacing:(float) kSpacing lineSpacing:(float) lSpacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    // 设置行间距
    paraStyle.lineSpacing = fmax(lSpacing, 1.0);
    // 设置字间距和字体大小和行间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@(kSpacing)};
    // 转换为富文本字符
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:dic];
    // 计算字符大小
    CGSize attributedStringSize = [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    attributedStringSize = CGSizeMake(ceil(attributedStringSize.width) + 1.0, ceil(attributedStringSize.height) + 1.0);
    return attributedStringSize;
}

@end
