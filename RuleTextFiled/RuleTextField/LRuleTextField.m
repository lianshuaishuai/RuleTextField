//
//  LRuleTextField.m
//  RuleTextFiled
//
//  Created by 连帅帅 on 2020/9/25.
//

#import "LRuleTextField.h"
@implementation LRuleTextFieldManger

-(instancetype)init{
    if (self = [super init]) {
        self.text_color = [UIColor redColor];
        self.placeholder_color = [UIColor grayColor];
        self.text_font = [UIFont systemFontOfSize:14];
        self.placeholder_font = [UIFont systemFontOfSize:14];
        self.ground_corlor = [UIColor whiteColor];
        self.border_corlor = [UIColor grayColor];
        self.cornerRadius = 5;
    }
    return self;
}
//允许输入的类型
-(BOOL)allowRule:(NSString *)text{
    if (!text.length)return YES;//删除字符直接return yes
    NSMutableArray *bool_type = [NSMutableArray new];
    for (NSNumber *type in self.allowInput) {
        if (type.integerValue == ruleNum) {
            //数字
            BOOL num = [NSString isNumberCharacter:text];
            [bool_type addObject:@(num)];
        }else if (type.integerValue == ruleCh){
            //中文
            BOOL ch = [NSString isChineseCharacter:text];
            [bool_type addObject:@(ch)];
        }else if (type.integerValue == ruleEn){
            //英文
            BOOL en = [NSString isEnglishCharacter:text];
            [bool_type addObject:@(en)];
        }else if (type.integerValue == ruleEmoji){
            //emoji
            BOOL emoji = [NSString isEmojiCharacter:text];
            [bool_type addObject:@(emoji)];
        }
    }
    for (NSNumber *number in bool_type) {
        if (number.boolValue) return YES;
    }
    return NO;
}

//禁止输入的类型
-(BOOL)enbleRule:(NSString *)text{
    if (!text.length)return YES;//删除字符直接return yes
    for (NSNumber *type in self.endbleInput) {
        if (type.integerValue == ruleNum) {
            //数字
            
            return [NSString isNumberCharacter:text] ? NO : YES;
            
        }else if (type.integerValue == ruleCh){
            //中文
            return [NSString isChineseCharacter:text] ? NO : YES;
            
        }else if (type.integerValue == ruleEn){
            //英文
            return [NSString isEnglishCharacter:text] ? NO : YES;
        }else if (type.integerValue == ruleEmoji){
            //emoji
            return [NSString isEmojiCharacter:text] ? NO : YES;
        }
    }
    
    return YES;
}

@end

@interface LRuleTextField ()

@property (copy   , nonatomic) NSString * lastString;
@property (assign , nonatomic) BOOL isFirst;
@property(assign , nonatomic)NSInteger hasNum;//已经输入了多少个

@end
@implementation LRuleTextField

-(instancetype)initWithManger:(void (^) (LRuleTextFieldManger *manger))mangerBlock{
    if (self = [super init]) {
        self.manger = [[LRuleTextFieldManger alloc]init];
        if (mangerBlock) {
            mangerBlock(self.manger);
        }
        
        [self setUpTextField];
        //监听输入文字的变化
        [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

-(void)setUpTextField{
    self.delegate = self;
    self.font = self.manger.text_font;
    self.textColor = self.manger.text_color;
    self.backgroundColor = self.manger.ground_corlor;
    self.secureTextEntry = self.manger.secureTextEntry;
    self.layer.cornerRadius = self.manger.cornerRadius;
    
    //修改占位符的颜色以及大小
    [self setUpPlaceholder];
    //设置右边图片
    [self setUpRightImage];
    //设置左边图片
    [self setUpLeftImage];
}

//设置占位符
-(void)setUpPlaceholder{
    if (!self.manger.placeholder) return;
    NSString *holderText = self.manger.placeholder;
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                            value:self.manger.placeholder_color
                            range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                            value:self.manger.placeholder_font
                            range:NSMakeRange(0, holderText.length)];
    self.attributedPlaceholder = placeholder;
}

//设置右边的图片
-(void)setUpRightImage{
    if (!self.manger.rightImage)return;
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, self.manger.rightSize.width, self.manger.rightSize.height);
    UIImageView *rightView = [[UIImageView alloc]init];
    [backView addSubview:rightView];
    
    rightView.image = self.manger.rightImage;
    [rightView sizeToFit];
    CGFloat width = rightView.image.size.width;
    CGFloat height =rightView.image.size.height;
    CGFloat left = (self.manger.rightSize.width - width)/2.0;
    CGFloat top =(self.manger.rightSize.height - height)/2.0;
    rightView.frame = CGRectMake(left, top, width ,height);
    rightView.backgroundColor = [UIColor clearColor];
    self.rightView = backView;
    self.rightViewMode = UITextFieldViewModeAlways;
}

//创建左边的图片
-(void)setUpLeftImage{
    if (!self.manger.leftImage)return;
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, 0, self.manger.leftSize.width, self.manger.leftSize.height);
    UIImageView *leftView = [[UIImageView alloc]init];
    [backView addSubview:leftView];
    
    leftView.image = self.manger.leftImage;
    [leftView sizeToFit];
    CGFloat width = leftView.image.size.width;
    CGFloat height =leftView.image.size.height;
    CGFloat left = (self.manger.leftSize.width - width)/2.0;
    CGFloat top =(self.manger.leftSize.height - height)/2.0;
    leftView.frame = CGRectMake(left, top, width ,height);
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = backView;
    
    self.leftViewMode = UITextFieldViewModeAlways;
}

