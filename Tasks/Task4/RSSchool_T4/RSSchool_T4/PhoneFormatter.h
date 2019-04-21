//
//  PhoneFormatter.h
//  RSSchool_T4
//
//  Created by Иван on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhoneFormatter : UIViewController
@property (retain,nonatomic) UITextField* phoneTextField;
@property(retain,nonatomic)  NSString *countryCode ;
@property(retain,nonatomic)   NSString *operatorCode;
@property(retain,nonatomic)   NSString *firstNum;
@property(retain,nonatomic)   NSString *secondNum;
@property(retain,nonatomic)   NSString *thirdNum;
@property(retain,nonatomic ) NSArray *codesofcountries;
@property(retain,nonatomic ) NSArray *flags;
@end

NS_ASSUME_NONNULL_END
