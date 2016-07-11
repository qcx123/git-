//
//  LoginViewController.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/29.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRequest.h"
#import "RegisterViewController.h"

@interface LoginViewController()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;


@end


@implementation LoginViewController

- (IBAction)loginAction:(id)sender {
    
    // 登录
    [self login];

}

- (IBAction)registerAction:(id)sender {
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    RegisterViewController *RVC = [mainSB instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self presentViewController:RVC animated:YES completion:nil];
    
}


- (void)login{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"提示" preferredStyle:(UIAlertControllerStyleAlert)];
    // 验证 判断用户名密码
    if(self.userNameTextField.text.length == 0){
    
        alertController.message = @"用户名为空";
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }else if (self.passWordTextField.text.length == 0){
    
        alertController.message = @"密码为空";
        UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertController addAction:OKAction];
        [self presentViewController:alertController animated:YES completion:nil];

        
    }else{
    
        LoginRequest *loginRequest = [[LoginRequest alloc] init];
        [loginRequest loginRequestWithUserName:_userNameTextField.text passWord:_passWordTextField.text success:^(NSDictionary *dic) {
            NSLog(@"1,%@",dic);
            long code = [[dic objectForKey:@"code"] longValue];
            if (code == 1103) {
                NSString *avatar = [[dic objectForKey:@"data"] objectForKey:@"avatar"];
                NSString *userId = [[dic objectForKey:@"data"] objectForKey:@"userId"];
                // 保存头像和id到本地
                [[NSUserDefaults standardUserDefaults] setObject:avatar forKey:@"avatar"];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
                // 保存
                [[NSUserDefaults standardUserDefaults] synchronize];            
                // 登陆成功后消失
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            NSLog(@"0,%@",error);
        }];
        
    }
        
    
    
}


@end
