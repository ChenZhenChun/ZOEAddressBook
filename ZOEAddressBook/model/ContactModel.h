//
//  ContactModel.h
//  AiyoyouDemo
//
//  Created by aiyoyou on 2017/1/20.
//  Copyright © 2017年 aiyoyou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TelModel;

@interface ContactModel : NSObject

@property (nonatomic,copy) NSString *jobTitle;//头衔
@property (nonatomic,copy) NSString *anFullName;//全名
@property (nonatomic,copy) NSString *firstName;//名字
@property (nonatomic,copy) NSString *middleName;//中间名
@property (nonatomic,copy) NSString *lastName;//姓氏
@property (nonatomic,copy) NSString *firstNamePhonetic;//名字全拼
@property (nonatomic,copy) NSString *lastNamePhonetic;//姓氏全拼
@property (nonatomic,copy) NSString *middleNamePhonetic;//中间名汉语拼音
@property (nonatomic,copy) NSString *department;//部门
@property (nonatomic,copy) NSString *note;//备注
@property (nonatomic,copy) NSString *organization;//组织名
@property (nonatomic,copy) NSString *nickName;//昵称
@property (nonatomic,strong)UIImage *photo;//头像
@property (nonatomic,strong) NSMutableArray<TelModel*> *telList;//电话
@end

@interface TelModel : NSObject
@property (nonatomic,copy) NSString *telephone;//电话
@property (nonatomic,copy) NSString *type;//电话类别
@end
