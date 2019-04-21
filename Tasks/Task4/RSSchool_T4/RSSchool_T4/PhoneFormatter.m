//
//  PhoneFormatter.m
//  RSSchool_T4
//
//  Created by Иван on 4/19/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "PhoneFormatter.h"



@implementation PhoneFormatter
@synthesize codesofcountries = _codesofcountries;
@synthesize flags = _flags;
bool is3Has1space = NO;
bool is3Has2space = NO;
bool is7Has1Space = NO;
bool is7Has2Space = NO;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *a =  [[NSArray alloc]  initWithObjects:@"373",@"374",@"375",@"380",@"992",@"993",@"994",@"996",@"998",nil];
  NSArray *b =  [[NSArray alloc] initWithObjects:@"flag_MD.png",@"flag_AM.png",@"flag_BY.png",@"flag_UA.png",@"flag_TJ.png",@"flag_TM.png",@"flag_AZ.png",@"flag_KG.png",@"flag_UZ.png", nil];
    _codesofcountries = [[NSArray alloc] initWithArray:a];
    _flags = [[NSArray alloc] initWithArray:b];
    [a release];
    [b release];
    UITextField *txt=[[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.bounds.size.width-20, 50)];
    self.phoneTextField = txt;
    [txt release];
    self.phoneTextField.placeholder = @"Input phone number";
    self.phoneTextField.textAlignment = NSTextAlignmentCenter;
    self.phoneTextField.layer.cornerRadius = 20;
    self.phoneTextField.layer.borderWidth = 1.4f;
    self.phoneTextField.layer.borderColor = [UIColor blackColor].CGColor;
    self.phoneTextField.tag = 1;
    [_phoneTextField setLeftViewMode:UITextFieldViewModeAlways];
    [self.phoneTextField setTextColor:[UIColor redColor]];
    [self.phoneTextField addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
    self.phoneTextField.delegate=self;
    [self.view addSubview:self.phoneTextField];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890+"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
- (void)textFieldDidChange:(UITextField *)textField {
    textField.text = [self formatphoneNumber:textField.text];
    }


-(NSString*)formatphoneNumber:(NSString*)string{
   NSLog(@"taormat: %@", string);
    if(string.length>0 && ([[string substringFromIndex:0] hasPrefix:@"7"] ||([[string substringFromIndex:1] hasPrefix:@"7"]&& [[string substringFromIndex:0] hasPrefix:@"+"])))
        return [self formattedPhoneNumberwhith7:string];
    else
        return [self formattedPhoneNumberWhith39:string];
}


-(NSString *) formattedPhoneNumberWhith39:(NSString*) phoneNumber{
    if(phoneNumber.length>17){
        return [self formattedPhoneNumberWhith39:[phoneNumber substringToIndex:phoneNumber.length-1]];
    }
    if([phoneNumber isEqualToString:@""])
       return phoneNumber;
    if(phoneNumber.length==14)
        is3Has1space=YES;
    if(phoneNumber.length==17)
        is3Has2space=YES;
    NSMutableString *result = [[NSMutableString alloc]init ];
    NSString *numbers = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
     numbers = [numbers stringByReplacingOccurrencesOfString:@" " withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"+" withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"-" withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@")" withString:@""];

    [result appendString:@"+"];
    if(phoneNumber.length>=12 && ![[phoneNumber substringFromIndex:11] hasPrefix:@"-"]  && ![[phoneNumber substringFromIndex:10] hasPrefix:@"-"] && ![[phoneNumber substringFromIndex:12] hasPrefix:@"-"]&& ![[phoneNumber substringFromIndex:1] hasPrefix:@"("] && ![[phoneNumber substringFromIndex:5] hasPrefix:@")"] && is3Has1space ){
        [result appendString:[numbers substringToIndex:7]];
        [result appendString:[numbers substringFromIndex:8]];
        if(result.length==12)
            is3Has1space=NO;
       [result autorelease];
       return  [self formattedPhoneNumberWhith39:result];
    }
    if(phoneNumber.length>=15 && ![[phoneNumber substringFromIndex:14] hasPrefix:@"-"]  && ![[phoneNumber substringFromIndex:13] hasPrefix:@"-"] && ![[phoneNumber substringFromIndex:15] hasPrefix:@"-"] && ![[phoneNumber substringFromIndex:1] hasPrefix:@"("] && ![[phoneNumber substringFromIndex:5] hasPrefix:@")"] && is3Has2space ){
        [result appendString:[numbers substringToIndex:9]];
        [result appendString:[numbers substringFromIndex:10]];
        if(result.length==15)
            is3Has2space=NO;
        is3Has1space=NO;
        [result autorelease];
        return  [self formattedPhoneNumberWhith39:result];
    }
   
    
    if( (([phoneNumber rangeOfString:@")"].location == NSNotFound) && ([phoneNumber rangeOfString:@"("].location == NSNotFound))||
       (!([phoneNumber rangeOfString:@")"].location == NSNotFound) && !([phoneNumber rangeOfString:@"("].location == NSNotFound))){
        _phoneTextField.leftView= nil;
        if(numbers.length <=2){
            [result appendString:numbers];
             [result autorelease];
            return result;
            
        }
        if(numbers.length ==3 ){
            _countryCode = [numbers substringToIndex:3];
            [result appendString:_countryCode];
        }
        if(numbers.length>3 && numbers.length<=5){
            _countryCode = [numbers substringToIndex:3];
            _operatorCode = [numbers substringFromIndex:3];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
        }
        
        if(numbers.length>5 && numbers.length<=8){
            _countryCode = [numbers substringToIndex:3];
            _operatorCode = [numbers substringWithRange:NSMakeRange(3, 2)];
            _firstNum =[numbers substringFromIndex:5];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
            is3Has1space= NO;
            is3Has2space=NO;
        }
        if(numbers.length>8 && numbers.length<=10){
            
            _countryCode = [numbers substringToIndex:3];
            _operatorCode = [numbers substringWithRange:NSMakeRange(3, 2)];
            _firstNum = [numbers substringWithRange:NSMakeRange(5, 3)];
            _secondNum = [numbers substringFromIndex:8];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
            if(numbers.length>7){
                is3Has1space=YES;
                is3Has2space=NO;
                [result appendString:@"-"];
            }
            [result appendString:_secondNum];
            
        }
        if(numbers.length ==11){
            _countryCode = [numbers substringToIndex:3];
              _operatorCode = [numbers substringWithRange:NSMakeRange(3, 2)];
              _firstNum = [numbers substringWithRange:NSMakeRange(5, 3)];
              _secondNum = [numbers substringWithRange:NSMakeRange(8, 3)];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
            [result appendString:@"-"];
            [result appendString:_secondNum];
            is3Has1space=YES;
            is3Has2space=NO;
        }
        if(numbers.length==12){
            _countryCode = [numbers substringToIndex:3];
            _operatorCode = [numbers substringWithRange:NSMakeRange(3, 2)];
            _firstNum = [numbers substringWithRange:NSMakeRange(5, 3)];
            _secondNum = [numbers substringWithRange:NSMakeRange(8, 2)];
            _thirdNum = [numbers substringFromIndex:10];
            if([_countryCode isEqualToString:@"373"]||[_countryCode isEqualToString:@"374"]){
                [result release];
                return [self formattedPhoneNumberWhith39:[numbers substringToIndex:numbers.length-1]];
            }
                
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
            [result appendString:@"-"];
            [result appendString:_secondNum];
            if(numbers.length>9){
                is3Has1space=YES;
                is3Has2space= YES;
                [result appendString:@"-"];
                
            }
            [result appendString:_thirdNum];
            
        }
        NSUInteger i = [_codesofcountries indexOfObject:_countryCode];
        if(i<=9){
            UIImageView *tmp =[[UIImageView alloc] initWithImage:[UIImage imageNamed:[_flags objectAtIndex:i]]];
         _phoneTextField.leftView= tmp;
            [tmp release];
        }
        
        
        if([_operatorCode  isEqual: @""]){
            [result appendString:_countryCode];
            [result autorelease];
            return result;
        }
        
        [result autorelease];
        return result;
    }
    
    else if( [phoneNumber rangeOfString:@")"].location == NSNotFound && !([phoneNumber rangeOfString:@"("].location == NSNotFound)){
        if(_operatorCode.length ==1)
        {
            [result appendString:_countryCode];
            [result autorelease];
            return result;
        }
        if(![_firstNum isEqualToString:@""] && _firstNum!=nil){
            [result appendString:[numbers substringToIndex:4]];
            [result appendString:[numbers substringFromIndex:5]];
            [result autorelease];
            return [self formattedPhoneNumberWhith39:result];
        }
        _operatorCode = [_operatorCode substringToIndex:_operatorCode.length-1];
        [result appendString:_countryCode];
        [result appendString:@"("];
        [result appendString:_operatorCode];
        [result appendString:@")"];
        if(numbers.length>6){
            [result appendString:_firstNum];
        }
        if(numbers.length>8){
            [result appendString:@"-"];
            [result appendString:_secondNum];
        }
        if(numbers.length>10){
            [result appendString:@"-"];
            [result appendString:_thirdNum];
        }
        [result autorelease];
        return result;
    }
    else{
                  [result appendString:[numbers substringToIndex:2]];
                  [result appendString:[numbers substringFromIndex:3]];
        [result autorelease];
        is3Has1space =NO;
        is3Has2space = NO;
        return [self formattedPhoneNumberWhith39:result];
    }
}






-(NSString *) formattedPhoneNumberwhith7:(NSString*) phoneNumber{
    NSString *numbers = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
     numbers = [numbers stringByReplacingOccurrencesOfString:@"-" withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@"+" withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@" " withString:@""];
    numbers = [numbers stringByReplacingOccurrencesOfString:@")" withString:@""];
     NSMutableString *result = [[NSMutableString alloc]init ];
     [result appendString:@"+"];
    if(phoneNumber.length>16){
        [result release];
        return [self formattedPhoneNumberwhith7:[phoneNumber substringToIndex:phoneNumber.length-1]];
    }
    if([phoneNumber isEqualToString:@""]){
        [  result release ];
        return phoneNumber;
    }
   if(phoneNumber.length==13)
        is3Has1space=YES;
    if(phoneNumber.length==16)
        is3Has2space=YES;
    
    if(phoneNumber.length>=11 && ![[phoneNumber substringFromIndex:10] hasPrefix:@" "]  && ![[phoneNumber substringFromIndex:9] hasPrefix:@" "] && ![[phoneNumber substringFromIndex:11] hasPrefix:@" "] && ![[phoneNumber substringFromIndex:3] hasPrefix:@"("] && is7Has1Space ){
        [result appendString:[numbers substringToIndex:6]];
        [result appendString:[numbers substringFromIndex:7]];
        if(result.length==11)
            is7Has1Space=NO;
        [result autorelease];
        return  [self formattedPhoneNumberwhith7:result];
    }
    if(phoneNumber.length>=14 && ![[phoneNumber substringFromIndex:13] hasPrefix:@" "]  && ![[phoneNumber substringFromIndex:12] hasPrefix:@" "] && ![[phoneNumber substringFromIndex:14] hasPrefix:@" "] && ![[phoneNumber substringFromIndex:3] hasPrefix:@"("]&& is7Has2Space ){
        [result appendString:[numbers substringToIndex:8]];
        [result appendString:[numbers substringFromIndex:9]];
        if(result.length==1)
            is7Has2Space=NO;
        is7Has1Space=NO;
        [result autorelease];
        return  [self formattedPhoneNumberwhith7:result];
    }
    
    if( (([phoneNumber rangeOfString:@")"].location == NSNotFound) && ([phoneNumber rangeOfString:@"("].location == NSNotFound))||
       (!([phoneNumber rangeOfString:@")"].location == NSNotFound) && !([phoneNumber rangeOfString:@"("].location == NSNotFound))){
        if(numbers.length == 0)
        {
            [result release];
            return numbers;
        }
        if(numbers.length ==1 ){
        _countryCode = [numbers substringToIndex:1];
             [result appendString:_countryCode];
            is7Has1Space=NO;
            is7Has2Space=NO;
        }
       
        if(numbers.length>1 && numbers.length<=4){
            _countryCode = [numbers substringToIndex:1];
        _operatorCode = [numbers substringFromIndex:1];
             [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            _firstNum = @"";
            is7Has1Space=NO;
            is7Has2Space=NO;
        }

        if(numbers.length>4 && numbers.length<=7){
            _countryCode = [numbers substringToIndex:1];
        _operatorCode = [numbers substringWithRange:NSMakeRange(1, 3)];
        _firstNum =[numbers substringFromIndex:4];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
            is7Has1Space=NO;
            is7Has2Space=NO;
        }
        if(numbers.length>7 && numbers.length<=9){
            _countryCode = [numbers substringToIndex:1];
              _operatorCode = [numbers substringWithRange:NSMakeRange(1, 3)];
            _firstNum = [numbers substringWithRange:NSMakeRange(4, 3)];
            _secondNum = [numbers substringFromIndex:7];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
            if(numbers.length>7){
             [result appendString:@" "];
                is7Has1Space=YES;
            }
             [result appendString:_secondNum];
            is7Has2Space=NO;
        }
        if(numbers.length>9 && numbers.length<=11){
            _countryCode = [numbers substringToIndex:1];
            _operatorCode = [numbers substringWithRange:NSMakeRange(1, 3)];
            _firstNum = [numbers substringWithRange:NSMakeRange(4, 3)];
            _secondNum = [numbers substringWithRange:NSMakeRange(7, 2)];
            _thirdNum = [numbers substringFromIndex:9];
            [result appendString:_countryCode];
            [result appendString:@"("];
            [result appendString:_operatorCode];
            [result appendString:@")"];
            [result appendString:_firstNum];
                [result appendString:@" "];
            [result appendString:_secondNum];
            if(numbers.length>9){
                [result appendString:@" "];
                is7Has1Space=YES;
                is7Has2Space=YES;
            }
            [result appendString:_thirdNum];
            
        }
        if([_operatorCode hasPrefix:@"7"]){
            UIImageView *tmp =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag_KZ.png"]];
            _phoneTextField.leftView= tmp;
            [tmp release];
        }
        else{
            UIImageView *tmp =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag_RU.png"]];
            _phoneTextField.leftView= tmp;
            [tmp release];
        }
          if(numbers.length>11)
            [result appendString:[numbers substringToIndex:numbers.length-1]];
        if([_operatorCode  isEqual: @""]){
            [result release];
            return  _countryCode;
        }
        [result autorelease];
    return result;
    }
    
    else if( [phoneNumber rangeOfString:@")"].location == NSNotFound && !([phoneNumber rangeOfString:@"("].location == NSNotFound)){
        if(_operatorCode.length ==1)
        {
            [result appendString: _countryCode];
            [result autorelease];
            return result;
        }
        if(![_firstNum isEqualToString:@""]&& _firstNum!=nil){
            [result appendString:[numbers substringToIndex:3]];
            [result appendString:[numbers substringFromIndex:4]];
            [result autorelease];
            return [self formattedPhoneNumberwhith7:result];
        }
        _operatorCode = [_operatorCode substringToIndex:_operatorCode.length-1];
        [result appendString:_countryCode];
        [result appendString:@"("];
        [result appendString:_operatorCode];
        [result appendString:@")"];
        if(numbers.length>6){
        [result appendString:_firstNum];
        }
        if(numbers.length>8){
        [result appendString:@" "];
        [result appendString:_secondNum];
        }
        if(numbers.length>10){
            [result appendString:@" "];
        [result appendString:_thirdNum];
        }
        [result autorelease];
        return result;
    }
    else{
        [result appendString:[numbers substringToIndex:0]];
        [result appendString:[numbers substringFromIndex:1]];
        is7Has1Space=NO;
        is7Has2Space=NO;
        if([[result substringFromIndex:1 ] hasPrefix:@"7"])
        {
            [result autorelease];
        return [self formattedPhoneNumberwhith7:result];
        }
        else{
            [result autorelease];
             return [self formattedPhoneNumberWhith39:result];
        }
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView * txt in self.view.subviews){
        if ([txt isKindOfClass:[UITextField class]] && [txt isFirstResponder]) {
            [txt resignFirstResponder];
        }
    }
}
- (void)dealloc
{
    [_countryCode release];
    [_operatorCode release];
    [_firstNum release];
    [_secondNum release];
    [_thirdNum release];
    [_phoneTextField release];
    [_flags release];
    [_codesofcountries release];
    [super dealloc];
}
@end
