#import "FullBinaryTrees.h"
// good luck
@implementation TreeNode
- (id)initWhithInteger:(NSInteger)n{
    self = [super init];
    if (self)
    {
        _val =n;
        _left = nil;
        _right = nil;
    }
    return self;
}

-(void)dealloc{
    [_left release];
    [_right release];
    [super dealloc];
}

-(NSString*)BFS{
    NSMutableString *answerString = [[NSMutableString alloc] init];
    NSMutableArray *answerArr =[[NSMutableArray alloc] init];
    NSMutableArray *quee = [[NSMutableArray alloc] init];

    [answerString appendString:@"["];
    [quee addObject:self];
    
    while ([quee count]!=0) {
        if(![[quee objectAtIndex:0] isEqual:@"null,"]){
        TreeNode *root = [quee objectAtIndex:0];
        [quee removeObjectAtIndex:0];
        
        if(root.left != nil)
        [quee addObject:root.left];
            
        else
            [quee addObject:@"null,"];
        
        if(root.right != nil)
        [quee addObject:root.right];
        else
            [quee addObject:@"null,"];
        
        [answerArr addObject: @"0,"];
        }
        else{
            [answerArr addObject: @"null,"];
            [quee removeObjectAtIndex:0];
        }
    }
    [quee release];
    while(![[answerArr objectAtIndex:[answerArr count]-1] isEqual: @"0,"]){
        [answerArr removeObjectAtIndex:[answerArr count]-1];
    }
    for(NSString *str in answerArr)
        [answerString appendString:str];
    
    [answerArr release];
    [answerString appendString:@"]"];
    [answerString replaceOccurrencesOfString:@",]" withString:@"]," options:0 range: NSMakeRange(0, [answerString length])];
    [answerString autorelease];
    return answerString;
}
@end

@implementation FullBinaryTrees
TreeNode* clone (TreeNode* node){
    if(node==nil) return nil;
    TreeNode* root =[[TreeNode alloc] initWhithInteger:node.val];
    root.left=clone(node.left);
    root.right=clone(node.right);
    [root autorelease];
    return root;
}

NSMutableArray* getArrayOfTrees(NSInteger N){
    NSMutableArray* arr =[[NSMutableArray alloc] init];
    if(N==0) return arr;
    if(N==1){
        TreeNode *node = [[TreeNode alloc] initWhithInteger:0];
        [arr addObject: node];
        [node release];
        return arr;
    }
     else if(N%2==0) return arr;
     else{
         for(int i=1;i<N;i+=2){
             NSMutableArray *left = getArrayOfTrees(i);
             NSMutableArray *right = getArrayOfTrees(N-1-i);
             for(int p=0;p<[left count];p++){
                 for(int q=0;q<[right count];q++){
                     TreeNode* root =[[TreeNode alloc] initWhithInteger:0];
                     root.left= clone([left objectAtIndex:p]);
                     root.right= clone([right objectAtIndex:q]);
                     [arr addObject:root];
                     [root release];
                 }
            }
             [left release];
             [right release];
             }
         }
    return arr;
}

- (NSString *)stringForNodeCount:(NSInteger)count{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    [resultString appendString:@"["];
    NSMutableArray *arr = getArrayOfTrees(count);
    for (int i =0;i<[arr count];i++){
        [resultString appendString:[[arr objectAtIndex:i]BFS]];
        }
    [arr release];
    [resultString appendString:@"]"];
    [resultString replaceOccurrencesOfString:@",]" withString:@"]" options:0 range: NSMakeRange(0, [resultString length])];
    [resultString autorelease];
    return resultString;
}
@end
