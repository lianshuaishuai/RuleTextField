//
//  LRuleTextField.h
//  RuleTextFiled
//
//  Created by 连帅帅 on 2020/9/25.
//
#pragma mark--如果还有其他什么规则 可以继承此类 再子类中根据业务需求添加响应的判断（比如 LSSTextField）
#import <UIKit/UIKit.h>
#import "NSString+LSString.h"
typedef NS_ENUM(NSInteger, RuleType)
{
    //数字
    ruleNum = 0,
    //中文
    ruleCh = 1,
    //英文
    ruleEn = 2,
    //emoji
    ruleEmoji = 3
};

typedef NS_ENUM(NSInteger, RuleNumberCount)
{
    //length
    ruleNumber = 0,
    //字符 一个汉字是2个字符
    ruleChar = 1,
};
NS_ASSUME_NONNULL_BEGIN
@interface LRuleTextFieldManger : NSObject
/**
 内容的颜色
 */
@property(nonatomic, strong)UIColor *text_color;

/**
 占位符的颜色
 */
@property(nonatomic, strong)UIColor *placeholder_color;

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
 textfield的背景颜色
 */
@property(nonatomic, strong)UIColor *ground_corlor;

/**
 
 光标颜色
 */
@property(nonatomic, strong)UIColor *tintColor;

/**
 圆角
 */
@property(nonatomic, assign)CGFloat cornerRadius;

/**
 密码是否是隐藏
 */
@property(nonatomic, assign)BOOL secureTextEntry;

/**
 
 左边的图片
 */
@property(nonatomic, strong)UIImage *leftImage;

/**
 
 左边的图片背景的frame
 */
@property(nonatomic, assign)CGSize leftSize;


/**
 
 右边的图片
 */
@property(nonatomic, strong)UIImage *rightImage;

/**
 
 右边的图片背景的frame
 */
@property(nonatomic, assign)CGSize rightSize;

/**
 
 左右的内边距
 */
@property(nonatomic, assign)CGFloat inset_about;

/**
 
 上下的内边距
 */
@property(nonatomic, assign)CGFloat inset_up_down;

/**
 只能输入什么类型
 allowInput 和 endbleInput 只设置一个即可 
 */
@property(nonatomic, strong)NSArray *allowInput;

/**
 
 禁止输入
 */
@property(nonatomic, strong)NSArray *endbleInput;

/**
 
 最大输入个数
 */
@property(nonatomic, assign)NSInteger maxNum;

/**
 占位符
 */
@property(nonatomic, copy)NSString *placeholder;

/**
  统计个数是否统计emoji
  默认是no 统计emoji
 */
@property(nonatomic, assign)BOOL deleteEmoticons;

/**
 
 对输入框输入监听
 */
@property(nonatomic, assign)BOOL monitorTextChage;//默认是不监听

/**
 
 获取内容中中文，英文， 数字的个数或者是字符数或者不获取
 */
@property(nonatomic, assign)RuleNumberCount numberRule;//默认不获取
//允许输入的类型
-(BOOL)allowRule:(NSString *)text;

//禁止输入的类型
-(BOOL)enbleRule:(NSString *)text;

@end

@protocol LRuleTextFieldDelegate <NSObject>
@optional
-(void)lruleTextChange:(NSString *)text andObject:(id)object;
@end
@interface LRuleTextField : UITextField<UITextFieldDelegate>

@property(nonatomic, strong)LRuleTextFieldManger*manger;

@property(nonatomic, assign)id<LRuleTextFieldDelegate>adegate;

-(instancetype)initWithManger:(void (^) (LRuleTextFieldManger *manger))mangerBlock;

-(void)textFieldChanged:(UITextField *)textField;
@end

NS_ASSUME_NONNULL_END
