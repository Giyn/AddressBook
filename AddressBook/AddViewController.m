//
//  AddViewController.m
//  AddressBook
//
//  Created by Admin on 2022/6/2.
//

#import "AddViewController.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.numberField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 让姓名文本框成为第一响应者
    [self.nameField becomeFirstResponder];
}

- (void)addClick {
    // 判断代理方法是否能相应
    if ([self.delegate respondsToSelector:@selector(addViewController:withContact:)]) {
        Contact *con = [[Contact alloc] init];
        con.name = self.nameField.text;
        con.number = self.numberField.text;
        [self.delegate addViewController:self withContact:con];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textChange {
    self.addButton.enabled = self.nameField.text.length > 0 && self.numberField.text.length > 0;
}

@end
