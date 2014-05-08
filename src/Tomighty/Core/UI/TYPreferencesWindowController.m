//
//  TYPreferencesWindowController.m
//  Tomighty
//
//  Created by Célio Cidral Jr on 12/03/14.
//  Copyright (c) 2014 Gig Software. All rights reserved.
//

#import "TYPreferences.h"
#import "TYPreferencesWindowController.h"

@interface TYPreferencesWindowController ()

@end

@implementation TYPreferencesWindowController
{
    id <TYPreferences> preferences;
}

- (instancetype)initWithPreferences:(id <TYPreferences>)aPreferences
{
    self = [super initWithWindowNibName:@"PreferencesWindow"];
	if (self)
    {
        preferences = aPreferences;
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    [self.text_time_pomodoro setIntValue:[preferences intForKey:PREF_TIME_POMODORO]];
    [self.text_time_short_break setIntValue:[preferences intForKey:PREF_TIME_SHORT_BREAK]];
    [self.text_time_long_break setIntValue:[preferences intForKey:PREF_TIME_LONG_BREAK]];
    [self.check_play_sound_when_timer_starts setState:[preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS]];
    [self.check_play_sound_when_timer_goes_off setState:[preferences intForKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF]];
    [self.check_play_ticktock_sound_during_pomodoro setState:[preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO]];
    [self.check_play_ticktock_sound_during_break setState:[preferences intForKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK]];
}

- (void)windowWillClose:(NSNotification *)notification {
    // Force text controls to end editing before close
    [self.window makeFirstResponder:nil];
}

- (IBAction)save_time_pomodoro:(id)sender {
    [preferences setInt:[self.text_time_pomodoro intValue] forKey:PREF_TIME_POMODORO];
}

- (IBAction)save_time_short_break:(id)sender {
    [preferences setInt:[self.text_time_short_break intValue] forKey:PREF_TIME_SHORT_BREAK];
}

- (IBAction)save_time_long_break:(id)sender {
    [preferences setInt:[self.text_time_long_break intValue] forKey:PREF_TIME_LONG_BREAK];
}

- (IBAction)save_play_sound_when_timer_starts:(id)sender {
    [preferences setInt:(int)[self.check_play_sound_when_timer_starts state] forKey:PREF_PLAY_SOUND_WHEN_TIMER_STARTS];
}

- (IBAction)save_play_sound_when_timer_goes_off:(id)sender {
    [preferences setInt:(int)[self.check_play_sound_when_timer_goes_off state] forKey:PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF];
}

- (IBAction)save_play_ticktock_sound_during_pomodoro:(id)sender {
    [preferences setInt:(int)[self.check_play_ticktock_sound_during_pomodoro state] forKey:PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO];
}

- (IBAction)save_play_ticktock_sound_during_break:(id)sender {
    [preferences setInt:(int)[self.check_play_ticktock_sound_during_break state] forKey:PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK];
}

@end
