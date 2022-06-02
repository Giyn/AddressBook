//
//  EditViewController.m
//  AddressBook
//
//  Created by Admin on 2022/6/2.
//

#import "EditViewController.h"

@interface EditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameField.text = self.contact.name;
    self.numberField.text = self.contact.number;
    
    [self.saveButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)saveClick {
    self.contact.name = self.nameField.text;
    self.contact.number = self.numberField.text;
    
    Contact *con = [[Contact alloc] init];
//    con.name = self.nameField.text;
//    con.number = self.numberField.text;
    
    if ([self.delegate respondsToSelector:@selector(editViewController:withContact:)]) {
        // 执行代理方法
        [self.delegate editViewController:self withContact:con];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editClick:(UIBarButtonItem *)sender {
    if (self.saveButton.hidden) {
        sender.title = @"取消";
        self.nameField.enabled = YES;
        self.numberField.enabled = YES;
        self.saveButton.hidden = NO;
        
        // 让电话文本框成为第一响应者
        [self.numberField becomeFirstResponder];
    } else {
        sender.title = @"编辑";
        self.nameField.enabled = NO;
        self.numberField.enabled = NO;
        self.saveButton.hidden = YES;
        
        // 恢复
        self.nameField.text = self.contact.name;
        self.numberField.text = self.contact.number;
    }
}

@end
