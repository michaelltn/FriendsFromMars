//
//  GameScreen.h
//  FriendsFromMars
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FFMGame.h"
#import "SpriteStack.h"
#import "ScoreManager.h"

@interface GameScreen : CCLayer
{
    FFMGame* game;
    
    CCLabelTTF *scoreLabel;
    NSMutableArray* hearts;
    NSMutableArray* rayGuns;
    
    NSMutableArray* spriteStacks;
    
    float changeTimeRemaining;
    
    int spriteWidth, vOffset;
    
    bool shakeFlag;
    float shakeTime;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void)pauseClicked:(CCMenuItem*)menuItem;

-(void)gameOver;

-(void)update:(ccTime)deltaTime;
-(BOOL)popStackAt:(int)index For:(ccTime)duration AsAlien:(BOOL)isAlien;

-(void)debugGameOverClicked:(CCMenuItem*)menuItem;
-(void)debugRemoveHeart:(CCMenuItem*)menuItem;
-(void)debugAddHeart:(CCMenuItem*)menuItem;
-(void)debugAddPoint:(CCMenuItem*)menuItem;
-(void)debugResetPoints:(CCMenuItem*)menuItem;
-(void)debugCollectRayGun:(CCMenuItem*)menuItem;
-(void)debugUseRayGun:(CCMenuItem*)menuItem;


-(void)displayScore;
-(void)displayRayGuns;
-(void)displayHearts;

-(void)useRayGun;

-(void)rayGunTimerComplete:(id)sender;

@end
