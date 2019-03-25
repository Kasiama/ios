#import "SummArray.h"

@implementation SummArray

// Complete the summArray function below.
- (NSNumber *)summArray:(NSArray *)array {
    double sum = 0;
    
    for (int i =0;i<[array count];i++) {
        sum += [array[i] intValue];
        
    }
    
    return [NSNumber numberWithDouble:sum];

}

@end
