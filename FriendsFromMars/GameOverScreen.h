//
//  GameOverScreen.h
//  FriendsFromMars
//


#import "cocos2d.h"

@interface GameOverScreen : CCLayer
{
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)highScoresClicked:(CCMenuItem*)menuItem;
-(void)doneClicked:(CCMenuItem*)menuItem;

@end
