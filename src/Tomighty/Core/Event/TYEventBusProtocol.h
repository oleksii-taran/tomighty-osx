//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TYEventType)
{
    TYEventTypeApplicationInit = 0,
    
    TYEventTypeTimerStart   = 1,
    TYEventTypeTimerTick    = 2,
    TYEventTypeTimerStop    = 3,
    TYEventTypeTimerAbort   = 4,
    TYEventTypeTimerGoesOff = 5,
    
    TYEventTypePomodoroStart   = 6,
    TYEventTypeBreakStart      = 7,
    TYEventTypeShortBreakStart = 8,
    TYEventTypeLongBreakStart  = 9,
    
    TYEventTypePomodoroComplete    = 10,
    TYEventTypePomodoroCountChange = 11,
    
    TYEventTypePreferencesDidChange = 12,
};

typedef void (^TYEventSubscriber)(id eventData);

@protocol TYEventBus <NSObject>

- (void)addObserverForEventType:(TYEventType)eventType usingBlock:(TYEventSubscriber)subscriber;
- (void)publishEventWithType:(TYEventType)eventType data:(id)data;

@end
