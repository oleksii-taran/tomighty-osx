//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYMockTimerContext.h"

@implementation TYMockTimerContext
{
    int remainingSeconds;
}

- (id)initWithRemainingSeconds:(int)initialRemainingSeconds
{
    self = [super init];
    if(self)
    {
        remainingSeconds = initialRemainingSeconds;
    }
    return self;
}

- (NSString *)name
{
    return nil;
}

- (int)remainingSeconds
{
    return remainingSeconds;
}

- (void)addSeconds:(int)seconds
{
    remainingSeconds += seconds;
}

- (TYTimerContextType)type
{
    return -1;
}

@end
