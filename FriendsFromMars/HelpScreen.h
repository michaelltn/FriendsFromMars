//
//  HelpScreen.h
//  FriendsFromMars
//

#import "cocos2d.h"

@interface HelpScreen : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)backClicked:(CCMenuItem*)menuItem;

@end
