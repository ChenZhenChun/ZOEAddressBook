//
//  XJAddressBook.m
//  iosDemo
//
//  Created by aiyoyou on 15/12/25.
//  Copyright © 2015年 zoe. All rights reserved.
//

#import "ZOEAddressBook.h"
#import <AddressBook/AddressBook.h>


@interface ZOEAddressBook()
{
    CFErrorRef error;
}
@property (nonatomic, strong) NSArray *listContacts;
@property (nonatomic) ABAddressBookRef addressBook;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ZOEAddressBook

#pragma mark-init

- (NSArray *)listContacts {
    if (!_listContacts) {
        _listContacts = [[NSArray alloc]init];
    }
    return _listContacts;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (ABAddressBookRef)addressBook {
    if (!_addressBook) {
        _addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    }
    return _addressBook;
}


#pragma mark-action

- (NSMutableArray <ContactModel *> *)getAllContacts {
    if (ABAddressBookGetAuthorizationStatus()!=kABAuthorizationStatusAuthorized) {
        return nil;
    }
    _listContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(self.addressBook);
    [self.dataSource removeAllObjects];
    for (int k=0; k<self.listContacts.count; k++) {
        ContactModel *model = [[ContactModel alloc]init];
        [self.dataSource addObject:model];
        
        ABRecordRef person = (__bridge ABRecordRef)self.listContacts[k];
        model.jobTitle = (__bridge NSString *)ABRecordCopyValue(person, kABPersonJobTitleProperty);//头衔
        model.anFullName = (__bridge NSString *)(ABRecordCopyCompositeName(person));//全名
        model.firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);//名字
        model.middleName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);//中间名
        model.lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);//姓氏
        model.firstNamePhonetic = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNamePhoneticProperty);//名字汉语拼音
        model.lastNamePhonetic = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNamePhoneticProperty);//姓氏汉语拼音
        model.middleNamePhonetic = (__bridge NSString *)ABRecordCopyValue(person, kABPersonMiddleNamePhoneticProperty);//中间名汉语拼音
        model.department = (__bridge NSString *)ABRecordCopyValue(person, kABPersonDepartmentProperty);//部门
        model.note = (__bridge NSString *)ABRecordCopyValue(person, kABPersonNoteProperty);//备注
        model.organization = (__bridge NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);//组织名
        model.nickName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonNicknameProperty);//昵称
        //获取头像
        NSData *imageData = (__bridge NSData*)ABPersonCopyImageData(person);
        model.photo = [UIImage imageWithData:imageData];
        //电话号码
        ABMultiValueRef phoneNumberProperty = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSArray *phoneNumberArray = (__bridge NSArray*)ABMultiValueCopyArrayOfAllValues(phoneNumberProperty);
        for (int i=0; i<phoneNumberArray.count; i++) {
            TelModel *telListModel = [[TelModel alloc]init];
            [model.telList addObject:telListModel];
            NSString *phoneNumber = [self formatPhoneNumber:phoneNumberArray[i]];
            NSString *phoneNumberLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phoneNumberProperty, i);
            NSString *type = @"";
            if ([phoneNumberLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel]) {
                type = @"手机";
            }else if ([phoneNumberLabel isEqualToString:(NSString *)kABPersonPhoneIPhoneLabel]) {
                type = @"iphone";
            }else if ([phoneNumberLabel isEqualToString:(NSString *)kABPersonPhoneMainLabel]) {
                type = @"主要";
            }else if ([phoneNumberLabel isEqualToString:@"_$!<Home>!$_"]) {
                type = @"住宅";
            }else if ([phoneNumberLabel isEqualToString:@"_$!<Work>!$_"]) {
                type = @"工作";
            }else if ([phoneNumberLabel isEqualToString:@"_$!<Other>!$_"]) {
                type = @"其他";
            }else {
                type = @"";
            }
            telListModel.telephone = phoneNumber;
            telListModel.type = type;
        }
    }
    return self.dataSource;
}

- (NSString *)formatPhoneNumber:(NSString *)phoneNO {
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"-" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@"(" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@")" withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@" " withString:@""];
    phoneNO = [phoneNO stringByReplacingOccurrencesOfString:@" " withString:@""];
    return phoneNO;
}

- (void)getMemberListModel:(void (^)(NSMutableArray<ContactModel *> *))isSuccess {
    error = NULL;
    ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                isSuccess([self getAllContacts]);
            }else {
                isSuccess(self.dataSource);
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"您需要进入手机的设置中设置允许访问手机通讯录" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            }
        });
        
    });
}

@end
