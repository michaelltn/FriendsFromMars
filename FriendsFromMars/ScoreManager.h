//
//  ScoreManager.h
//  FriendsFromMars
//


#import <UIKit/UIKit.h>

@interface ScoreManager : NSObject
{
    int listSize;
    NSMutableArray* highScores;
    int newHighScoreIndex;
}

+(ScoreManager*)sharedScoreManager;

// returns where in the score list the score has been added
// returns -1 if the score didn't make the list
-(int)addHighScore:(int)score;

-(NSMutableArray*)getHighScores;
-(BOOL)hasNewHighScore;
-(BOOL)isNewHighScoreAt:(int)index;
-(void)clearNewHighScoreIndex;

-(BOOL)saveHighScores;
-(BOOL)loadHighScores;

@end
