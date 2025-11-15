import WidgetKit, SwiftUI
struct WidgetActionsRow: View {
    var body: some View {
        HStack(spacing: 12) {
            Link(destination: URL(string: "myapp://prev")!) { Text("‹") }
            Link(destination: URL(string: "myapp://complete")!) { Text("✓") }
            Link(destination: URL(string: "myapp://skip")!) { Text("🕒") }
            Link(destination: URL(string: "myapp://miss")!) { Text("✕") }
            Link(destination: URL(string: "myapp://next")!) { Text("›") }
        }.font(.title2).monospaced()
    }
}