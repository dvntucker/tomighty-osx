//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

import Foundation

let PREF_TIME_POMODORO = "org.tomighty.time.pomodoro"
let PREF_TIME_SHORT_BREAK = "org.tomighty.time.short_break"
let PREF_TIME_LONG_BREAK = "org.tomighty.time.long_break"
let PREF_PLAY_SOUND_WHEN_TIMER_STARTS = "org.tomighty.sound.play_on_timer_start"
let PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF = "org.tomighty.sound.play_on_timer_stop"
let PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO = "org.tomighty.sound.play_tick_tock_during_pomodoro"
let PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK = "org.tomighty.sound.play_tick_tock_during_break"
let PREF_CONTINUOUS_MODE = "org.tomighty.continuous"
let PREF_STATUS_ICON_TIME_FORMAT = "org.tomighty.general.status_icon_time_format"
let PREF_STATUS_ICON_TIME_FORMAT_NONE = 0
let PREF_STATUS_ICON_TIME_FORMAT_MINUTES = 1
let PREF_STATUS_ICON_TIME_FORMAT_SECONDS = 2
let PREF_HOTKEY_START = "org.tomighty.hotkey.start"
let PREF_HOTKEY_STOP = "org.tomighty.hotkey.stop"

public class Preferences {
    private let preferenceEvents = PreferenceChangeEvents()
    
    init() {
        let defaultValues: [String : Any] = [
            PREF_TIME_POMODORO : 25,
            PREF_TIME_SHORT_BREAK : 5,
            PREF_TIME_LONG_BREAK : 15,
            PREF_PLAY_SOUND_WHEN_TIMER_STARTS : true,
            PREF_PLAY_SOUND_WHEN_TIMER_GOES_OFF : true,
            PREF_PLAY_TICKTOCK_SOUND_DURING_POMODORO : false,
            PREF_PLAY_TICKTOCK_SOUND_DURING_BREAK : false,
            PREF_CONTINUOUS_MODE : false,
            PREF_STATUS_ICON_TIME_FORMAT : PREF_STATUS_ICON_TIME_FORMAT_NONE,
            PREF_HOTKEY_START : "^⌘P",
            PREF_HOTKEY_STOP : "^⌘S"
        ]
        
        UserDefaults.standard.register(defaults: defaultValues)
    }
    
    public func getInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    public func setInt(key: String, value: Int) {
        let currentValue = self.getInt(key: key)
        if value != currentValue {
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
            preferenceEvents.notify(eventType: .PREFERENCE_CHANGED,
                                    payload: PreferenceChangeEvent(preferenceName: key,
                                                                   oldValue: currentValue,
                                                                   newValue: value))
        }
    }
    
    public func getString(key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    public func setString(value: String, key: String) {
        if let currentValue = self.getString(key: key) {
            if currentValue != value {
                
            }
        }
    }
}

public enum PreferenceEventType {
    case PREFERENCE_CHANGED
}

public struct PreferenceChangeEvent {
    let preferenceName: String
    let oldValue: Any
    let newValue: Any
}

public class PreferenceChangeEvents: Events {
    typealias EventType = PreferenceEventType
    typealias EventPayload = PreferenceChangeEvent
    
    internal var eventListeners = [PreferenceEventType : Array<(PreferenceChangeEvent)->Void>]()
}
