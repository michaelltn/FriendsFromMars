//
//  SpriteStack.m
//  FriendsFromMars
//

#import "SpriteStack.h"

@implementation SpriteStack


-(id)init
{
    self = [super init];
    if (self)
    {
        position = ccp(0, 0);
        animationTime = 0.5f;
        alienSprites = [[NSMutableArray alloc] initWithCapacity:5];
        cowSprites = [[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}

-(void) dealloc
{
    currentImage = nil;
    
//    [alienSprites release];
//    alienSprites = nil;
//    
//    [cowSprites release];
//    cowSprites = nil;
    
    [super dealloc];
}


-(void)setPosition:(CGPoint)newPosition
{
    position = newPosition;
    for (CCSprite* s in alienSprites)
        s.position = newPosition;
    for (CCSprite* s in cowSprites)
        s.position = newPosition;
}


-(BOOL)addAlien:(CCSprite*)alienSprite
{
    for (CCSprite* s in alienSprites)
        if (s == alienSprite)
            return NO;
    alienSprite.position = position;
    alienSprite.opacity = 0;
    [alienSprites addObject:alienSprite];
    return YES;
}

-(BOOL)addCow:(CCSprite*)cowSprite
{
    for (CCSprite* s in cowSprites)
        if (s == cowSprite)
            return NO;
    cowSprite.position = position;
    cowSprite.opacity = 0;
    [cowSprites addObject:cowSprite];
    return YES;
}


-(BOOL)isAlien
{
    if (currentImage == NULL)
        return NO;
    
    for (CCSprite* s in alienSprites)
        if (s == currentImage)
            return YES;
    
    return NO;
}

-(BOOL)isCow
{
    if (currentImage == nil)
        return NO;
    
    for (CCSprite* s in cowSprites)
        if (s == currentImage)
            return YES;
    
    return NO;
}



-(void)hit
{
    if (currentImage != nil)
    {
        [currentImage stopAllActions];
        [currentImage runAction:[CCSequence actions:
            [CCRotateBy actionWithDuration:animationTime/2 angle:360.0],
            [CCFadeOut actionWithDuration:animationTime/2],
            nil
         ]];
        currentImage = nil;
    }
}

-(void)hide
{
    if (currentImage != nil)
    {
        [currentImage stopAllActions];
        [currentImage runAction:[CCFadeOut actionWithDuration:animationTime]];
        currentImage = nil;
    }
}

-(void)stop
{
    if (currentImage != nil)
    {
        [currentImage stopAllActions];
        currentImage = nil;
    }
}


-(void)pickCow:(ccTime)duration
{
    if (cowSprites.count > 0)
    {
        if (currentImage != nil)
            [currentImage runAction:[CCFadeOut actionWithDuration:animationTime]];
        int i = arc4random_uniform(cowSprites.count);
        currentImage = [cowSprites objectAtIndex:i];
        currentImage.rotation = 0;

        [currentImage runAction:[CCSequence actions:
                                 [CCFadeIn actionWithDuration:animationTime],
                                 [CCDelayTime actionWithDuration:duration],
                                 [CCCallFunc actionWithTarget:self selector:@selector(hide)],
                                 nil]];
    }
}

-(void)pickAlien:(ccTime)duration
{
    if (alienSprites.count > 0)
    {
        if (currentImage != nil)
            [currentImage runAction:[CCFadeOut actionWithDuration:animationTime]];
        int i = arc4random_uniform(alienSprites.count);
        currentImage = [alienSprites objectAtIndex:i];
        currentImage.rotation = 0;

        [currentImage runAction:[CCSequence actions:
                                 [CCFadeIn actionWithDuration:animationTime],
                                 [CCDelayTime actionWithDuration:duration],
                                 [CCCallFunc actionWithTarget:self selector:@selector(hide)],
                                 //[CCCallFuncND actionWithTarget:self selector:@selector(hit:) data:NULL],
                                 nil]];
    }
}


@end
