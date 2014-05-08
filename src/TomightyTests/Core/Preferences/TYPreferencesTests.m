//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <XCTest/XCTest.h>

#import "TYPreferences.h"
#import "TYUserDefaultsPreferences.h"
#import "TYEventBusProtocol.h"
#import "TYMockEventBus.h"

@interface TYPreferencesTests : XCTestCase

@end

@implementation TYPreferencesTests
{
    id <TYPreferences> preferences;
    TYMockEventBus *eventBus;
}

- (void)setUp
{
    [super setUp];
    
    [self removeUserDefaults];

    eventBus = [[TYMockEventBus alloc] init];
    preferences = [[TYUserDefaultsPreferences alloc] initWithEventBus:eventBus];
}

- (void)tearDown
{
    [self removeUserDefaults];
    [super tearDown];
}

- (void)removeUserDefaults
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_TIME_POMODORO];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_TIME_SHORT_BREAK];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_TIME_LONG_BREAK];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK];
}

- (void)test_register_default_values_on_instantiation
{
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_TIME_POMODORO], (NSInteger)25);
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_TIME_SHORT_BREAK], (NSInteger)5);
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_TIME_LONG_BREAK], (NSInteger)15);
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS], (NSInteger)true);
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF], (NSInteger)true);
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO], (NSInteger)true);
    XCTAssertEqual([[NSUserDefaults standardUserDefaults] integerForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK], (NSInteger)true);
}

- (void)test_get_any_default_value
{
    XCTAssertEqual([preferences intForKey:PREF_TIME_POMODORO], 25);
}

- (void)test_set_and_get_integer_value
{
    [preferences setInt:123 forKey:PREF_TIME_POMODORO];
    XCTAssertEqual([preferences intForKey:PREF_TIME_POMODORO], 123);
}

- (void)test_fire_event_when_integer_value_changes_on_set
{
    [preferences setInt:987 forKey:PREF_TIME_POMODORO];
    
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)1);
    XCTAssertTrue([eventBus hasPublishedEvent:TYEventTypePreferencesDidChange withData:PREF_TIME_POMODORO atPosition:1]);
}

- (void)test_do_not_fire_any_event_when_integer_value_does_not_change_on_set
{
    [preferences setInt:25 forKey:PREF_TIME_POMODORO];
    XCTAssertEqual([eventBus getPublishedEventCount], (NSUInteger)0);
}

- (void)test_fire_PREFERENCE_CHANGE_event_only_after_integer_value_is_changed
{
    __block int valueWhenEventIsFired;
    
    [eventBus addObserverForEventType:TYEventTypePreferencesDidChange usingBlock:^(id eventData)
    {
        valueWhenEventIsFired = [preferences intForKey:PREF_TIME_POMODORO];
    }];
    
    [preferences setInt:999 forKey:PREF_TIME_POMODORO];
    
    XCTAssertEqual(valueWhenEventIsFired, 999);
}

@end
