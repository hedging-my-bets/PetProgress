import Foundation
enum XP {
    static let gainPerTask = 25
    static let thresholds = Array(stride(from: 0, through: 3000, by: 100))
    static func penaltyMultiplier(level: Int) -> Double {
        let L = max(1, min(30, level)); return 1.0 + (5.0 - 1.0) * Double(L - 1) / 29.0
    }
}