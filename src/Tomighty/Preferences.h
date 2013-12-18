//
//  Preferences.h
//  Tomighty
//
//  Created by Célio Cidral Jr on 28/07/13.
//  Copyright (c) 2013 Célio Cidral Jr. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PREF_TIME_POMODORO;
extern NSString * const PREF_TIME_SHORT_BREAK;
extern NSString * const PREF_TIME_LONG_BREAK;
extern NSString * const PREF_SOUND_TIMER_START;
extern NSString * const PREF_SOUND_TIMER_FINISH;
extern NSString * const PREF_SOUND_TICTAC_POMODORO;
extern NSString * const PREF_SOUND_TICTAC_BREAK;

@interface Preferences : NSObject

+ (NSInteger)integerForKey:(NSString *)key;
+ (BOOL)boolForKey:(NSString *)key;

+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

@end
