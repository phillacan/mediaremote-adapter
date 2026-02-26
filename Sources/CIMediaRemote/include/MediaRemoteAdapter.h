//
//  MediaRemoteAdapter.h
//
//  Copyright © 2024 Ethan Bills. All rights reserved.
//

#ifndef MediaRemoteAdapter_h
#define MediaRemoteAdapter_h

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif

void bootstrap(void);
void loop(void);
void get(void);
void play(void);
void pause_command(void);
void toggle_play_pause(void);
void next_track(void);
void previous_track(void);
void stop_command(void);
void set_time_from_env(void);
void set_shuffle_mode(void);
void set_repeat_mode(void);

void get_active_bids(void);
void loop_no_debounce(void);
void set_override_enabled(void);
void set_overridden_app(void);


#ifdef __cplusplus
}
#endif

#endif /* MediaRemoteAdapter_h */ 
