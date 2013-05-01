//
//  FFMSettings.m
//  FriendsFromMars
//

#import "FFMSettings.h"

@implementation FFMSettings

static FFMSettings* SharedSettings = NULL;

+(FFMSettings*)sharedSettings
{
    if (SharedSettings == NULL)
        SharedSettings = [[FFMSettings alloc] init];
    return SharedSettings;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
        if (prefs != NULL)
        {
            NSObject* soundSetting = [prefs objectForKey:@"sound"];
            if (soundSetting != NULL)
            {
                soundEnabled = [prefs boolForKey:@"sound"];
            }
            else
            {
                soundEnabled = YES;
            }
        }
    }
    return self;
}


-(BOOL)soundIsEnabled
{
    return soundEnabled;
}

-(void)toggleSound
{
    soundEnabled = !soundEnabled;
    
    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    if (prefs == NULL) return;
    [prefs setBool:soundEnabled forKey:[NSString stringWithFormat:@"sound"]];
    [prefs synchronize];
}


@end
