//
//  NSString+LSString.h
//  lssChat
//
//  Created by 连帅帅 on 2019/8/15.
//  Copyright © 2019 连帅帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (LSString)

/**
 去掉后面的0(一些小数点后面不要多余的0)
 */
+(NSString*)removeFloatAllZeroByString:(NSString *)testNumber;

/**
 判断为空吗
 */
+(NSString *)isNull:(NSString *)str;


/**
 去除左右空格
 */
+(NSString *)stringByTrimmingCharacters:(NSString *)str;

/**
 设置字体
 */
+(NSMutableAttributedString *)setUpAttri:(NSString *)title andFloat:(CGFloat)font andCorString:(UIColor*)cor andTextName:(NSString *)fontWithName;

/**
 设置富文本
 */
+(NSMutableAttributedString *)setUpLabelAttri:(NSString *)title andFloat:(CGFloat)font andCor:(UIColor*)cor;

/**
 富文本拼接
 */
+(NSMutableAttributedString *)setUpAppendAttribued:(NSMutableArray<NSMutableAttributedString*>*)attriArr;

/**
 设置文本行距
 */
+ (NSMutableAttributedString *)changeLineSpaceForLabel:(NSString *)text WithSpace:(float)space;

/**
 判断是否是数字
 */
+(BOOL)isNumberCharacter:(NSString*)string;
/**
 判断是否是中文
 */
+(BOOL)isChineseCharacter:(NSString*)string;
/**
 输入的是英文
 */
+(BOOL)isEnglishCharacter:(NSString*)string;
/**
 输入的是emoji
 */
+(BOOL)isEmojiCharacter:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