//设置内边距
-(CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, self.manger.inset_about, self.manger.inset_up_down);
}

// 控制文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds{
  
    return CGRectInset(bounds, self.manger.inset_about, self.manger.inset_up_down);
}

//监听的方法
-(void)textFieldChanged:(UITextField *)textField {
   
    //最大输入字数限制
    [self maxNumberJudge];
    //输入监听
    [self monitorTextChage];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
  
    if (self.manger.monitorTextChage) return YES;//监听输入情况的时候 按回车键不返回数据
    
    if ([self.adegate respondsToSelector:@selector(lruleTextChange:andObject:)]) {
        [self.adegate lruleTextChange:self.text andObject:self];
    }
    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (self.manger.allowInput.count) {
        return  [self.manger allowRule:string];
    }else if (self.manger.endbleInput.count){
        return [self.manger enbleRule:string];
    }
    
    return YES;
}

/**
 对输入内容 的监听
 */
-(void)monitorTextChage{
    if (!self.manger.monitorTextChage) return;
    if ([self.adegate respondsToSelector:@selector(lruleTextChange:andObject:)]) {
        [self.adegate lruleTextChange:self.text andObject:self];
    }
}

/**
 
 最大输入字数限制
 */
-(void)maxNumberJudge{
    if (self.manger.maxNum <= 0) return;
    NSString *toBeString = self.text;
    NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];// 键盘输入模式
    if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if(!position) {
            //最多输入多少字
            [self deleteText:toBeString];
            self.lastString = self.text;
        }else{
            //有高亮选择的字符串，则暂不对文字进行统计和限制
            return;
        }
    }
    //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        //最多输入多少字
        [self deleteText:toBeString];
        self.lastString = self.text;
    }
}

//截取字符串
-(void)deleteText:(NSString *)toBeString{
    NSInteger  len = 0;
    switch (self.manger.numberRule) {
        case ruleNum:
        {
            //苹果的length统计
            if (toBeString.length >= self.lastString.length) {
                len = [[toBeString substringFromIndex:self.lastString.length] length];
            }
            if(self.lastString.length +len > self.manger.maxNum) {
                self.text = [self.text substringToIndex:self.lastString.length];
            }
            self.hasNum = self.text.length;
        }
            break;
        case ruleChar:
        {
            //字节统计（和微信输入昵称的判断一样）
            if ([toBeString lengthOfBytesUsingEncoding:NSUTF16StringEncoding] >= [self.lastString lengthOfBytesUsingEncoding:NSUTF16StringEncoding]) {
                len = [[toBeString substringFromIndex:self.lastString.length] lengthOfBytesUsingEncoding:NSUTF16StringEncoding];
            }
            if([self.lastString lengthOfBytesUsingEncoding:NSUTF16StringEncoding] +len > self.manger.maxNum) {
                self.text = [self.text substringToIndex:self.lastString.length];
            }
            
            self.hasNum = [self.text lengthOfBytesUsingEncoding:NSUTF16StringEncoding];
        }
            break;
        default:
            break;
    }
    
}
@end
