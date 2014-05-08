//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYEventBusProtocol.h"
#import "TYDefaultTimer.h"
#import "TYTimerContextProtocol.h"

@implementation TYDefaultTimer
{
    id<TYEventBus> eventBus;
    id<TYSystemTimer> systemTimer;
    id<TYTimerContext> currentTimerContext;
}

+ (instancetype)timerWithEventBus:(id<TYEventBus>)anEventBus systemTimer:(id<TYSystemTimer>)aSystemTimer
{
    return [[TYDefaultTimer alloc] initWithEventBus:anEventBus systemTimer:aSystemTimer];
}

- (id)initWithEventBus:(id<TYEventBus>)anEventBus systemTimer:(id<TYSystemTimer>)aSystemTimer
{
    self = [super init];
    if (self)
    {
        eventBus = anEventBus;
        systemTimer = aSystemTimer;
    }
    return self;
}

- (void)startWithContext:(id<TYTimerContext>)context
{
    currentTimerContext = context;
    
    TYSystemTimerTrigger trigger = ^()
    {
        [context addSeconds:-1];
        
        if (context.remainingSeconds > 0)
        {
            [eventBus publishEventWithType:TYEventTypeTimerTick data:context];
        }
        else
        {
            [self stop];
        }
    };
    [systemTimer triggerRepeatedly:trigger intervalInSeconds:1];
    [eventBus publishEventWithType:TYEventTypeTimerStart data:context];
}

- (void)stop
{
    [systemTimer interrupt];
    [eventBus publishEventWithType:TYEventTypeTimerStop data:currentTimerContext];
}

@end
