//
//  PauseScreen.h
//  FriendsFromMars
//


#import "cocos2d.h"

@interface PauseScreen : CCLayer
{
    CCMenuItemToggle* soundMenuItemToggle;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)resumeClicked:(CCMenuItem*)menuItem;
-(void)quitClicked:(CCMenuItem*)menuItem;
-(void)toggleSoundClicked:(CCMenuItem*)menuItem;


@end
