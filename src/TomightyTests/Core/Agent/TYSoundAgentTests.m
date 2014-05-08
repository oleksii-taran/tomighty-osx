//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import <XCTest/XCTest.h>

#import "TYMockEventBus.h"
#import "TYPreferences.h"
#import "TYSoundAgent.h"
#import "TYSoundPlayerProtocol.h"
#import "TYTimerContextProtocol.h"

@interface TYSoundAgentTests : XCTestCase

@end

@implementation TYSoundAgentTests
{
    TYSoundAgent *soundAgent;
    TYMockEventBus *eventBus;
    id <TYPreferences> preferences;
    id <TYSoundPlayer> soundPlayer;
    id <TYTimerContext> timerContext;
}

- (void)setUp
{
    [super setUp];
    
    eventBus = [[TYMockEventBus alloc] init];
    preferences = mockProtocol(@protocol(TYPreferences));
    soundPlayer = mockProtocol(@protocol(TYSoundPlayer));
    timerContext = mockProtocol(@protocol(TYTimerContext));
    soundAgent = [[TYSoundAgent alloc] initWithSoundPlayer:soundPlayer preferences:preferences];

    [soundAgent playSoundsInResponseToEventsFrom:eventBus];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_play_sound_when_timer_starts_if_enabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS]) willReturnInteger:true];
    [eventBus publishEventWithType:TYEventTypeTimerStart data:timerContext];
    [verify(soundPlayer) playSoundWithName:SOUND_TIMER_START];
}

- (void)test_do_not_play_sound_when_timer_starts_if_disabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS]) willReturnInteger:false];
    [eventBus publishEventWithType:TYEventTypeTimerStart data:timerContext];
    [verifyCount(soundPlayer, never()) playSoundWithName:anything()];
}

- (void)test_play_sound_when_timer_goes_off_if_enabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF]) willReturnInteger:true];
    [eventBus publishEventWithType:TYEventTypeTimerGoesOff data:timerContext];
    [verify(soundPlayer) playSoundWithName:SOUND_TIMER_GOES_OFF];
}

- (void)test_do_not_play_sound_when_timer_goes_off_if_disabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF]) willReturnInteger:false];
    [eventBus publishEventWithType:TYEventTypeTimerGoesOff data:timerContext];
    [verifyCount(soundPlayer, never()) playSoundWithName:anything()];
}

- (void)test_play_ticking_sound_when_pomodoro_starts_if_enabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO]) willReturnInteger:true];
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK]) willReturnInteger:false];
    [eventBus publishEventWithType:TYEventTypePomodoroStart data:timerContext];
    [verify(soundPlayer) loopSoundWithName:SOUND_TIMER_TICK];
}

- (void)test_do_not_play_ticking_sound_when_pomodoro_starts_if_disabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO]) willReturnInteger:false];
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK]) willReturnInteger:true];
    [eventBus publishEventWithType:TYEventTypePomodoroStart data:timerContext];
    [verifyCount(soundPlayer, never()) loopSoundWithName:anything()];
}

- (void)test_play_ticking_sound_when_break_starts_if_enabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO]) willReturnInteger:false];
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK]) willReturnInteger:true];
    [eventBus publishEventWithType:TYEventTypeBreakStart data:timerContext];
    [verify(soundPlayer) loopSoundWithName:SOUND_TIMER_TICK];
}

- (void)test_do_not_play_ticking_sound_when_break_starts_if_disabled_by_preference
{
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO]) willReturnInteger:true];
    [given([preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK]) willReturnInteger:false];
    [eventBus publishEventWithType:TYEventTypeBreakStart data:timerContext];
    [verifyCount(soundPlayer, never()) loopSoundWithName:anything()];
}

- (void)test_stop_any_looping_sound_when_timer_stops
{
    [eventBus publishEventWithType:TYEventTypeTimerStop data:timerContext];
    [verify(soundPlayer) stopCurrentLoop];
}

@end
