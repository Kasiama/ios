#import "Encryption.h"

@implementation Encryption

// Complete the encryption function below.
- (NSString *)encryption:(NSString *)string {
    double length = [string length];
    double lowerBorder = floor(sqrt(length));
    double upperBorder = ceil(sqrt(length));
    while (lowerBorder*upperBorder<length) {
        lowerBorder++;
    }
    NSMutableString *str = [[NSMutableString alloc] init];
    int countForLastSpace=0;
    
    for(int i =0;i<upperBorder;i++){
        int coun =0;
        for(int j =0;j<lowerBorder;j++){
            if(coun+i<[string length]){
             NSString *letter = [[NSString alloc] initWithFormat:@"%c",[string characterAtIndex:coun+i]];
            [str insertString:letter atIndex:str.length];
            [letter release];
            coun+=upperBorder;
            countForLastSpace++;
            }
        }
        if(countForLastSpace < [string length])
            [str insertString:@" " atIndex:str.length];
    }
    return str;
}

@end
