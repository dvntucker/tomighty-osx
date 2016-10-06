//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

import Foundation

/**
 
 Tomighty's timer management
 
*/
public class Timer {
    let systemTimer: SystemTimer
    let timerEvents = TimerEvents()
    var currentTimerContext: TimerContext
    
    init(systemTimer: SystemTimer) {
        self.systemTimer = systemTimer
        self.currentTimerContext = TimerContext(
            contextType: TimerContextType.NONE, name: "None", remainingSeconds: 0)
    }
    
    public func start(context: TimerContext) {
        self.currentTimerContext = context
        systemTimer.triggerRepeatedly(intervalInSeconds: 1, {
            self.currentTimerContext.remainingSeconds = self.currentTimerContext.remainingSeconds - 1
            
            if self.currentTimerContext.remainingSeconds > 0 {
                self.timerEvents.notify(eventType: .TIMER_TICK, payload: self.currentTimerContext)
            }
            else {
                self.stop()
            }
        })
    }
    
    public func stop() {
        systemTimer.interrupt()
        self.timerEvents.notify(eventType: .TIMER_STOP, payload: currentTimerContext)
        if self.currentTimerContext.remainingSeconds <= 0 {
            self.timerEvents.notify(eventType: .READY_FOR_NEXT_TIMER, payload: self.currentTimerContext)
        }
    }
}


public enum TimerEventType {
    case POMODORO_START
    case TIMER_START
    case TIMER_STOP
    case TIMER_TICK
    case TIMER_ABORT
    case TIMER_GOES_OFF
    case READY_FOR_NEXT_TIMER
    case SHORT_BREAK_START
    case LONG_BREAK_START
}

public class TimerEvents: Events {
    internal var eventListeners = [TimerEventType : Array<(TimerContext)->Void>]()
    typealias EventType = TimerEventType
    typealias EventPayload = TimerContext
}
