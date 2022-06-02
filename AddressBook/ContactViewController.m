//
//  ContactViewController.m
//  AddressBook
//
//  Created by Giyn on 2022/6/2.
//

#import "ContactViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"contacts.data"]

@interface ContactViewController () <UIActionSheetDelegate, AddViewControllerDelegate, EditViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactViewController

- (NSMutableArray *)contacts {
    if (!_contacts) {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加左上角注销按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem = item;
    
    // 根据传过来的用户名设置标题
    self.navigationItem.title = [NSString stringWithFormat:@"%@的联系人列表", self.username];
    
    // 取消分割线(iOS 8无效)
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // 解档联系人信息
    self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
}

// 某一组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"contact_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.textLabel.text = [self.contacts[indexPath.row] name];
    cell.detailTextLabel.text = [self.contacts[indexPath.row] number];
    
    return cell;
}

// 添加联系人的代理方法(逆传)
- (void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contact {
    [self.contacts addObject:contact];
    
    // 刷新
    [self.tableView reloadData];
    
    // 归档联系人信息
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kFilePath];
}

// 编辑联系人的代理方法
- (void)editViewController:(EditViewController *)editViewController withContact:(Contact *)contact {
    [self.tableView reloadData];
    
    // 归档联系人信息
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kFilePath];
}

// 只要走storyboard线 无论是自动型还是手动型都会调用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    
    // 判断目标控制器的真实类型
    if ([vc isKindOfClass:[AddViewController class]]) {
        // 设置代理
        AddViewController *add = (AddViewController*)vc;
        add.delegate = self;
    } else {
        // 顺传赋值
        EditViewController *edit = (EditViewController *)vc;
        edit.delegate = self; // 设置代理

        // 获取点击cell的位置(indexpath)
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        // 获取模型
        Contact *con = self.contacts[path.row];
        
        // 赋值
        edit.contact = con;
    }
}

// 注册注销点击事件
- (void)logOut {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"通知" message:@"确定要注销?" preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *reset = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sheet addAction:reset];
    [sheet addAction:cancel];

    // show
    [self presentViewController:sheet animated:YES completion:nil];
}

@end
