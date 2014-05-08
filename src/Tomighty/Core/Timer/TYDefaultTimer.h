//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>
#import "TYEventBusProtocol.h"
#import "TYSystemTimerProtocol.h"
#import "TYTimerContextProtocol.h"
#import "TYTimerProtocol.h"

@interface TYDefaultTimer : NSObject <TYTimer>

+ (instancetype)timerWithEventBus:(id<TYEventBus>)anEventBus systemTimer:(id<TYSystemTimer>)aSystemTimer;

@end
