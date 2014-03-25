//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>
#import "TYSystemTimer.h"

@interface TYMockSystemTimer : NSObject <TYSystemTimer>

- (void)tick;
- (BOOL)isInterrupted;

@end
