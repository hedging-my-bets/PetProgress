import WidgetKit
import SwiftUI

struct SmallView: View {
    let e: PPEntry
    var body: some View {
        VStack(spacing: 4) {
            Image("pet_neutral_stage_\(max(1,e.stageIndex))").resizable().scaledToFit()
            Text(e.hourBadge).font(.caption2).opacity(0.8)
        }
        .widgetURL(URL(string: "myapp://complete")) // whole small = ✓
    }
}

struct MediumView: View {
    let e: PPEntry
    var body: some View {
        HStack(spacing: 8) {
            Image("pet_neutral_stage_\(max(1,e.stageIndex))").resizable().scaledToFit()
            VStack(alignment: .leading, spacing: 4) {
                Text(e.title).font(.footnote).lineLimit(2)
                Text(e.hourBadge).font(.caption2).opacity(0.8)
                WidgetActionsRow() // ‹ ✓ 🕒 ✕ › deep links
            }
        }.padding(6)
    }
}

@main
struct PetProgressWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "PetProgressWidget", provider: PPTimelineProvider()) { entry in
            if #available(iOSApplicationExtension 16.0, *) {
                switch entry.family {
                case .systemSmall: SmallView(e: entry)
                default: MediumView(e: entry)
                }
            } else { MediumView(e: entry) }
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("PetProgress")
        .description("Complete or manage your hourly habit.")
    }
}
