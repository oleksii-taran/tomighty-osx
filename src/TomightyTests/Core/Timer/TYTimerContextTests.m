//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <XCTest/XCTest.h>
#import "TYTimerContextProtocol.h"
#import "TYDefaultTimerContext.h"

@interface TYTimerContextTests : XCTestCase

@end

@implementation TYTimerContextTests
{
    id <TYTimerContext> timerContext;
}

- (void)test_context_type
{
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypeShortBreak name:nil remainingSeconds:0];
    XCTAssertEqual(timerContext.type, TYTimerContextTypeShortBreak);
    
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypePomodoro name:nil remainingSeconds:0];
    XCTAssertEqual(timerContext.type, TYTimerContextTypePomodoro);
}

- (void)test_context_name
{
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypePomodoro name:@"Foo bar" remainingSeconds:0];
    XCTAssertEqualObjects(timerContext.name, @"Foo bar");
    
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypePomodoro name:@"Hello" remainingSeconds:0];
    XCTAssertEqualObjects(timerContext.name, @"Hello");
}

- (void)test_initial_remaining_seconds
{
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypePomodoro name:nil remainingSeconds:579];
    XCTAssertEqual(timerContext.remainingSeconds, 579);
}

- (void)test_add_seconds
{
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypePomodoro name:nil remainingSeconds:10];
    [timerContext addSeconds:3];
    XCTAssertEqual(timerContext.remainingSeconds, 13);
}

- (void)test_subtract_seconds
{
    timerContext = [TYDefaultTimerContext contextWithType:TYTimerContextTypePomodoro name:nil remainingSeconds:10];
    [timerContext addSeconds:-2];
    XCTAssertEqual(timerContext.remainingSeconds, 8);
}

@end
