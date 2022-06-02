//
//  Contact.h
//  AddressBook
//
//  Created by Admin on 2022/6/2.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;

@end
