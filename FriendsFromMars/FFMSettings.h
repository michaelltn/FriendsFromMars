//
//  FFMSettings.h
//  FriendsFromMars
//

#import <Foundation/Foundation.h>

@interface FFMSettings : NSObject
{
    bool soundEnabled;
}


+(FFMSettings*)sharedSettings;

-(BOOL)soundIsEnabled;
-(void)toggleSound;

@end
