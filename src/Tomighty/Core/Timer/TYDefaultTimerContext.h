//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>
#import "TYTimerContextProtocol.h"

@interface TYDefaultTimerContext : NSObject <TYTimerContext>

+ (instancetype)contextWithType:(TYTimerContextType)contextType name:(NSString *)name remainingSeconds:(int)initialRemainingSeconds;

@end
