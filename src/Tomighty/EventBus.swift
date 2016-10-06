//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

import Foundation

public class EventBus {
    public var timerEvents = TimerEvents()
    public var preferenceEvents = PreferenceChangeEvents()
    public var appEvents = ApplicationEvents()
}

/**
 Simple event management for Tomighty.
**/
protocol Events {
    associatedtype EventType: Hashable
    associatedtype EventPayload
    typealias HandlerType = (EventPayload) -> Void
    
    var eventListeners: [EventType: Array<HandlerType>] { get set }
    
}

extension Events {
    public mutating func subscribe(eventType: EventType, handler: @escaping HandlerType) {
        var handlersForType: [HandlerType] = eventListeners[eventType] ?? []
        handlersForType.append(handler)
        eventListeners.updateValue(handlersForType, forKey: eventType)
    }
    
    public func notify(eventType: EventType, payload: EventPayload) {
        let handlers = eventListeners[eventType]
        handlers?.forEach({ handler in
            handler(payload)
        })
    }
}

public class ApplicationEvents: Events {
    typealias EventType = ApplicationEventType
    //for generic application events, subscribe will just have to cast for now.
    typealias EventPayload = Any
        internal var eventListeners: [ApplicationEventType : Array<(Any) -> Void>] = [:]
}

public enum ApplicationEventType {
    case APP_INIT
    case BREAK_START
    case POMODORO_COMPLETE
    case POMODORO_COUNT_CHANGE
    case PREFERENCE_CHANGE
    case READY_FOR_NEXT_TIMER
}

