#import "ArrayPrint.h"
@implementation NSArray (RSSchool_Extension_Name)
- (NSString *)print{
    NSArray *array = self;
    NSMutableString *res = [[NSMutableString alloc] init];
    [res appendString:@"["];
    
    for (int i = 0; i < [array count]; i++)
        [res appendString: objToString(array[i])];
    
    [res appendString:@"]"];
    [res replaceOccurrencesOfString:@",]" withString:@"]" options:0 range: NSMakeRange(0, [res length])];
    [res autorelease];
    return res;
}

NSString *objToString(id object) {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    if ([object isKindOfClass:[NSNumber class]])
        [resultString appendFormat:@"%@,", object];
    
        else if ([object isKindOfClass:[NSNull class]])
             [resultString appendString: @"null,"];
            else if ([object isKindOfClass:[NSArray class]]){
            [resultString appendString:@"["];
            for (id obj in object)
                [resultString appendString: objToString(obj)];
                
            [resultString appendString:@"],"];
        }
    
    else if([object isKindOfClass:[NSString class]])
        [resultString appendFormat:@"\"%@\",", object];
    
    else
            [resultString appendString:@"unsupported,"];
    
    [resultString autorelease];
    return resultString;
}



@end
