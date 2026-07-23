import UserNotifications
import Foundation

let args = CommandLine.arguments
guard args.count >= 3 else {
    print("Usage: tmux-notify <title> <message>")
    exit(1)
}

let title = args[1]
let message = args[2]

let center = UNUserNotificationCenter.current()
center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
    guard granted else {
        exit(1)
    }
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = message
    content.sound = .default
    
    let request = UNNotificationRequest(
        identifier: UUID().uuidString,
        content: content,
        trigger: nil
    )
    
    center.add(request) { error in
        if error != nil {
            exit(1)
        }
        exit(0)
    }
}

RunLoop.main.run(until: Date(timeIntervalSinceNow: 5))
