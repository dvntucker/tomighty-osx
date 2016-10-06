//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

import Foundation

public enum TimerContextType {
    case POMODORO
    case SHORT_BREAK
    case LONG_BREAK
    case NONE
}

public class TimerContext {
    public let contextType: TimerContextType
    public let name: String
    public var remainingSeconds: Int
    
    init(contextType: TimerContextType, name: String, remainingSeconds: Int) {
        self.contextType = contextType
        self.name = name
        self.remainingSeconds = remainingSeconds
    }
    
}
