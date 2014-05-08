//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYDefaultSoundPlayer.h"

NSString * const SOUND_TIMER_START = @"timer_start";
NSString * const SOUND_TIMER_TICK = @"timer_tick";
NSString * const SOUND_TIMER_GOES_OFF = @"timer_goes_off";

@implementation TYDefaultSoundPlayer
{
    NSMutableDictionary *soundClipCache;
    NSSound *currentLoopingSoundClip;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        soundClipCache = [[NSMutableDictionary alloc] initWithCapacity:4];
    }
    return self;
}

- (void)playSoundWithName:(NSString *)soundClipName
{
    [self playSoundWithName:soundClipName loops:false];
}

- (void)loopSoundWithName:(NSString *)soundClipName
{
    [self playSoundWithName:soundClipName loops:true];
}

- (void)stopCurrentLoop
{
    [currentLoopingSoundClip stop];
}

- (void)playSoundWithName:(NSString *)soundClipName loops:(BOOL)loops
{
    if (loops)
    {
        [self stopCurrentLoop];
    }
    
    NSSound *soundClip = [self soundWithName:soundClipName];
    [soundClip setLoops:loops];
    [soundClip play];
    
    if (loops)
    {
        currentLoopingSoundClip = soundClip;
    }
}

- (NSSound *)soundWithName:(NSString *)soundClipName
{
    NSSound *soundClip = [soundClipCache objectForKey:soundClipName];
    if (!soundClip)
    {
        soundClip = [NSSound soundNamed:soundClipName];
        soundClipCache[soundClipName] = soundClip;
    }
    return soundClip;
}

@end
