#import "Diagonal.h"

@implementation Diagonal

// Complete the diagonalDifference function below.
- (NSNumber *) diagonalDifference:(NSArray *)array {
   
    NSUInteger arrayCount = [array count];
    
    NSInteger SumFirstDiag=0;
    NSInteger SumSecondDiag=0;
    
    NSMutableArray *matr =[[NSMutableArray alloc] initWithCapacity:arrayCount];
    
    for(NSString *str in array){
        NSArray *row = [str componentsSeparatedByString:@" "];
        [matr addObject:row];
        [str release];
    }
    
    for(int i =0;i<arrayCount;i++){
        SumFirstDiag +=[(NSNumber*)matr[i][i] intValue];
        SumSecondDiag += [(NSNumber*)matr[i][arrayCount-i-1] intValue];
    }
    
    [matr release];
    
    return [NSNumber numberWithInt:abs(SumFirstDiag-SumSecondDiag)];

}

@end
