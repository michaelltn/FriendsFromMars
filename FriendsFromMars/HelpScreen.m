//
//  HelpScreen.m
//  FriendsFromMars
//

#import "HelpScreen.h"
#import "AppDelegate.h"
#import "MenuScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"


@implementation HelpScreen


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	HelpScreen *layer = [HelpScreen node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if ( (self=[super init]) )
    {
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        int titleFontSize = (int)floorf(32 * size.width / 320);
        int helpFontSize = (int)floorf(24 * size.width / 320);
        float iconSize = floorf(72 * size.width / 320);
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg1.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];
        
        //CCLayerColor* background = [CCLayerColor layerWithColor:ccc4(63, 72, 204, 255)];
        //[self addChild:background];
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Help" fontName:@"Marker Felt" fontSize:titleFontSize];
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
        
        CCSprite* alienPic = [CCSprite spriteWithFile:@"smiley_green_alien.png"];
        alienPic.scale = iconSize/alienPic.contentSize.height;
        CCLabelTTF* alienText = [CCLabelTTF labelWithString:@"Poke aliens for points.\nGettings points is good."
                                                   fontName:@"Marker Felt"
                                                   fontSize:helpFontSize];

        CCSprite* cowPic = [CCSprite spriteWithFile:@"smiley_cow.png"];
        cowPic.scale = iconSize/cowPic.contentSize.height;
        CCLabelTTF* cowText = [CCLabelTTF labelWithString:@"Poke cows to\nlose hearts."
                                                   fontName:@"Marker Felt"
                                                   fontSize:helpFontSize];
        
        CCSprite* heartPic = [CCSprite spriteWithFile:@"heart_128.png"];
        heartPic.scale = iconSize/heartPic.contentSize.height;
        CCLabelTTF* heartText = [CCLabelTTF labelWithString:@"Losing hearts is bad."
                                                   fontName:@"Marker Felt"
                                                   fontSize:helpFontSize];
        
        CCSprite* rayGunPic = [CCSprite spriteWithFile:@"raygun_128.png"];
        rayGunPic.scale = iconSize/rayGunPic.contentSize.height;
        CCLabelTTF* rayGunText = [CCLabelTTF labelWithString:@"Shake to use\nray guns."
                                                   fontName:@"Marker Felt"
                                                   fontSize:helpFontSize];
        
        float y = size.height - (titleFontSize * 2);
        float x;
        
        y -= (alienPic.contentSize.height * alienPic.scale)/2 + 10;
        x = 10 + (alienPic.contentSize.width * alienPic.scale / 2);
        alienPic.position = ccp(x, y);
        x = 10 + (alienPic.contentSize.width * alienPic.scale) + 10 + alienText.contentSize.width/2;
        alienText.position = ccp(x, y);
        [self addChild:alienPic];
        [self addChild:alienText];
        
        y -= alienPic.contentSize.height * alienPic.scale + 10;
        x = 10 + (cowPic.contentSize.width * cowPic.scale / 2);
        cowPic.position = ccp(x, y);
        x = 10 + (cowPic.contentSize.width * cowPic.scale) + 10 + cowText.contentSize.width/2;
        cowText.position = ccp(x, y);
        [self addChild:cowPic];
        [self addChild:cowText];
        
        y -= cowPic.contentSize.height * cowPic.scale + 10;
        x = 10 + (heartPic.contentSize.width * heartPic.scale / 2);
        heartPic.position = ccp(x, y);
        x = 10 + (heartPic.contentSize.width * heartPic.scale) + 10 + heartText.contentSize.width/2;
        heartText.position = ccp(x, y);
        [self addChild:heartPic];
        [self addChild:heartText];
        
        y -= heartPic.contentSize.height * heartPic.scale + 10;
        x = 10 + (rayGunPic.contentSize.width * rayGunPic.scale / 2);
        rayGunPic.position = ccp(x, y);
        x = 10 + (rayGunPic.contentSize.width * rayGunPic.scale) + 10 + rayGunText.contentSize.width/2;
        rayGunText.position = ccp(x, y);
        [self addChild:rayGunPic];
        [self addChild:rayGunText];
        
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
