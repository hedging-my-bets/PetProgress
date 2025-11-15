import Foundation
enum PetEmotion: String, Codable { case happy, neutral, sad }
struct Pet: Codable { var xp: Int; var stageIndex: Int; var emotion: PetEmotion }
enum EmotionCenter {
    static func setHappy(_ p: inout Pet) { p.emotion = .happy }
    static func setSad(_ p: inout Pet) { p.emotion = .sad }
    static func setNeutral(_ p: inout Pet) { p.emotion = .neutral }
}