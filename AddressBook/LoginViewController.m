//
//  LoginViewController.m
//  AddressBook
//
//  Created by Giyn on 2022/6/1.
//

#import "LoginViewController.h"
#import "MBProgressHUD+Ex.h"
#import "ContactViewController.h"

#define kUsernameKey @"kUsernameKey"
#define kPasswordKey @"kPasswordKey"
#define kRemPasswordKey @"kRemPasswordKey"
#define kAutoLoginKey @"kAutoLoginKey"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UISwitch *remPassword;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;

@end

@implementation LoginViewController

- (IBAction)remPasswordChange:(UISwitch *)sender {
    if (!sender.isOn) {
//        self.autoLogin.on = NO;
        [self.autoLogin setOn:NO animated:YES];
    }
}

- (IBAction)autoLoginChange:(UISwitch *)sender {
    if (sender.isOn) {
//        self.remPassword.on = YES;
        [self.remPassword setOn:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听文本框
    [self.usernameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];

    // 恢复开关状态
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.remPassword.on = [ud boolForKey:kRemPasswordKey];
    self.autoLogin.on = [ud boolForKey:kAutoLoginKey];
    // 恢复用户名密码
    self.usernameField.text = [ud objectForKey:kUsernameKey];
    if (self.remPassword.isOn) {
        self.passwordField.text = [ud objectForKey:kPasswordKey];
    }

    if (self.autoLogin.isOn) {
        [self login];
    }
    
    [self textChange];
}

- (void)login {
    [MBProgressHUD showMessage:@"正在登录"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 隐藏
        [MBProgressHUD hideHUD];
        
        // 当用户名和密码正确的时候跳转
        if ([self.usernameField.text isEqualToString:@"1"] && [self.passwordField.text isEqualToString:@"1"]) {
            [self performSegueWithIdentifier:@"login2contact" sender:nil];
            
            // 保存状态
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setBool:self.remPassword.isOn forKey:kRemPasswordKey];
            [ud setBool:self.autoLogin.isOn forKey:kAutoLoginKey];
            [ud setObject:self.usernameField.text forKey:kUsernameKey];
            [ud setObject:self.passwordField.text forKey:kPasswordKey];
            [ud synchronize]; // 立即写入
        } else {
            [MBProgressHUD showError:@"用户名或密码错误"];
        }
    });
}

// 走storyboard的线都会调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ContactViewController *contact = segue.destinationViewController;
    contact.username = self.usernameField.text;
}

// 文本框内容发生变化的时候调用
- (void)textChange {
    self.loginButton.enabled = self.usernameField.text.length > 0 && self.passwordField.text.length > 0;
}

@end
