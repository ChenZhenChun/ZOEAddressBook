//
//  ContactModel.m
//  AiyoyouDemo
//
//  Created by aiyoyou on 2017/1/20.
//  Copyright © 2017年 aiyoyou. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel
- (NSMutableArray<TelModel *> *)telList {
    if (!_telList) {
        _telList = [[NSMutableArray alloc]init];
    }
    return _telList;
}
@end

@implementation TelModel

@end
