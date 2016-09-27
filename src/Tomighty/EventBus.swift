//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

import Foundation

/**
 Simple event management for Tomighty.
**/
public class EventBus {
    
    private var eventDict: Dictionary<EventType, Array<EventHandler>>
    
    init() {
        eventDict = [EventType: Array<EventHandler>]()
    }
    
    public func subscribeTo(eventType: EventType, handler: @escaping ((EventContext) -> ())) {
        let newHandler = EventHandler(handler)
        self.subscribeTo(eventType: eventType, handler: newHandler)
    }
    
    public func subscribeTo(eventType: EventType, handler: EventHandler) {
        var handlers = eventDict[eventType] ?? []
        handlers.append(handler)
        eventDict.updateValue(handlers, forKey: eventType)
    }
    
    public func publish(eventType: EventType, data: EventContext) {
        
        if let handlers = eventDict[eventType] {
            for handler in handlers {
                handler.handlerFunc(data)
            }
        }
    }
    
}

public class EventContext {

}

public enum EventType {
    case APP_INIT
    case TIMER_START
    case TIMER_TICK
    case TIMER_ABORT
    case TIMER_GOES_OFF
    
    case POMODORO_START
    case BREAK_START
    case SHORT_BREAK_START
    case LONG_BREAK_START
    
    case POMODORO_COMPLETE
    case POMODORO_COUNT_CHANGE
    
    case PREFERENCE_CHANGE
    case READY_FOR_NEXT_TIMER
}

public class EventHandler {
    
    let handlerFunc: (EventContext) -> ()
    
    init(_ handlerFunc: @escaping (EventContext) -> ()) {
        self.handlerFunc = handlerFunc
    }
}

