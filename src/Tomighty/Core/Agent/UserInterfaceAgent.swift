//
//  UserInterfaceAgent.swift
//  Tomighty
//
//  Created by Devon Tucker on Sep/30/2016.
//  Copyright © 2016 Gig Software. All rights reserved.
//

import Foundation

public class UserInterfaceAgent {
    let appUI: TYAppUI
    let preferences: Preferences
    
    init(ui: TYAppUI, preferences: Preferences) {
        self.appUI = ui
        self.preferences = preferences
    }
    
    public func registerListeners(eventBus: EventBus) {
        eventBus.appEvents.subscribe(eventType: .APP_INIT, handler: { _ in
            self.appUI.switchToIdleState()
            self.appUI.updateRemainingTime(0, with: TYAppUIRemainingTimeMode.default)
            self.appUI.setStatusIconTextFormat(TYAppUIStatusIconTextFormat(rawValue: Int32(self.preferences.getInt(key: PREF_STATUS_ICON_TIME_FORMAT)))!)
            self.appUI.updatePomodoroCount(0)
        })
        
        eventBus.timerEvents.subscribe(eventType: .POMODORO_START, handler: { tc in
            self.appUI.switchToPomodoroState()
        })
        
        eventBus.timerEvents.subscribe(eventType: .TIMER_STOP, handler: { _ in
            self.appUI.switchToIdleState()
        })
        
        eventBus.timerEvents.subscribe(eventType: .SHORT_BREAK_START, handler: { _ in
            self.appUI.switchToPomodoroState()
        })
        
        eventBus.timerEvents.subscribe(eventType: .LONG_BREAK_START, handler: { _ in
            self.appUI.switchToLongBreakState()
        })
        
        eventBus.timerEvents.subscribe(eventType: .TIMER_TICK, handler: { tc in
            self.appUI.updateRemainingTime(Int32(tc.remainingSeconds), with: TYAppUIRemainingTimeMode.default)
        })
        
        eventBus.timerEvents.subscribe(eventType: .TIMER_START, handler: {tc in
            self.appUI.updateRemainingTime(Int32(tc.remainingSeconds), with: TYAppUIRemainingTimeMode.start)
        })
        
        eventBus.preferenceEvents.subscribe(eventType: .PREFERENCE_CHANGED, handler: {pce in
            if pce.preferenceName == PREF_STATUS_ICON_TIME_FORMAT {
                self.appUI.setStatusIconTextFormat(TYAppUIStatusIconTextFormat(rawValue: Int32(self.preferences.getInt(key: PREF_STATUS_ICON_TIME_FORMAT)))!)
            }
        })
        
        eventBus.appEvents.subscribe(eventType: .POMODORO_COUNT_CHANGE, handler: { newPomCount in 
            self.appUI.updatePomodoroCount(newPomCount as! Int32)
        })
    }
}
