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

#import "TYAppUIProtocol.h"
#import "TYMockEventBus.h"
#import "TYTimerContextProtocol.h"
#import "TYUserInterfaceAgent.h"

@interface TYUserInterfaceAgentTests : XCTestCase

@end

@implementation TYUserInterfaceAgentTests
{
    id <TYAppUI> ui;
    TYMockEventBus *eventBus;
    TYUserInterfaceAgent *uiAgent;
}

- (void)setUp
{
    [super setUp];
    ui = mockProtocol(@protocol(TYAppUI));
    eventBus = [[TYMockEventBus alloc] init];
    uiAgent = [[TYUserInterfaceAgent alloc] initWithApplicationUI:ui];
    
    [uiAgent updateAppUiInResponseToEventsFromEventBus:eventBus];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)test_switch_ui_to_idle_state_when_application_is_initialized
{
    [eventBus publishEventWithType:TYEventTypeApplicationInit data:nil];
    [verify(ui) switchToIdleState];
}

- (void)test_update_remaining_time_to_zero_when_application_is_initialized
{
    [eventBus publishEventWithType:TYEventTypeApplicationInit data:nil];
    [verify(ui) updateRemainingTime:0];
}

- (void)test_update_pomodoro_count_to_zero_when_application_is_initialized
{
    [eventBus publishEventWithType:TYEventTypeApplicationInit data:nil];
    [verify(ui) updatePomodoroCount:0];
}

- (void)test_switch_ui_to_idle_state_when_timer_stops
{
    [eventBus publishEventWithType:TYEventTypeTimerStop data:nil];
    [verify(ui) switchToIdleState];
}

- (void)test_switch_ui_to_pomodoro_state_when_pomodoro_starts
{
    [eventBus publishEventWithType:TYEventTypePomodoroStart data:nil];
    [verify(ui) switchToPomodoroState];
}

- (void)test_switch_ui_to_short_break_state_when_short_break_starts
{
    [eventBus publishEventWithType:TYEventTypeShortBreakStart data:nil];
    [verify(ui) switchToShortBreakState];
}

- (void)test_switch_ui_to_long_break_state_when_long_break_starts
{
    [eventBus publishEventWithType:TYEventTypeLongBreakStart data:nil];
    [verify(ui) switchToLongBreakState];
}

- (void)test_update_remaining_time_when_timer_ticks
{
    id <TYTimerContext> timerContext = mockProtocol(@protocol(TYTimerContext));
    
    [given(timerContext.remainingSeconds) willReturnInt:270];
    
    [eventBus publishEventWithType:TYEventTypeTimerTick data:timerContext];
    [verify(ui) updateRemainingTime:timerContext.remainingSeconds];
}

- (void)test_update_pomodoro_count_when_it_changes
{
    NSNumber *pomodoroCount = [NSNumber numberWithInt:3];
    [eventBus publishEventWithType:TYEventTypePomodoroCountChange data:pomodoroCount];
    [verify(ui) updatePomodoroCount:3];
}

@end
