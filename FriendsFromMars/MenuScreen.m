//
//  MenuScreen.m
//  FriendsFromMars
//

#import "MenuScreen.h"
#import "AppDelegate.h"
#import "GameScreen.h"
#import "HelpScreen.h"
#import "HighScoresScreen.h"
#import "CreditsScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"

@implementation MenuScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
    MenuScreen *layer = [MenuScreen node];
    
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if ( (self=[super init]) )
    {
		CGSize size = [[CCDirector sharedDirector] winSize];
        float scale = size.width / 320.0;
        
        int titleFontSize = (int)floorf(32 * size.width / 320);
        int menuFontSize = (int)floorf(28 * size.width / 320);
        float iconSize = floorf(73 * size.width / 320);
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg2.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Friends From Mars"
                                               fontName:@"Marker Felt"
                                               fontSize:titleFontSize];
        //[label setColor:ccGREEN];
		label.position =  ccp( size.width /2 , size.height - titleFontSize );
		[self addChild: label];
        
        CCSprite* alienPic = [CCSprite spriteWithFile:@"smiley_green_alien_GRRR.png"];
        alienPic.scale = iconSize/alienPic.contentSize.height;
        alienPic.position = ccp( size.width /2 , size.height - titleFontSize - 24 - iconSize/2 );
        [self addChild:alienPic];
		
		[CCMenuItemFont setFontSize:menuFontSize];
		
		CCMenuItem *playMenuItem = [CCMenuItemFont itemWithString:@"Play"
                                                           target:self
                                                         selector:@selector(playClicked:)];
		CCMenuItem *highscoresMenuItem = [CCMenuItemFont itemWithString:@"High Scores"
                                                           target:self
                                                         selector:@selector(highscoresClicked:)];
		CCMenuItem *helpMenuItem = [CCMenuItemFont itemWithString:@"Help"
                                                           target:self
                                                         selector:@selector(helpClicked:)];
		CCMenuItem *creditsMenuItem = [CCMenuItemFont itemWithString:@"Credits"
                                                            target:self
                                                          selector:@selector(creditsClicked:)];
        
		
		CCMenu *menu = [CCMenu menuWithItems:playMenuItem, highscoresMenuItem, helpMenuItem, creditsMenuItem, nil];
		
		[menu alignItemsVerticallyWithPadding:20];
		[menu setPosition:ccp( size.width/2, size.height/2 - 50)];
		
		[self addChild:menu];
        
        CCMenuItem* soundOnMenuItem = [CCMenuItemImage itemWithNormalImage:@"sound_icon_on_64.png"
                                                             selectedImage:@"sound_icon_on_64.png"
                                                                    target:nil
                                                                  selector:nil];
        [soundOnMenuItem setScale:scale];
        CCMenuItem* soundOffMenuItem = [CCMenuItemImage itemWithNormalImage:@"sound_icon_off_64.png"
                                                              selectedImage:@"sound_icon_off_64.png"
                                                                     target:nil
                                                                   selector:nil];
        [soundOffMenuItem setScale:scale];
        soundMenuItemToggle = [CCMenuItemToggle itemWithTarget:self
                                                      selector:@selector(toggleSoundClicked:)
                                                         items:soundOnMenuItem, soundOffMenuItem, nil];
        
        [soundMenuItemToggle setSelectedIndex:([[FFMSettings sharedSettings] soundIsEnabled] ? 0 : 1)];
        
        CCMenu* soundMenu = [CCMenu menuWithItems:soundMenuItemToggle, nil];
        [soundMenu setPosition:ccp(size.width - soundOnMenuItem.contentSize.width*scale/2 - 4, soundOnMenuItem.contentSize.width*scale/2 + 4)];
        
        [self addChild:soundMenu];
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}



-(void)playClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInR transitionWithDuration:0.5f scene:[GameScreen scene]]];
}

-(void)highscoresClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[HighScoresScreen scene]]];
}

-(void)helpClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[HelpScreen scene]]];
}

-(void)creditsClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[CreditsScreen scene]]];
}

-(void)toggleSoundClicked:(CCMenuItem*)menuItem
{
    [[FFMSettings sharedSettings] toggleSound];
    [soundMenuItemToggle setSelectedIndex:([[FFMSettings sharedSettings] soundIsEnabled] ? 0 : 1)];
    
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }    
}



@end
