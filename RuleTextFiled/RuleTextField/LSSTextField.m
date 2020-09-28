//
//  LSSTextField.m
//  RuleTextFiled
//
//  Created by 连帅帅 on 2020/9/25.
//

#import "LSSTextField.h"

@implementation LSSTextField
-(void)textFieldChanged:(UITextField *)textField{
    if ([textField.text hasPrefix:@"·"]||[textField.text hasSuffix:@"·"]||![self centerOneJudge:textField.text andchar: @"·"]) {
        //首尾不能为· 中间只能是一个·
        NSLog(@"错误");
        return;
    }
    [super textFieldChanged:textField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if ([textField.text hasPrefix:@"·"]||[textField.text hasSuffix:@"·"]||![self centerOneJudge:textField.text andchar: @"·"]) {
        //首尾不能为· 中间只能是一个·
        NSLog(@"错误");
        return YES;
    }
    return [super textFieldShouldReturn:textField];
}

-(BOOL)centerOneJudge:(NSString *)content andchar:(NSString *)c{
    int count = 0;
    for(int i = 0; i < [content length]; i++){
        
        unichar temp = [content characterAtIndex:i];
        
        if (temp == [c characterAtIndex:0]) count++;
    }
    
    if (count > 1) return NO;
    
    return YES;
}
@end
