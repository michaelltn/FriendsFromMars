//
//  CreditsScreen.m
//  FriendsFromMars
//

#import "CreditsScreen.h"
#import "MenuScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"


@implementation CreditsScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	CreditsScreen *layer = [CreditsScreen node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if ( (self=[super init]) )
    {
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        int titleFontSize = (int)floorf(32 * size.width / 320);
        int creditsFontSize = (int)floorf(24 * size.width / 320);
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg1.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];
        
        //CCLayerColor* background = [CCLayerColor layerWithColor:ccc4(63, 72, 204, 255)];
        //[self addChild:background];
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Credits" fontName:@"Marker Felt" fontSize:titleFontSize];
		label.position =  ccp( size.width /2 , size.height - titleFontSize );
		[self addChild: label];
		
        // create and add the back button
		CCMenuItem *backMenuItem = [CCMenuItemImage itemWithNormalImage:@"back_64.png"
                                                          selectedImage:@"back_64.png"
                                                                 target:self
                                                               selector:@selector(backClicked:)];
        [backMenuItem setScaleX:-1];
        
		CCMenu *menu = [CCMenu menuWithItems:backMenuItem, nil];
		[menu setPosition:ccp(size.width - (backMenuItem.contentSize.width / 2) - 4,
                              size.height - (backMenuItem.contentSize.height / 2) - 4)];
		[self addChild:menu];
        
        
        
        int x = size.width/2;
        int y = size.height/2;
        CCLabelTTF *creditsLabel = [CCLabelTTF labelWithString:@"Created by\nMichael Cameron\n\nImages from\nwpclipart.com\ncolouringbook.org\nclker.com\n\nSounds from\nsoundjay.com"
                                                      fontName:@"Marker Felt"
                                                      fontSize:creditsFontSize];
        creditsLabel.position = ccp(x, y);
        [self addChild:creditsLabel];
        
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}


-(void)backClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInR transitionWithDuration:0.5f scene:[MenuScreen scene]]];
}


@end
