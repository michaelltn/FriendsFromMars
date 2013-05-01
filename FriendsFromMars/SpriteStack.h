//
//  SpriteStack.h
//  FriendsFromMars
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SpriteStack : NSObject
{
    float animationTime;
    
    CGPoint position;
    
    CCSprite* currentImage;
    
    NSMutableArray* alienSprites;
    NSMutableArray* cowSprites;
}

-(void)setPosition:(CGPoint)newPosition;

-(BOOL)addAlien:(CCSprite*)alienSprite;
-(BOOL)addCow:(CCSprite*)cowSprite;

-(BOOL)isAlien;
-(BOOL)isCow;

-(void)hit;
-(void)hide;
-(void)stop;

-(void)pickCow:(ccTime)duration;
-(void)pickAlien:(ccTime)duration;


@end
