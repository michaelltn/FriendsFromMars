//
//  HighScoresScreen.m
//  FriendsFromMars
//

#import "HighScoresScreen.h"
#import "MenuScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"


@implementation HighScoresScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	HighScoresScreen *layer = [HighScoresScreen node];
	
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if ( (self=[super init]) )
    {
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        int titleFontSize = (int)floorf(32 * size.width / 320);
        int scoreFontSize = (int)floorf(32 * size.width / 320);
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg1.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"High Scores"
                                               fontName:@"Marker Felt"
                                               fontSize:titleFontSize];
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
        
        ScoreManager* scoreManager = [ScoreManager sharedScoreManager];
        int n = [scoreManager getHighScores].count;
        if (scoreManager != NULL)
        {
            for (int i = 0; i < n; i++)
            {
                NSNumber* number = (NSNumber*)[[scoreManager getHighScores] objectAtIndex:i];
                NSString* string = [NSString stringWithFormat:@"%i.  %i", (i+1), [number intValue]];
                CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:string
                                                            fontName:@"Marker Felt"
                                                            fontSize:scoreFontSize];
                if ([scoreManager isNewHighScoreAt:i])
                {
                    [scoreLabel setColor:ccYELLOW];
                }
                float y = size.height/2 - ((i + 1 - n/2) * (scoreFontSize+4));
                [scoreLabel setPosition:ccp(size.width/2, y)];
                [self addChild:scoreLabel];
            }
        }
        
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}


-(void)backClicked:(CCMenuItem*)menuItem
{
    [[ScoreManager sharedScoreManager] clearNewHighScoreIndex];
    
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInR transitionWithDuration:0.5f scene:[MenuScreen scene]]];
}

@end
