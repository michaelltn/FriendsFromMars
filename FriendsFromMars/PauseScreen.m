//
//  PauseScreen.m
//  FriendsFromMars
//

#import "PauseScreen.h"
#import "MenuScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"


@implementation PauseScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	PauseScreen *layer = [PauseScreen node];
	
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
        int menueFontSize = (int)floorf(28 * size.width / 320);
        int paddingSize = (int)floorf(32 * size.width / 320);
       
        CCSprite* background = [CCSprite spriteWithFile:@"bg3.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Paused" fontName:@"Marker Felt" fontSize:titleFontSize];
		label.position =  ccp( size.width /2 , size.height - titleFontSize );
		[self addChild: label];
		
		[CCMenuItemFont setFontSize:menueFontSize];
        
		CCMenuItem *resumeMenuItem = [CCMenuItemFont itemWithString:@"Resume"
                                                           target:self
                                                         selector:@selector(resumeClicked:)];
		CCMenuItem *quitMenuItem = [CCMenuItemFont itemWithString:@"Quit"
                                                             target:self
                                                           selector:@selector(quitClicked:)];
        
		CCMenu *menu = [CCMenu menuWithItems:resumeMenuItem, quitMenuItem, nil];
		
		[menu alignItemsHorizontallyWithPadding:paddingSize];
		[menu setPosition:ccp( size.width/2, size.height/3)];
		
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
//    [soundMenuItemToggle release];
//    soundMenuItemToggle = nil;
    
	[super dealloc];
}


-(void)resumeClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] popScene];
}

-(void)quitClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[MenuScreen scene]]];
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
