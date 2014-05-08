//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import <Foundation/Foundation.h>

#import "TYAppUIProtocol.h"
#import "TYStatusIconProtocol.h"
#import "TYStatusMenuProtocol.h"

@interface TYDefaultAppUI : NSObject <TYAppUI>

- (instancetype)initWithStatusMenu:(id <TYStatusMenu>)statusMenu statusIcon:(id<TYStatusIcon>)statusIcon;

@end
