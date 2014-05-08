//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYSoundAgent.h"

@implementation TYSoundAgent
{
    id <TYSoundPlayer> soundPlayer;
    id <TYPreferences> preferences;
}

- (instancetype)initWithSoundPlayer:(id <TYSoundPlayer>)aSoundPlayer preferences:(id <TYPreferences>)aPreferences
{
    self = [super self];
    if (self)
    {
        soundPlayer = aSoundPlayer;
        preferences = aPreferences;
    }
    return self;
}

- (void)playSoundsInResponseToEventsFrom:(id <TYEventBus>)eventBus
{
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id timerContext)
    {
        if([preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS])
        {
            [soundPlayer playSoundWithName:SOUND_TIMER_START];
        }
    }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerStop usingBlock:^(id eventData) {
        [soundPlayer stopCurrentLoop];
    }];
    
    [eventBus addObserverForEventType:TYEventTypePomodoroStart usingBlock:^(id timerContext)
    {
        if ([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO])
        {
            [soundPlayer loopSoundWithName:SOUND_TIMER_TICK];
        }
    }];
    
    [eventBus addObserverForEventType:TYEventTypeBreakStart usingBlock:^(id timerContext)
    {
        if ([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK])
        {
            [soundPlayer loopSoundWithName:SOUND_TIMER_TICK];
        }
    }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerGoesOff usingBlock:^(id timerContext)
    {
        if ([preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF])
        {
            [soundPlayer playSoundWithName:SOUND_TIMER_GOES_OFF];
        }
    }];
}

@end
