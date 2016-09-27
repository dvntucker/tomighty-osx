//
//  Tomighty - http://www.tomighty.org
//
//  This software is licensed under the Apache License Version 2.0:
//  http://www.apache.org/licenses/LICENSE-2.0.txt
//

import Foundation
import SwiftyTimer

public class SystemTimer {
    
    var timer: Foundation.Timer?
    
    public func triggerRepeatedly(trigger: @escaping () -> Void, intervalInSeconds: Double) {
        timer = Foundation.Timer.every(intervalInSeconds.seconds, trigger)
    }
    
    public func interrupt() {
        timer?.invalidate()
    }
}
