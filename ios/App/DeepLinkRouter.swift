import UIKit
enum DeepLinkAction: String { case complete, miss, skip, prev, next }
final class DeepLinkRouter {
    static let scheme = "myapp"
    static func handle(url: URL) -> Bool {
        guard url.scheme == scheme, let action = DeepLinkAction(rawValue: url.host ?? "") else { return false }
        switch action {
        case .complete: StateStore.shared.mutate { $0.completeCurrent() }
        case .miss:     StateStore.shared.mutate { $0.missCurrent(applyPenalty: true) }
        case .skip:     StateStore.shared.mutate { $0.skipCurrent() }
        case .prev:     StateStore.shared.mutate { $0.prev() }
        case .next:     StateStore.shared.mutate { $0.next() }
        }
        WidgetBridge.requestReload(); return true
    }
}