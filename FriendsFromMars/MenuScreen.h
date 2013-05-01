//
//  MenuScreen.h
//  FriendsFromMars
//

#import "cocos2d.h"

// HelloWorldLayer
@interface MenuScreen : CCLayer
{
    CCMenuItemToggle* soundMenuItemToggle;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


-(void)playClicked:(CCMenuItem*)menuItem;
-(void)highscoresClicked:(CCMenuItem*)menuItem;
-(void)helpClicked:(CCMenuItem*)menuItem;
-(void)creditsClicked:(CCMenuItem*)menuItem;
-(void)toggleSoundClicked:(CCMenuItem*)menuItem;


@end
