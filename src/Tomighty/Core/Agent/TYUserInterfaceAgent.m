//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

#import "TYUserInterfaceAgent.h"
#import "TYTimerContext.h"

@implementation TYUserInterfaceAgent
{
    id <TYAppUI> ui;
}

- (id)initWith:(id <TYAppUI>)theAppUI
{
    self = [super init];
    if(self)
    {
        ui = theAppUI;
    }
    return self;
}

- (void)dispatchNewNotification: (NSString*) text
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = text;
    notification.soundName = NSUserNotificationDefaultSoundName;
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] deliverNotification:notification];
}

- (void)updateAppUiInResponseToEventsFrom:(id <TYEventBus>)eventBus
{
    [eventBus subscribeTo:APP_INIT subscriber:^(id eventData) {
        [ui switchToIdleState];
        [ui updateRemainingTime:0];
        [ui updatePomodoroCount:0];
    }];

    [eventBus subscribeTo:POMODORO_START subscriber:^(id eventData) {
        [ui switchToPomodoroState];
        [self dispatchNewNotification:@"Pomodoro started"];
    }];
    
    [eventBus subscribeTo:TIMER_STOP subscriber:^(id eventData) {
        [ui switchToIdleState];
    }];
    
    [eventBus subscribeTo:SHORT_BREAK_START subscriber:^(id eventData) {
        [ui switchToShortBreakState];
        [self dispatchNewNotification:@"Short break started"];
    }];
    
    [eventBus subscribeTo:LONG_BREAK_START subscriber:^(id eventData) {
        [ui switchToLongBreakState];
        [self dispatchNewNotification:@"Long break started"];
    }];
    
    [eventBus subscribeTo:TIMER_TICK subscriber:^(id eventData) {
        id <TYTimerContext> timerContext = eventData;
        [ui updateRemainingTime:[timerContext getRemainingSeconds]];
    }];
    
    [eventBus subscribeTo:POMODORO_COUNT_CHANGE subscriber:^(id eventData) {
        NSNumber *pomodoroCount = eventData;
        [ui updatePomodoroCount:[pomodoroCount intValue]];
    }];
}

@end
