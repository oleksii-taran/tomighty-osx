//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYSyntheticEventPublisher.h"
#import "TYTimerContextProtocol.h"

@implementation TYSyntheticEventPublisher

- (void)publishSyntheticEventsInResponseToOtherEventsFrom:(id <TYEventBus>)eventBus
{
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
    {
        id <TYTimerContext> timerContext = eventData;
        
        if (timerContext.type == TYTimerContextTypePomodoro)
        {
            [eventBus publishEventWithType:TYEventTypePomodoroStart data:timerContext];
        }
        else if (timerContext.type == TYTimerContextTypeShortBreak)
        {
            [eventBus publishEventWithType:TYEventTypeBreakStart data:timerContext];
            [eventBus publishEventWithType:TYEventTypeShortBreakStart data:timerContext];
        }
        else if (timerContext.type == TYTimerContextTypeLongBreak)
        {
            [eventBus publishEventWithType:TYEventTypeBreakStart data:timerContext];
            [eventBus publishEventWithType:TYEventTypeLongBreakStart data:timerContext];
        }
    }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerStop usingBlock:^(id eventData)
    {
        id <TYTimerContext> timerContext = eventData;
        
        if (timerContext.remainingSeconds > 0)
        {
            [eventBus publishEventWithType:TYEventTypeTimerAbort data:eventData];
        }
        else
        {
            [eventBus publishEventWithType:TYEventTypeTimerGoesOff data:eventData];
            if (timerContext.type == TYTimerContextTypePomodoro)
            {
                [eventBus publishEventWithType:TYEventTypePomodoroComplete data:timerContext];
            }
        }
    }];
}

@end
