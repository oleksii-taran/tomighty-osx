//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TYTimerContextType)
{
    TYTimerContextTypePomodoro,
    TYTimerContextTypeShortBreak,
    TYTimerContextTypeLongBreak,
};

@protocol TYTimerContext <NSObject>

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, assign, readonly) int remainingSeconds;
@property (nonatomic, assign, readonly) TYTimerContextType type;

- (void)addSeconds:(int)seconds;

@end
