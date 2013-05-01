//
//  GameOverScreen.m
//  FriendsFromMars
//

#import "GameOverScreen.h"
#import "HighScoresScreen.h"
#import "MenuScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"

@implementation GameOverScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	GameOverScreen *layer = [GameOverScreen node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if ( (self=[super init]) )
    {
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        int titleFontSize = (int)floorf(32 * size.width / 320);
        int menueFontSize = (int)floorf(28 * size.width / 320);
        int paddingSize = (int)floorf(20 * size.width / 320);
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg2.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];
        
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Game Over" fontName:@"Marker Felt" fontSize:titleFontSize];
		label.position =  ccp( size.width /2 , size.height - titleFontSize );
		[self addChild: label];
		
        if ([[ScoreManager sharedScoreManager] hasNewHighScore])
        {
            CCLabelTTF *highScoreLabel = [CCLabelTTF labelWithString:@"New High Score!" fontName:@"Marker Felt" fontSize:menueFontSize];
            highScoreLabel.position =  ccp( size.width /2 , label.position.y - (titleFontSize  + menueFontSize) );
            [highScoreLabel setColor:ccYELLOW];
            [self addChild: highScoreLabel];
        }
		
		[CCMenuItemFont setFontSize:menueFontSize];
		
		CCMenuItem *highScoresMenuItem = [CCMenuItemFont itemWithString:@"View High Scores"
                                                           target:self
                                                         selector:@selector(highScoresClicked:)];
		CCMenuItem *doneMenuItem = [CCMenuItemFont itemWithString:@"Done"
                                                           target:self
                                                         selector:@selector(doneClicked:)];
        
		
		CCMenu *menu = [CCMenu menuWithItems:highScoresMenuItem, doneMenuItem, nil];
		
		[menu alignItemsVerticallyWithPadding:paddingSize];
		[menu setPosition:ccp( size.width/2, size.height/2)];
		
		[self addChild:menu];
        
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}


-(void)highScoresClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionMoveInL transitionWithDuration:0.5f scene:[HighScoresScreen scene]]];
}

-(void)doneClicked:(CCMenuItem*)menuItem
{
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:0.5f scene:[MenuScreen scene] withColor:ccGREEN]];
}

@end
