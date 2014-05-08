//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYDefaultTimerContext.h"

@implementation TYDefaultTimerContext
{
    TYTimerContextType contextType;
    NSString *name;
    int remainingSeconds;
}

+ (instancetype)contextWithType:(TYTimerContextType)contextType name:(NSString *)name remainingSeconds:(int)initialRemainingSeconds
{
    return [[TYDefaultTimerContext alloc] initWithType:contextType name:name remainingSeconds:initialRemainingSeconds];
}

- (instancetype)initWithType:(TYTimerContextType)aContextType name:(NSString *)aName remainingSeconds:(int)initialRemainingSeconds
{
    self = [super init];
    if (self) {
        contextType = aContextType;
        name = aName;
        remainingSeconds = initialRemainingSeconds;
    }
    return self;
}

- (NSString *)name
{
    return name;
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
    return contextType;
}

@end
