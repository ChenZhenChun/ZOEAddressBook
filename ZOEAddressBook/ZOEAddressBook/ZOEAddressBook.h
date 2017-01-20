//
//  XJAddressBook.h
//  iosDemo
//
//  Created by aiyoyou on 15/12/25.
//  Copyright © 2015年 zoe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"

@interface ZOEAddressBook : NSObject
- (void)getMemberListModel:(void (^)(NSMutableArray<ContactModel *> *data)) isSuccess;
@end
