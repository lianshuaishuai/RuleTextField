//
//  ViewController.m
//  RuleTextFiled
//
//  Created by 连帅帅 on 2020/9/25.
//

#import "ViewController.h"
#import "LRuleTextField.h"
#import "LSSTextField.h"
@interface ViewController ()<LRuleTextFieldDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LRuleTextField *textField = [[LRuleTextField alloc]initWithManger:^(LRuleTextFieldManger * manger) {

        manger.placeholder = @"我是";
        manger.maxNum = 10;
        manger.cornerRadius = 8;
        manger.inset_about = 10;
    }];
    textField.adegate = self;
    textField.frame = CGRectMake(0, 200, 200, 30);
    [self.view addSubview:textField];
    
    
    LSSTextField *textField1 = [[LSSTextField alloc]initWithManger:^(LRuleTextFieldManger * manger) {
        
        manger.placeholder = @"我是1";
        manger.cornerRadius = 8;
        manger.inset_about = 10;
        manger.monitorTextChage = YES;
    }];
    textField1.adegate = self;
    textField1.frame = CGRectMake(0, 450, 200, 30);
    [self.view addSubview:textField1];
   
   
  
}

-(void)lruleNumber:(NSDictionary *)numberDic{
    NSLog(@"%@",numberDic);
}
@end
