//
//  EditViewController.h
//  AddressBook
//
//  Created by Admin on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@class EditViewController;

@protocol EditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(EditViewController *)editViewController withContact:(Contact *)contact;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *contact;

@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;

@end
