//
//  LRuleTextView.m
//  RuleTextFiled
//
//  Created by 连帅帅 on 2020/9/30.
//

#import "LRuleTextView.h"
#import "NSString+LSString.h"
@implementation LRuleTextViewManger
-(instancetype)init{
    if (self = [super init]) {
        self.text_color = [UIColor redColor];
        self.placeholder_color = [UIColor grayColor];
        self.placeholder_font = self.text_font = [UIFont systemFontOfSize:14];
        self.bottom_font_float = 14;
        self.ground_corlor = [UIColor whiteColor];
        self.border_corlor = [UIColor grayColor];
        self.cornerRadius = 5;
        self.inset_about = self.inset_up_down = 8;
        self.placeholder = @"请输入内容...";
        self.bottom_all_color = [UIColor grayColor];
        self.bottom_num_color = [UIColor grayColor];
        
    }
    return self;
}
@end

@interface  LRuleTextView ()<UITextViewDelegate>
@property(nonatomic, strong)LRuleTextViewManger *manger;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)UILabel *placeholderLabel;
@property(nonatomic, strong)UILabel *bottomLabel;
@end
@implementation LRuleTextView
-(instancetype)initWithManger:(void (^) (LRuleTextViewManger *manger))mangerBlock{
    if (self = [super init]) {
        self.manger = [[LRuleTextViewManger alloc]init];
       
        if (mangerBlock) {
            mangerBlock(self.manger);
        }
        [self setUpSubView];
        [self setUp];
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        self.manger = [[LRuleTextViewManger alloc]init];
        [self setUpSubView];
        [self setUp];
    }
    return self;
}

//创建view
-(void)setUpSubView{
    [self addSubview:self.textView];
    
    [self addSubview:self.placeholderLabel];
    
    if (self.manger.maxNum) [self addSubview:self.bottomLabel];
    
}

-(void)setUp{
    self.layer.cornerRadius = self.manger.cornerRadius;
    self.clipsToBounds = YES;
    if (self.manger.tintColor) self.tintColor = self.manger.tintColor;
}

-(void)updateConstraints{
    
    CGFloat textBotom = self.manger.maxNum ? self.manger.inset_up_down + 16 : self.manger.inset_up_down;
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.manger.inset_about],
        [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.manger.inset_about],
        [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.manger.inset_up_down],
        [NSLayoutConstraint constraintWithItem:self.textView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-textBotom]]];
    
    [self addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.placeholderLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:self.manger.inset_about],
        [NSLayoutConstraint constraintWithItem:self.placeholderLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.manger.inset_about],
        [NSLayoutConstraint constraintWithItem:self.placeholderLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:self.manger.inset_up_down]]];
    
    
    if (self.manger.maxNum) {
        
        [self addConstraints:@[
           
            [NSLayoutConstraint constraintWithItem:self.bottomLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.manger.inset_about],
            [NSLayoutConstraint constraintWithItem:self.bottomLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-self.manger.inset_up_down]]];
    }
    
    [super updateConstraints];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    self.placeholderLabel.hidden = textView.text.length ? YES : NO;
    [self setUpBottomAttributedString];
    //超过最大内容设置为yes （点击提交的时候判断此字段即可）
    if (textView.text.length > self.manger.maxNum && self.manger.maxNum)self.exceedMax = YES;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.delegate = self;
        _textView.textColor = self.manger.text_color;
        _textView.font = self.manger.text_font;
        _textView.backgroundColor = self.manger.ground_corlor;
        _textView.translatesAutoresizingMaskIntoConstraints = NO;
        _textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0);
    }
    return _textView;
}

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.textColor = self.manger.placeholder_color;
        _placeholderLabel.font = self.manger.placeholder_font;
        _placeholderLabel.text = self.manger.placeholder;
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
       
    }
    return _placeholderLabel;
}

-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.textColor = self.manger.bottom_all_color;
        _bottomLabel.font = [UIFont systemFontOfSize:self.manger.bottom_font_float];
        _bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self setUpBottomAttributedString];
    }
    return _bottomLabel;
}

// 设置底部文字的颜色
-(void)setUpBottomAttributedString{
    if (!self.manger.maxNum) return;
    self.manger.bottom_num_color = (self.textView.text.length > self.manger.maxNum) ? [UIColor redColor] : self.manger.bottom_all_color;
   
    NSMutableAttributedString *all_Attributed = [NSString setUpLabelAttri:[NSString stringWithFormat:@"/%ld",self.manger.maxNum] andFloat:self.manger.bottom_font_float andCor:self.manger.bottom_all_color];
    NSString * num_text = self.textView.text.length ? [NSString stringWithFormat:@"%ld",self.textView.text.length] : @"0";
    NSMutableAttributedString *num_Attributed = [NSString setUpLabelAttri:num_text andFloat:self.manger.bottom_font_float andCor:self.manger.bottom_num_color];
    _bottomLabel.attributedText = [NSString setUpAppendAttribued:@[num_Attributed,all_Attributed]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
