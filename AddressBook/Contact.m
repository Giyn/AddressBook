//
//  Contact.m
//  AddressBook
//
//  Created by Admin on 2022/6/2.
//

#import "Contact.h"

@implementation Contact

// 告诉系统归档哪些属性
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_number forKey:@"number"];
}

// 告诉系统解档哪些属性
- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        _name = [coder decodeObjectForKey:@"name"];
        _number = [coder decodeObjectForKey:@"number"];
    }
    return self;
}

@end
