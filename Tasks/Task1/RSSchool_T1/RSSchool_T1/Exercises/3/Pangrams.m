#import "Pangrams.h"

@implementation Pangrams

// Complete the pangrams function below.
- (BOOL)pangrams:(NSString *)string {
 
    NSString  *str = [[NSString alloc] initWithString:[[string lowercaseString]stringByReplacingOccurrencesOfString:@" " withString:@""]];
   NSMutableSet *setLetters= [[NSMutableSet alloc] init];
    for(int i =0; i<[str length];i++ ){
        NSString *letter = [[NSString alloc] initWithFormat:@"%c",[str characterAtIndex:i]];
        [setLetters addObject:letter];
        [letter release];
       }
    if([setLetters count] == 26){
        [str release];
        [setLetters release];
        return true;
    }
    else{
        [str release];
        [setLetters release];
        return false;
    }
}

@end
