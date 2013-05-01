//
//  FFMGame.m
//  FriendsFromMars
//

#import "FFMGame.h"

#define ARC4RANDOM_MAX 0X100000000



@implementation FFMGame

@synthesize maxHearts;
@synthesize heartsRemaining;
@synthesize maxRayGuns;
@synthesize rayGunsRemaining;
@synthesize score;
@synthesize pointsPerRayGun;

-(id)init
{
    self = [super init];
    if (self)
    {
        maxHearts = 3;
        heartsRemaining = maxHearts;
        
        maxRayGuns = 3;
        rayGunsRemaining = 0;
        
        score = 0;
        
        pointsPerRayGun = 25;
        
        pointsPerLevel = 10;
        
        minPopsPerChange = [[NSMutableArray alloc] initWithObjects:
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:1],
                           [NSNumber numberWithInt:2],
                           nil];
        maxPopsPerChange = [[NSMutableArray alloc] initWithObjects:
                           [NSNumber numberWithInt:2],
                           [NSNumber numberWithInt:2],
                           [NSNumber numberWithInt:2],
                           [NSNumber numberWithInt:3],
                           [NSNumber numberWithInt:3],
                           [NSNumber numberWithInt:3],
                           [NSNumber numberWithInt:4],
                           [NSNumber numberWithInt:4],
                           [NSNumber numberWithInt:5],
                           [NSNumber numberWithInt:6],
                           nil];
        
        minChangeTimes = [[NSMutableArray alloc] initWithObjects:
                          [NSNumber numberWithFloat:2.0],
                          [NSNumber numberWithFloat:2.0],
                          [NSNumber numberWithFloat:1.8],
                          [NSNumber numberWithFloat:1.6],
                          [NSNumber numberWithFloat:1.4],
                          [NSNumber numberWithFloat:1.2],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:0.75],
                          [NSNumber numberWithFloat:0.67],
                          [NSNumber numberWithFloat:0.5],
                          nil];
        maxChangeTimes = [[NSMutableArray alloc] initWithObjects:
                          [NSNumber numberWithFloat:3.0],
                          [NSNumber numberWithFloat:3.0],
                          [NSNumber numberWithFloat:3.0],
                          [NSNumber numberWithFloat:3.0],
                          [NSNumber numberWithFloat:2.0],
                          [NSNumber numberWithFloat:2.0],
                          [NSNumber numberWithFloat:2.0],
                          [NSNumber numberWithFloat:2.0],
                          [NSNumber numberWithFloat:1.5],
                          [NSNumber numberWithFloat:1.0],
                          nil];
        
        minDisplayTimes = [[NSMutableArray alloc] initWithObjects:
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:2.85],
                           [NSNumber numberWithFloat:2.7],
                           [NSNumber numberWithFloat:2.57],
                           [NSNumber numberWithFloat:2.44],
                           [NSNumber numberWithFloat:2.32],
                           [NSNumber numberWithFloat:2.2],
                           [NSNumber numberWithFloat:2.1],
                           [NSNumber numberWithFloat:2.0],
                           [NSNumber numberWithFloat:1.5],
                           nil];
        maxDisplayTimes = [[NSMutableArray alloc] initWithObjects:
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:3.0],
                           [NSNumber numberWithFloat:2.8],
                           [NSNumber numberWithFloat:2.75],
                           [NSNumber numberWithFloat:2.6],
                           [NSNumber numberWithFloat:2.0],
                          nil];
        
        cowPercents = [[NSMutableArray alloc] initWithObjects:
                       [NSNumber numberWithFloat:10.0],
                       [NSNumber numberWithFloat:14.0],
                       [NSNumber numberWithFloat:18.0],
                       [NSNumber numberWithFloat:22.0],
                       [NSNumber numberWithFloat:26.0],
                       [NSNumber numberWithFloat:30.0],
                       [NSNumber numberWithFloat:35.0],
                       [NSNumber numberWithFloat:40.0],
                       [NSNumber numberWithFloat:45.0],
                       [NSNumber numberWithFloat:50.0],
                           nil];
    }
    return self;
}

-(float)randomRangeMin:(float)min Max:(float)max
{
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * (max-min)) + min;
}

-(float)randomRangeIntMin:(int)min Max:(int)max
{
    return arc4random_uniform(max+1-min) + min;
}

-(int)getPopCount
{
    int index;
    
    index = score/pointsPerLevel;
    if (index > minPopsPerChange.count-1)
        index = minPopsPerChange.count-1;
    int minPopCount = [(NSNumber*)([minPopsPerChange objectAtIndex:index]) intValue];
    
    index = score/pointsPerLevel;
    if (index > maxPopsPerChange.count-1)
        index = maxPopsPerChange.count-1;
    int maxPopCount = [(NSNumber*)([maxPopsPerChange objectAtIndex:index]) intValue];
    
    return [self randomRangeIntMin:minPopCount Max:maxPopCount];
}

-(float)getChangeTime
{
    int index;

    index = score/pointsPerLevel;
    if (index > minChangeTimes.count-1)
        index = minChangeTimes.count-1;
    float minChangeTime = [(NSNumber*)([minChangeTimes objectAtIndex:index]) floatValue];
    
    index = score/pointsPerLevel;
    if (index > maxChangeTimes.count-1)
        index = maxChangeTimes.count-1;
    float maxChangeTime = [(NSNumber*)([maxChangeTimes objectAtIndex:index]) floatValue];
    
    return [self randomRangeMin:minChangeTime Max:maxChangeTime];
}

-(float)getDisplayTime
{
    int index;
    
    index = score/pointsPerLevel;
    if (index > minDisplayTimes.count-1)
        index = minDisplayTimes.count-1;
    float minDisplayTime = [(NSNumber*)([minDisplayTimes objectAtIndex:index]) floatValue];
    
    index = score/pointsPerLevel;
    if (index > maxDisplayTimes.count-1)
        index = maxDisplayTimes.count-1;
    float maxDisplayTime = [(NSNumber*)([maxDisplayTimes objectAtIndex:index]) floatValue];
    
    return [self randomRangeMin:minDisplayTime Max:maxDisplayTime];
}


-(float)getCowPercent
{
    int index;
    
    index = score/pointsPerLevel;
    if (index > cowPercents.count-1)
        index = cowPercents.count-1;
    
    return [(NSNumber*)([cowPercents objectAtIndex:index]) floatValue];
}


-(void)resetScore
{
    score = 0;
}

-(void)addPoints: (int) points
{
    score += points;
}

-(BOOL)scoreIsMultipleOf:(int)value
{
    return score % value == 0;
}


-(BOOL)removeHeart
{
    if ([self hasHeartsRemaining])
    {
        heartsRemaining--;
        return YES;
    }
    return NO;
}

-(BOOL)addHeart
{
    if (heartsRemaining < maxHearts)
    {
        heartsRemaining++;
        return YES;
    }
    return NO;
}


-(BOOL)hasHeartsRemaining
{
    return (heartsRemaining > 0);
}


-(BOOL)removeRayGun
{
    if ([self hasRayGunsRemaining])
    {
        rayGunsRemaining--;
        return YES;
    }
    return NO;
}

-(BOOL)addRayGun
{
    if (rayGunsRemaining < maxRayGuns)
    {
        rayGunsRemaining++;
        return YES;
    }
    return NO;
}

-(BOOL)hasRayGunsRemaining
{
    return (rayGunsRemaining > 0);
}



@end
