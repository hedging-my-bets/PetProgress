import UserNotifications, Foundation
enum NightNudge {
    static func schedule8pm(localTasks: [String]) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound,.badge]) { _, _ in }
        let content = UNMutableNotificationContent()
        let names = Array(localTasks.prefix(2)).joined(separator: " & ")
        content.title = names.isEmpty ? "Daily check-in" : "Done: \(names)?"
        content.body = "Finish your habits and evolve your pet."
        content.categoryIdentifier = "PP_DAILY"
        var date = DateComponents(); date.hour = 20; date.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let req = UNNotificationRequest(identifier: "pp_night_8pm", content: content, trigger: trigger)
        center.add(req)
        let done = UNNotificationAction(identifier: "PP_DONE", title: "Mark Done", options: [.foreground])
        let open = UNNotificationAction(identifier: "PP_OPEN", title: "Open", options: [.foreground])
        let cat = UNNotificationCategory(identifier: "PP_DAILY", actions: [done, open], intentIdentifiers: [], options: [])
        center.setNotificationCategories([cat])
    }
}