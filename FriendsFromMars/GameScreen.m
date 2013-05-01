//
//  GameScreen.m
//  FriendsFromMars
//

#import "GameScreen.h"
#import "MenuScreen.h"
#import "PauseScreen.h"
#import "GameOverScreen.h"
#import "FFMSettings.h"
#import "SimpleAudioEngine.h"


@implementation GameScreen

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	// 'layer' is an autorelease object.
	GameScreen *layer = [GameScreen node];
	
	[scene addChild: layer];
	return scene;
}


-(id) init
{
	if ( (self=[super init]) )
    {
        game = [[FFMGame alloc] init];
        
        changeTimeRemaining = [game getChangeTime];     

        self.isTouchEnabled = YES;
        
        self.isAccelerometerEnabled = YES;
        //[[UIAccelerometer sharedAccelerometer] setUpdateInterval:1/60];
        shakeFlag = false;
        shakeTime = 1.0;
        
		CGSize size = [[CCDirector sharedDirector] winSize];
        int fontSize = (int)(24 * size.width / 320.0);
        float scale = size.width / 320.0;
        float heartScale = scale * 0.75;
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg3.png"];
        background.scaleX = size.width / background.contentSize.width;
        background.scaleY = size.height / background.contentSize.height;
        [background setPosition:ccp(size.width/2, size.height/2)];
        [self addChild:background];

        
        // create and add the pause button
		CCMenuItem *pauseMenuItem = [CCMenuItemImage itemWithNormalImage:@"pause_48.png"
                                                           selectedImage:@"pause_48.png"
                                                                  target:self
                                                                selector:@selector(pauseClicked:)];
        [pauseMenuItem setScale:scale];
        
		CCMenu *menu = [CCMenu menuWithItems:pauseMenuItem, nil];
		[menu setPosition:ccp(size.width - (pauseMenuItem.contentSize.width * scale / 2) - 4,
                              size.height - (pauseMenuItem.contentSize.height * scale / 2) - 4)];
		[self addChild:menu];
        
        
        // create and add the hearts
        hearts = [[NSMutableArray alloc] initWithCapacity: game.maxHearts];
        for (int i = 0; i < game.maxHearts; i++)
        {
            CCSprite *heart = [CCSprite spriteWithFile:@"heart_64.png"];
            
            [heart setScale:heartScale];
            
            //heart.position = ccp(size.width / 2 + (i-(game.maxHearts/2)) * (heart.contentSize.width * heartScale),
            heart.position = ccp(size.width  - 12 - (pauseMenuItem.contentSize.width * scale) - ((i+0.5) * heart.contentSize.width * heartScale),
                                 size.height - (heart.contentSize.height * heartScale / 2) - 4);
            [self addChild: heart];
            
            [heart setTag:i];
            [hearts addObject: heart];
        }
        [self displayHearts];
        
        
        // create and add the ray guns
        rayGuns = [[NSMutableArray alloc] initWithCapacity: game.maxRayGuns];
        for (int i = 0; i < game.maxRayGuns; i++)
        {
            CCSprite *rayGun = [CCSprite spriteWithFile:@"raygun_64.png"];
            
            [rayGun setScale:scale];
            
            rayGun.position = ccp(size.width / 2 + (i-(game.maxRayGuns/2)) * ((rayGun.contentSize.width * 1.25) * scale),
                                 (rayGun.contentSize.height * scale / 2) + 4);
            [self addChild: rayGun];
            
            [rayGun setTag:i];
            [rayGuns addObject: rayGun];
        }
        [self displayRayGuns];
        
        
        // create and add the score label
        scoreLabel = [CCLabelTTF labelWithString:@"Score: 0" fontName:@"Marker Felt" fontSize:fontSize];
        scoreLabel.position = ccp( 10 , size.height - scoreLabel.contentSize.height - 10 );
        [scoreLabel setAnchorPoint: CGPointMake(0, 0)];
        [self addChild: scoreLabel];
		
        
        // create and add the Sprites for the SpriteStacks
        spriteStacks = [[NSMutableArray alloc] initWithCapacity:25];
        CCSprite* sprite = NULL;
        spriteWidth = size.width/5;
        vOffset = (size.height - size.width) / 2;
        for (int y = 0; y < 5; y++)
        {
            for (int x = 0; x < 5; x++)
            {
                SpriteStack* stack = [[SpriteStack alloc] init];
                [stack setPosition:ccp(x * spriteWidth + spriteWidth/2, y * spriteWidth + spriteWidth/2 + vOffset)];
                [spriteStacks addObject:stack];
                
                sprite = [CCSprite spriteWithFile:@"smiley_green_alien.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addAlien:sprite];
                [self addChild:sprite];
                
                sprite = [CCSprite spriteWithFile:@"smiley_green_alien_GRRR.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addAlien:sprite];
                [self addChild:sprite];
                
                sprite = [CCSprite spriteWithFile:@"smiley_green_alien_huh.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addAlien:sprite];
                [self addChild:sprite];
                
                sprite = [CCSprite spriteWithFile:@"smiley_green_alien_naah.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addAlien:sprite];
                [self addChild:sprite];
                
                sprite = [CCSprite spriteWithFile:@"smiley_green_alien_unhappy.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addAlien:sprite];
                [self addChild:sprite];
                
                sprite = [CCSprite spriteWithFile:@"smiley_bull.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addCow:sprite];
                [self addChild:sprite];
                
                sprite = [CCSprite spriteWithFile:@"smiley_cow.png"];
                [sprite setZOrder:5-y];
                sprite.scale = spriteWidth/sprite.contentSize.width;
                [stack addCow:sprite];
                [self addChild:sprite];
            }
        }
        
        
        /*
        // create and add the debug buttons for testing
        fontSize = (int)(28.0 * size.height / 480.0f);
        [CCMenuItemFont setFontSize: fontSize];
        
		CCMenuItem *debugGameOverMenuItem = [CCMenuItemFont itemWithString:@"Game Over Test"
                                                                  target:self
                                                                selector:@selector(debugGameOverClicked:)];
		CCMenuItem *debugRemoveHeartMenuItem = [CCMenuItemFont itemWithString:@"Remove Heart Test"
                                                                    target:self
                                                                  selector:@selector(debugRemoveHeart:)];
		CCMenuItem *debugAddHeartMenuItem = [CCMenuItemFont itemWithString:@"Add Heart Test"
                                                                    target:self
                                                                  selector:@selector(debugAddHeart:)];
		CCMenuItem *debugAddPointMenuItem = [CCMenuItemFont itemWithString:@"Add Point Test"
                                                                    target:self
                                                                  selector:@selector(debugAddPoint:)];
		CCMenuItem *debugResetPointsMenuItem = [CCMenuItemFont itemWithString:@"Reset Points Test"
                                                                    target:self
                                                                  selector:@selector(debugResetPoints:)];
		CCMenuItem *debugAddRayGunMenuItem = [CCMenuItemFont itemWithString:@"Collect Ray Gun Test"
                                                                    target:self
                                                                  selector:@selector(debugCollectRayGun:)];
		CCMenuItem *debugRemoveRayGunMenuItem = [CCMenuItemFont itemWithString:@"Use Ray Gun Test"
                                                                    target:self
                                                                  selector:@selector(debugUseRayGun:)];
        
		
		CCMenu *debugMenu = [CCMenu menuWithItems:
                             debugAddHeartMenuItem,
                             debugRemoveHeartMenuItem,
                             debugAddPointMenuItem,
                             debugResetPointsMenuItem,
                             debugAddRayGunMenuItem,
                             debugRemoveRayGunMenuItem,
                             debugGameOverMenuItem,
                             nil];
		[debugMenu alignItemsVerticallyWithPadding:10];
        [debugMenu setPosition:ccp(size.width/2, size.height/2)];
		[self addChild:debugMenu];
        */
	}
	return self;
}

- (void) dealloc
{
//    for (SpriteStack* stack in spriteStacks)
//    {
//        [stack release];
//    }
//    [spriteStacks release];
//    spriteStacks = nil;
    
//    for (CCSprite* heart in hearts)
//        [heart release];
//    [hearts release];
//    hearts = nil;
//    
//    for (CCSprite* rayGun in rayGuns)
//        [rayGun release];
//    [rayGuns release];
//    rayGuns = nil;
//    
//    [scoreLabel release];
//    scoreLabel = nil;
    
    [game release];
    game = nil;
    
	[super dealloc];
}


-(void)onEnter
{
    [super onEnter];
    [self scheduleUpdate];
}


-(void)pauseClicked:(CCMenuItem*)menuItem
{
    [self unscheduleUpdate];
    
    if ([[FFMSettings sharedSettings] soundIsEnabled])
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"button-30.wav"];
    }
    [[CCDirector sharedDirector] pushScene:[PauseScreen scene]];
}


-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    location = ccp(location.x, winSize.height - location.y);
    
    // ccp(x * spriteWidth + spriteWidth/2, y * spriteWidth + spriteWidth/2 + vOffset)
    int x = (int)roundf((location.x - spriteWidth/2)/spriteWidth);
    int y = (int)roundf((location.y - spriteWidth/2 - vOffset)/spriteWidth);
    if (x < 0) return;
    if (x >= 5) return;
    if (y < 0) return;
    if (y >= 5) return;
    
    int i = y * 5 + x;
    SpriteStack* stack = [spriteStacks objectAtIndex:i];
    if (stack != NULL)
    {
        if ([stack isCow])
        {
            if ([[FFMSettings sharedSettings] soundIsEnabled])
            {
                [[SimpleAudioEngine sharedEngine] playEffect:@"button-4.wav"];
            }
            [stack hit];
            [game removeHeart];
            [self displayHearts];
            if ([game hasHeartsRemaining] == NO)
                [self gameOver];
        }
        else if ([stack isAlien])
        {
            if ([[FFMSettings sharedSettings] soundIsEnabled])
            {
                [[SimpleAudioEngine sharedEngine] playEffect:@"button-11.wav"];
            }
            [stack hit];
            [game addPoints:1];
            [self displayScore];
            if ([game scoreIsMultipleOf:game.pointsPerRayGun] == YES)
            {
                [game addRayGun];
                [self displayRayGuns];
            }
        }
    }
}


-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    float THRESHOLD = 2;
    
    if (acceleration.x > THRESHOLD || acceleration.x < -THRESHOLD ||
        acceleration.y > THRESHOLD || acceleration.y < -THRESHOLD ||
        acceleration.z > THRESHOLD || acceleration.z < -THRESHOLD)
    {
        if (!shakeFlag)
        {
            shakeFlag = true;
            [self useRayGun];
            [self scheduleOnce:@selector(rayGunTimerComplete:) delay:shakeTime];
        }
    }
}

-(void)rayGunTimerComplete:(id)sender
{
    shakeFlag = false;
}


-(void)update:(ccTime)dt
{
    // game loop
    changeTimeRemaining -= dt;
    if (changeTimeRemaining <= 0)
    {
        changeTimeRemaining = [game getChangeTime];
        
        int popCount = [game getPopCount];
        for (int p = 0; p < popCount; p++)
        {
            int firstIndex = arc4random_uniform(spriteStacks.count);
            SpriteStack* stack;
            stack = [spriteStacks objectAtIndex:firstIndex];
            if (stack == NULL) return;
            
            ccTime duration = [game getDisplayTime];
            BOOL isAlien = [game randomRangeMin:0.0 Max:100.0] > [game getCowPercent];
            
            if ([self popStackAt:firstIndex For:duration AsAlien:isAlien])
                continue;
            
            int nextIndex = firstIndex + 1;
            nextIndex %= spriteStacks.count;
            stack = [spriteStacks objectAtIndex:nextIndex];
            while (nextIndex != firstIndex)
            {
                if ([self popStackAt:nextIndex For:duration AsAlien:isAlien])
                    break;
                nextIndex++;
                nextIndex %= spriteStacks.count;
                stack = [spriteStacks objectAtIndex:nextIndex];
            }
        }
    }
}

-(BOOL)popStackAt:(int)index For:(ccTime)duration AsAlien:(BOOL)isAlien
{
    SpriteStack* stack = [spriteStacks objectAtIndex:index];
    if (stack == NULL) return NO;
    if (stack.isAlien) return NO;
    if (stack.isCow) return NO;
    
    if (isAlien)
        [stack pickAlien:duration];
    else
        [stack pickCow:duration];
    
    return YES;
}


-(void)debugGameOverClicked:(CCMenuItem*)menuItem
{
    [self gameOver];
}
-(void)debugRemoveHeart:(CCMenuItem*)menuItem
{
    [game removeHeart];
}
-(void)debugAddHeart:(CCMenuItem*)menuItem
{
    [game addHeart];
}
-(void)debugAddPoint:(CCMenuItem*)menuItem
{
    [game addPoints:1];
}
-(void)debugResetPoints:(CCMenuItem*)menuItem
{
    [game resetScore];
}
-(void)debugCollectRayGun:(CCMenuItem*)menuItem
{
    [game addRayGun];
}
-(void)debugUseRayGun:(CCMenuItem*)menuItem
{
    [game removeRayGun];
}


-(void)gameOver
{
    [[ScoreManager sharedScoreManager] addHighScore:game.score];
    
    for (SpriteStack* stack in spriteStacks)
    {
        [stack stop];
    }
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInL transitionWithDuration:0.5f scene:[GameOverScreen scene]]];
}



-(void)displayScore
{
    [scoreLabel setString: [NSString stringWithFormat:@"Score: %i", game.score]];
}



-(void)displayRayGuns
{
    for (CCSprite* rayGun in rayGuns)
    {
        [rayGun setVisible:(rayGun.tag < game.rayGunsRemaining)];
    }
}





-(void)displayHearts
{
    for (CCSprite* heart in hearts)
    {
        [heart setVisible:(heart.tag < game.heartsRemaining)];
    }
}


-(void)useRayGun
{
    if ([game hasRayGunsRemaining])
    {
        if ([[FFMSettings sharedSettings] soundIsEnabled])
        {
            [[SimpleAudioEngine sharedEngine] playEffect:@"button-8.wav"];
        }
        for (SpriteStack* stack in spriteStacks)
        {
            if ([stack isAlien])
            {
                [stack hit];
                [game addPoints:1];
                [self displayScore];
                [game removeRayGun];
                [self displayRayGuns];
            }
        }
    }
}


@end
