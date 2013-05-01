//
//  FFMGame.h
//  FriendsFromMars
//

#import <UIKit/UIKit.h>

@interface FFMGame : NSObject
{
    int score;
    int pointsPerLevel;
    
    int pointsPerRayGun;
    
    int maxHearts;
    int heartsRemaining;
    
    int maxRayGuns;
    int rayGunsRemaining;
    
    NSMutableArray* minPopsPerChange;
    NSMutableArray* maxPopsPerChange;
    
    NSMutableArray* minChangeTimes;
    NSMutableArray* maxChangeTimes;
    
    NSMutableArray* minDisplayTimes;
    NSMutableArray* maxDisplayTimes;
    
    NSMutableArray* cowPercents;
    
}
@property (readonly) int maxHearts;
@property (readonly) int heartsRemaining;
@property (readonly) int maxRayGuns;
@property (readonly) int rayGunsRemaining;
@property (readonly) int score;
@property (readonly) int pointsPerRayGun;

-(float)randomRangeMin:(float)min Max:(float)max;
-(float)randomRangeIntMin:(int)min Max:(int)max;
-(int)getPopCount;
-(float)getChangeTime;
-(float)getDisplayTime;
-(float)getCowPercent;

-(void)resetScore;
-(void)addPoints: (int) points;
-(BOOL)scoreIsMultipleOf:(int)value;

-(BOOL)removeRayGun;
-(BOOL)addRayGun;
-(BOOL)hasRayGunsRemaining;

-(BOOL)removeHeart;
-(BOOL)addHeart;
-(BOOL)hasHeartsRemaining;


@end
