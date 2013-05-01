//
//  ScoreManager.m
//  FriendsFromMars
//


#import "ScoreManager.h"

@implementation ScoreManager

static ScoreManager* SharedScoreManager = NULL;

+(ScoreManager*)sharedScoreManager
{
    if (SharedScoreManager == NULL)
        SharedScoreManager = [[ScoreManager alloc] init];
    return SharedScoreManager;
}



-(id)init
{
    self = [super init];
    if (self)
    {
        newHighScoreIndex = -1;
        listSize = 10;
        highScores = [[NSMutableArray alloc] initWithCapacity:listSize];
        
        int s = 100;
        for (int i = 0; i < listSize; i++)
        {
            [highScores addObject:[NSNumber numberWithInt:s]];
            s -= 10;
        }
        
        [self loadHighScores];
    }
    return self;
}


-(int)addHighScore:(int)score
{
    int index = -1;
    NSNumber* newScore = [NSNumber numberWithInt:score];
    
    for (int i = 0; i < highScores.count; i++)
    {
        NSNumber* otherScore = [highScores objectAtIndex:i];
        if ([newScore intValue] > [otherScore intValue])
        {
            int temp = [newScore intValue];
            newScore = [NSNumber numberWithInt:[otherScore intValue]];
            otherScore = [NSNumber numberWithInt:temp];
            [highScores replaceObjectAtIndex:i withObject:otherScore];
            if (index < 0)
                index = i;
        }
    }
    
    [self saveHighScores];
    newHighScoreIndex = index;
    
    return index;
}

-(NSMutableArray*)getHighScores
{
    return highScores;
}

-(BOOL)hasNewHighScore
{
    return (newHighScoreIndex >= 0);
}

-(BOOL)isNewHighScoreAt:(int)index
{
    return index == newHighScoreIndex;
}

-(void)clearNewHighScoreIndex
{
    newHighScoreIndex = -1;
}

-(BOOL)saveHighScores
{
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    if (prefs == NULL) return NO;
    
    for (int i = 0; i < listSize; i++)
    {
        NSNumber* num = [highScores objectAtIndex:i];
        if (num != NULL)
        {
            [prefs setInteger:[num intValue] forKey:[NSString stringWithFormat:@"hs%i", i]];
        }
    }
    
    return [prefs synchronize];
    
}

-(BOOL)loadHighScores
{
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    if (prefs == NULL) return NO;
    
    for (int i = 0; i < listSize; i++)
    {
        NSNumber* num = [prefs objectForKey:[NSString stringWithFormat:@"hs%i", i]];
        if (num != NULL)
        {
            [highScores replaceObjectAtIndex:i withObject:num];
        }
    }
    
    return [prefs synchronize];
}


@end
