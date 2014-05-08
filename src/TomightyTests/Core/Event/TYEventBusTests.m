//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <XCTest/XCTest.h>
#import "TYEventBusProtocol.h"
#import "TYDefaultEventBus.h"

@interface TYEventBusTests : XCTestCase

@end

@implementation TYEventBusTests
{
    id<TYEventBus> eventBus;
}

- (void)setUp
{
    [super setUp];
    eventBus = [[TYDefaultEventBus alloc] init];
}

- (void)test_subscriber_receives_event_of_desired_type
{
    __block BOOL hasReceivedEvent = false;
    
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
    {
        hasReceivedEvent = true;
    }];
    
    [eventBus publishEventWithType:TYEventTypeTimerStart data:nil];
    
    XCTAssertTrue(hasReceivedEvent);
}

- (void)test_subscriber_does_not_receive_event_of_undesired_type
{
    __block BOOL hasReceivedEvent = false;
    
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
     {
         hasReceivedEvent = true;
     }];
    
    [eventBus publishEventWithType:TYEventTypeTimerStop data:nil];
    
    XCTAssertFalse(hasReceivedEvent);
}

- (void)test_subscriber_receives_the_correct_event_data
{
    __block id receivedEventData;
    id expectedEventData = @"Foo bar";

    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
    {
        receivedEventData = eventData;
    }];

    [eventBus publishEventWithType:TYEventTypeTimerStart data:expectedEventData];

    XCTAssertEqualObjects(receivedEventData, expectedEventData);
}

- (void)test_two_subscribers_receive_event_of_desired_type
{
    __block BOOL hasFirstSubscriberReceivedEvent = false;
    __block BOOL hasSecondSubscriberReceivedEvent = false;
    
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
     {
         hasFirstSubscriberReceivedEvent = true;
     }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
     {
         hasSecondSubscriberReceivedEvent = true;
     }];
    
    [eventBus publishEventWithType:TYEventTypeTimerStart data:nil];
    
    XCTAssertTrue(hasFirstSubscriberReceivedEvent);
    XCTAssertTrue(hasSecondSubscriberReceivedEvent);
}

- (void)test_subscribers_only_receive_events_of_desired_type
{
    __block BOOL hasFirstSubscriberReceivedEvent = false;
    __block BOOL hasSecondSubscriberReceivedEvent = false;
    __block BOOL hasThirdSubscriberReceivedEvent = false;

    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
     {
         hasFirstSubscriberReceivedEvent = true;
     }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerTick usingBlock:^(id eventData)
     {
         hasSecondSubscriberReceivedEvent = true;
     }];
    
    [eventBus addObserverForEventType:TYEventTypeTimerStart usingBlock:^(id eventData)
     {
         hasThirdSubscriberReceivedEvent = true;
     }];
    
    [eventBus publishEventWithType:TYEventTypeTimerTick data:nil];
    
    XCTAssertFalse(hasFirstSubscriberReceivedEvent);
    XCTAssertTrue(hasSecondSubscriberReceivedEvent);
    XCTAssertFalse(hasThirdSubscriberReceivedEvent);
}

- (void)test_do_not_give_error_when_publishing_event_with_no_subscribers
{
    [eventBus publishEventWithType:TYEventTypeTimerTick data:nil];
}

@end
