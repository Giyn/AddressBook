//
//  AddViewController.h
//  AddressBook
//
//  Created by Admin on 2022/6/2.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@class AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end
