//
//  NSString+TGTNPopupAdd.h
//  TGTN
//
//  Created by TGTN on 2022/5/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TGTNPopupAdd)

/// 计算富文本大小
/// @param attribute 副文本
/// @param kSpacing 字间距
/// @param lSpacing 行间距
/// @param paragraphSpacing 段落间距
/// @param font 字体大小
/// @param maxSize 限制大小
+ (CGSize)tgtn_popubBoundingAttribute:(NSMutableAttributedString *) attribute kernSpacing:(float) kSpacing lineSpacing:(float) lSpacing paragraphSpacing:(float) paragraphSpacing font:(UIFont * _Nullable) font maxSize:(CGSize) maxSize;
/// 计算字符串的大小
/// @param string 字符串
/// @param maxSize 限制大小
/// @param font 字体大小
/// @param lSpacing 行间距
/// @param kSpacing 字间距
+ (CGSize)tgtn_popubBoundingString:(NSString *) string maxSize:(CGSize) maxSize font:(UIFont *) font kernSpacing:(float) kSpacing lineSpacing:(float) lSpacing;

@end

NS_ASSUME_NONNULL_END
