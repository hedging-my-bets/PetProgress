import WidgetKit
import SwiftUI

struct PPEntry: TimelineEntry {
    let date: Date
    let title: String
    let hourBadge: String
    let stageIndex: Int
}

struct PPTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> PPEntry {
        PPEntry(date: Date(), title: "Your Hourly Task", hourBadge: DateFormatter.hourBadge.string(from: Date()), stageIndex: 1)
    }
    func getSnapshot(in context: Context, completion: @escaping (PPEntry) -> ()) {
        completion(placeholder(in: context))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<PPEntry>) -> ()) {
        let now = Date()
        let grace = UserDefaults.standard.integer(forKey: "pp_graceMinutes").clamped(to: 0...60)
        let next = nextBoundaryConsideringGrace(now: now, graceMinutes: grace)

        let title = UserDefaults.standard.string(forKey: "pp_currentTaskTitle") ?? "Your Hourly Task"
        let stage = max(1, UserDefaults.standard.integer(forKey: "pp_stageIndex"))
        let entry = PPEntry(date: now, title: title, hourBadge: DateFormatter.hourBadge.string(from: now), stageIndex: stage)

        completion(Timeline(entries: [entry], policy: .after(next)))
    }
}

fileprivate func nextBoundaryConsideringGrace(now: Date, graceMinutes: Int) -> Date {
    let cal = Calendar.current
    let nextHour = cal.nextDate(after: now, matching: DateComponents(minute: 0, second: 5), matchingPolicy: .nextTime) ?? now.addingTimeInterval(3600)
    return nextHour.addingTimeInterval(TimeInterval(graceMinutes * 60))
}

fileprivate extension Int { func clamped(to r: ClosedRange<Int>) -> Int { max(r.lowerBound, min(r.upperBound, self)) } }
fileprivate extension DateFormatter {
    static let hourBadge: DateFormatter = { let f = DateFormatter(); f.dateFormat = "HH:00"; return f }()
}
