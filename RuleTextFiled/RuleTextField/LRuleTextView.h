//
//  LRuleTextView.h
//  RuleTextFiled
//
//  Created by 连帅帅 on 2020/9/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface LRuleTextViewManger : NSObject
/**
 内容的颜色
 */
@property(nonatomic, strong)UIColor *text_color;

/**
 占位符的颜色
 */
@property(nonatomic, strong)UIColor *placeholder_color;

/**
 底部字数总数的颜色
 */
@property(nonatomic, strong)UIColor *bottom_all_color;

/**
 底部字数输入字数的颜色
 */
@property(nonatomic, strong)UIColor *bottom_num_color;

/**
 
 光标颜色
 */
@property(nonatomic, strong)UIColor *tintColor;

/**
 底部字数字体大小
 */
@property(nonatomic, assign)CGFloat bottom_font_float;


/**
 内容的字体大小
 */
@property(nonatomic, strong)UIFont *text_font;

/**
 占位符的字体大小
 */
@property(nonatomic, strong)UIFont *placeholder_font;

/**
 边框线颜色
 */
@property(nonatomic, strong)UIColor *border_corlor;

/**
 textview的背景颜色
 */
@property(nonatomic, strong)UIColor *ground_corlor;

/**
 
 左右的内边距
 */
@property(nonatomic, assign)CGFloat inset_about;

/**
 
 上下的内边距
 */
@property(nonatomic, assign)CGFloat inset_up_down;

/**
 
 最大输入个数
 */
@property(nonatomic, assign)NSInteger maxNum;

/**
 占位符
 */
@property(nonatomic, copy)NSString *placeholder;

/**
 圆角
 */
@property(nonatomic, assign)CGFloat cornerRadius;



@end
@interface LRuleTextView : UIView
@property(nonatomic, assign)BOOL exceedMax;//是否超过最大输入内容
-(instancetype)initWithManger:(void (^) (LRuleTextViewManger *manger))mangerBlock;
@end

NS_ASSUME_NONNULL_END
