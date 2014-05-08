//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYDefaultTomighty.h"
#import "TYDefaultTimerContext.h"
#import "TYEventBusProtocol.h"
#import "TYPreferences.h"

@implementation TYDefaultTomighty
{
    int pomodoroCount;
    
    id <TYTimer> timer;
    id <TYPreferences> preferences;
    id <TYEventBus> eventBus;
}

- (instancetype)initWithTimer:(id <TYTimer>)aTimer preferences:(id <TYPreferences>)aPreferences eventBus:(id <TYEventBus>)anEventBus
{
    self = [super init];
    if (self)
    {
        pomodoroCount = 0;
        timer = aTimer;
        preferences = aPreferences;
        eventBus = anEventBus;
        
        [eventBus addObserverForEventType:TYEventTypePomodoroComplete usingBlock:^(id eventData)
        {
            [self incrementPomodoroCount];
        }];
    }
    return self;
}

- (void)startTimerWithContextType:(TYTimerContextType)contextType name:(NSString *)contextName minutes:(int)minutes
{
    id <TYTimerContext> timerContext = [TYDefaultTimerContext contextWithType:contextType name:contextName remainingSeconds:minutes * 60];
    [timer startWithContext:timerContext];
}

- (void)startPomodoro
{
    [self startTimerWithContextType:TYTimerContextTypePomodoro name:@"Pomodoro" minutes:[preferences intForKey:PREF_TIME_POMODORO]];
}

- (void)startShortBreak
{
    [self startTimerWithContextType:TYTimerContextTypeShortBreak name:@"Short break" minutes:[preferences intForKey:PREF_TIME_SHORT_BREAK]];
}

- (void)startLongBreak
{
    [self startTimerWithContextType:TYTimerContextTypeLongBreak name:@"Long break" minutes:[preferences intForKey:PREF_TIME_LONG_BREAK]];
}

- (void)stopTimer
{
    [timer stop];
}

- (void)setPomodoroCount:(int)newCount
{
    pomodoroCount = newCount;
    [eventBus publishEventWithType:TYEventTypePomodoroCountChange data:[NSNumber numberWithInt:pomodoroCount]];
}

- (void)resetPomodoroCount
{
    [self setPomodoroCount:0];
}

- (void)incrementPomodoroCount
{
    int newCount = pomodoroCount + 1;
    
    if (newCount > 4)
    {
        newCount = 1;
    }
    
    [self setPomodoroCount:newCount];
}

@end
