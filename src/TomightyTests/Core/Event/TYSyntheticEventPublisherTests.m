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
#import "TYSyntheticEventPublisher.h"
#import "TYTimerContextProtocol.h"

@interface TYSyntheticEventPublisherTests : XCTestCase

@end

@implementation TYSyntheticEventPublisherTests
{
    TYSyntheticEventPublisher *syntheticEventPublisher;
    TYMockEventBus *eventBus;
    id <TYTimerContext> timerContext;
}

- (void)setUp
{
    [super setUp];
    
    eventBus = [[TYMockEventBus alloc] init];
    timerContext = mockProtocol(@protocol(TYTimerContext));
    syntheticEventPublisher = [[TYSyntheticEventPublisher alloc] init];
    
    [syntheticEventPublisher publishSyntheticEventsInResponseToOtherEventsFrom:eventBus];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_publish_POMODORO_START_event_when_timer_starts_in_pomodoro_context
{
    [given(timerContext.type) willReturnInt:TYTimerContextTypePomodoro];
    
    [eventBus publishEventWithType:TYEventTypeTimerStart data:timerContext];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)2);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerStart withData:timerContext atPosition:1]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypePomodoroStart withData:timerContext atPosition:2]);
}

- (void)test_publish_BREAK_START_and_SHORT_BREAK_START_events_when_timer_starts_in_short_break_context
{
    [given(timerContext.type) willReturnInt:TYTimerContextTypeShortBreak];
    
    [eventBus publishEventWithType:TYEventTypeTimerStart data:timerContext];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)3);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerStart withData:timerContext atPosition:1]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeBreakStart withData:timerContext atPosition:2]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeShortBreakStart withData:timerContext atPosition:3]);
}

- (void)test_publish_BREAK_START_and_LONG_BREAK_START_events_when_timer_starts_in_long_break_context
{
    [given(timerContext.type) willReturnInt:TYTimerContextTypeLongBreak];
    
    [eventBus publishEventWithType:TYEventTypeTimerStart data:timerContext];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)3);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerStart withData:timerContext atPosition:1]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeBreakStart withData:timerContext atPosition:2]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeLongBreakStart withData:timerContext atPosition:3]);
}

- (void)test_publish_TIMER_GOES_OFF_event_when_timer_stops_and_remaining_seconds_is_zero
{
    [given(timerContext.type) willReturnInt:-1];
    [given(timerContext.remainingSeconds) willReturnInt:0];
    
    [eventBus publishEventWithType:TYEventTypeTimerStop data:timerContext];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)2);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerStop withData:timerContext atPosition:1]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerGoesOff withData:timerContext atPosition:2]);
}

- (void)test_publish_POMODORO_COMPLETE_event_when_timer_stops_in_pomodoro_context_and_remaining_seconds_is_zero
{
    [given(timerContext.type) willReturnInt:TYTimerContextTypePomodoro];
    [given(timerContext.remainingSeconds) willReturnInt:0];
    
    [eventBus publishEventWithType:TYEventTypeTimerStop data:timerContext];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)3);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerStop withData:timerContext atPosition:1]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerGoesOff withData:timerContext atPosition:2]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypePomodoroComplete withData:timerContext atPosition:3]);
}

- (void)test_publish_TIMER_ABORT_event_when_timer_stops_and_remaining_seconds_is_greater_than_zero
{
    [given(timerContext.remainingSeconds) willReturnInt:1];
    
    [eventBus publishEventWithType:TYEventTypeTimerStop data:timerContext];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)2);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerStop withData:timerContext atPosition:1]);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypeTimerAbort withData:timerContext atPosition:2]);
}

@end
