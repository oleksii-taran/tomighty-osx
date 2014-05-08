//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYUserInterfaceAgent.h"
#import "TYTimerContextProtocol.h"

@implementation TYUserInterfaceAgent
{
    id <TYAppUI> ui;
}

- (instancetype)initWithApplicationUI:(id <TYAppUI>)theAppUI
{
    self = [super init];
    if(self)
    {
        ui = theAppUI;
    }
    return self;
}

- (void)updateAppUiInResponseToEventsFromEventBus:(id <TYEventBus>)eventBus
{
    [eventBus addObserverForEventType:TYEventTypeApplicationInit usingBlock:^(id eventData) {
        [ui switchToIdleState];
        [ui updateRemainingTime:0];
        [ui updatePomodoroCount:0];
    }];

    [eventBus addObserverForEventType:TYEventTypePomodoroStart usingBlock:^(id eventData) {
        [ui switchToPomodoroState];
    }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerStop usingBlock:^(id eventData) {
        [ui switchToIdleState];
    }];
    
    [eventBus addObserverForEventType:TYEventTypeShortBreakStart usingBlock:^(id eventData) {
        [ui switchToShortBreakState];
    }];
    
    [eventBus addObserverForEventType:TYEventTypeLongBreakStart usingBlock:^(id eventData) {
        [ui switchToLongBreakState];
    }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerTick usingBlock:^(id eventData) {
        id <TYTimerContext> timerContext = eventData;
        [ui updateRemainingTime:timerContext.remainingSeconds];
    }];
    
    [eventBus addObserverForEventType:TYEventTypePomodoroCountChange usingBlock:^(id eventData) {
        NSNumber *pomodoroCount = eventData;
        [ui updatePomodoroCount:[pomodoroCount intValue]];
    }];
}

@end
