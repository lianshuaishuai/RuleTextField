//
//  NSString+LSString.m
//  lssChat
//
//  Created by 连帅帅 on 2019/8/15.
//  Copyright © 2019 连帅帅. All rights reserved.
//

#import "NSString+LSString.h"

@implementation NSString (LSString)
//去除左右空格
+(NSString *)stringByTrimmingCharacters:(NSString *)str{
    return   [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
//去掉后面的0
+(NSString*)removeFloatAllZeroByString:(NSString *)testNumber{
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    return outNumber;
}
/**
 判断null
 */
+(NSString *)isNull:(NSString *)str{
    if ([str isEqualToString:@"(null)"] || [str isEqual:[NSNull null]]) {
        return @"";
    }else if  (!str) {
        return @"";
    }else{
        return str;
    }
}


//设置富文本
+(NSMutableAttributedString *)setUpLabelAttri:(NSString *)title andFloat:(CGFloat)font andCor:(UIColor*)cor{
    
    return [self setUpAttri:title andFloat:font andCorString:cor andTextName:@""];
}

//富文本拼接
+(NSMutableAttributedString *)setUpAppendAttribued:(NSMutableArray<NSMutableAttributedString*>*)attriArr{
    if (!attriArr.count) return nil;
    
    NSMutableAttributedString *text = attriArr[0];
    for (int i = 1; i<attriArr.count; i++) {
        NSMutableAttributedString *otherText = attriArr[i];
        [text appendAttributedString:otherText];
    }
    return  text;
}

//设置字体
+(NSMutableAttributedString *)setUpAttri:(NSString *)title andFloat:(CGFloat)font andCorString:(UIColor*)cor andTextName:(NSString *)fontWithName{
   
    if (!title.length) return  [[NSMutableAttributedString alloc]initWithString:@""];
    NSMutableAttributedString * text = [[NSMutableAttributedString alloc]initWithString:title];
    UIFont *labelFont = [UIFont systemFontOfSize:font];
    if (fontWithName.length) {
        labelFont = [UIFont fontWithName:fontWithName size:font];
    }
    if (font)  [text addAttribute:NSFontAttributeName value:labelFont range:NSMakeRange(0, title.length)];
    if (cor) [text addAttribute:NSForegroundColorAttributeName value:cor range:NSMakeRange(0, title.length)];
   
    return text;
}

+ (NSMutableAttributedString *)changeLineSpaceForLabel:(NSString *)text WithSpace:(float)space {
    
    NSAttributedString  *attributedText = [[NSAttributedString alloc]initWithString:text];
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc]initWithAttributedString:attributedText];
   
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return attributedString;
}

//输入的是数字
+(BOOL)isNumberCharacter:(NSString*)string {
   
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    
    return [numberPredicate evaluateWithObject:string];
}

//输入的是中文
+(BOOL)isChineseCharacter:(NSString*)string {

    NSString *regex = @"[\u4e00-\u9fa5]+";

    return ([string rangeOfString:regex options:NSRegularExpressionSearch].length>0);
}

//输入的是英文
+(BOOL)isEnglishCharacter:(NSString*)string {

    NSString *upperRegex = @"^[\\u0041-\\u005A]+$";

    NSString *lowerRegex = @"^[\\u0061-\\u007A]+$";

    BOOL isEnglish = (([string rangeOfString:upperRegex options:NSRegularExpressionSearch].length>0) || ([string rangeOfString:lowerRegex options:NSRegularExpressionSearch].length>0));

    return isEnglish;
}

//输入的是emoji
+(BOOL)isEmojiCharacter:(NSString *)string
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL containsEmoji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        
        if (0xd800 <= hs &&
            hs <= 0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc &&
                    uc <= 0x1f9c0)
                {
                    containsEmoji = YES;
                }
            }
        }
        else if (substring.length > 1)
        {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3 ||
                ls == 0xfe0f ||
                ls == 0xd83c)
            {
                containsEmoji = YES;
            }
        }
        else
        {
            // non surrogate
            if (0x2100 <= hs &&
                hs <= 0x27ff)
            {
                containsEmoji = YES;
            }
            else if (0x2B05 <= hs &&
                     hs <= 0x2b07)
            {
                containsEmoji = YES;
            }
            else if (0x2934 <= hs &&
                     hs <= 0x2935)
            {
                containsEmoji = YES;
            }
            else if (0x3297 <= hs &&
                     hs <= 0x3299)
            {
                containsEmoji = YES;
            }
            else if (hs == 0xa9 ||
                     hs == 0xae ||
                     hs == 0x303d ||
                     hs == 0x3030 ||
                     hs == 0x2b55 ||
                     hs == 0x2b1c ||
                     hs == 0x2b1b ||
                     hs == 0x2b50)
            {
                containsEmoji = YES;
            }
        }
        
        if (containsEmoji)
        {
            *stop = YES;
        }
    }];
    return containsEmoji;
}
@end
