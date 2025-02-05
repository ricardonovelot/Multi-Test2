import Foundation

// Time components model for handling cook time
struct TimeComponents {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    var formatted: String {
        String(format: "%02dh %02dm %02ds", hours, minutes, seconds)
    }
    
    var timeInterval: TimeInterval {
        TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }
    
    static func from(timeInterval: TimeInterval) -> TimeComponents {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        return TimeComponents(hours: hours, minutes: minutes, seconds: seconds)
    }
}

