#import "Sorted.h"

@implementation ResultObject
@end

@implementation Sorted
int pos1;
int pos2;

BOOL swapfunc(NSMutableArray* arr){
    pos1=0;
    pos2 =1;
    BOOL forBreak = false;
    for(int i =1;i<[arr count];i++){
        if([arr[i-1] integerValue] >[arr[i] integerValue]){
            pos1=i-1;
            for (int j = i; j<[arr count]-1; j++) {
                if([arr[j] integerValue]>[arr[j+1]integerValue]){
                    if(j+1<[arr count])
                    pos2=j+1;
                    forBreak = true;
                    break;
                }
            }
        }
        if(forBreak)
            break;
    }
    
   NSNumber*  tmp = arr[pos2];
    arr[pos2]= arr[pos1];
    arr[pos1]=tmp;
    
    for(int i =0;i<[arr count]-1;i++){
        if([arr[i]integerValue]>[arr[i+1]integerValue])
            return false;
    }
    return true;
}

BOOL reverse(NSMutableArray* arr){
    int i=0;
    for ( i = 1;i<[arr count];i++){
        if([arr[i-1] integerValue]> [arr[i] integerValue]){
            break;
        }
    }
    if(i == [arr count])
        return true;
    
    pos1 = i-1;
    int j =i;
    while([arr[j-1]integerValue]>[arr[j] integerValue]){
        j++;
    }
    
    pos2=j-1;
    NSMutableArray* tmp = [[NSMutableArray alloc] init];
    for(int i =0;i<pos1;i++){
        [tmp addObject:arr[i]];
    }
    for(int i =pos2;i>=pos1;i--){
        [tmp addObject:arr[i]];
        
    }
    for(int i =pos2+1;i<[arr count];i++){
        [tmp addObject:arr[i]];
    }
    
    for(int i =0;i<[arr count]-1;i++){
        if([tmp[i] integerValue]>[tmp[i+1]integerValue]){
            [tmp release];
            return false;
        }
    }
    [tmp release];
    return true;
}


// Complete the sorted function below.
- (ResultObject*)sorted:(NSString*)string {
    
    ResultObject *value = [ResultObject new];
    NSArray* str = [string componentsSeparatedByString:@" "];
    NSMutableArray* arr1 = [[NSMutableArray alloc]initWithCapacity:[str count] ];
    for(int i =0;i<[str count];i++){
        NSNumber* tmp = [[NSNumber alloc] initWithInteger:[str[i]integerValue] ];
        [arr1 addObject:tmp];
        [tmp release];
    }
    NSMutableArray *arr2 = [[NSMutableArray alloc]initWithArray:arr1 ];
   ;
    if (swapfunc(arr1)) {
        value.status = YES;
        value.detail = [NSString stringWithFormat:@"swap %d %d", pos1 + 1, pos2 + 1];
    }
    else if (reverse(arr2)){
        value.status = YES;
        value.detail = [NSString stringWithFormat:@"reverse %d %d", pos1 + 1, pos2 + 1];
        }
    else{
        value.status = NO;
    }
    
    [arr2 release];
    [arr1 release];
    return value;
}

@end
