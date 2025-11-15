package com.petprogress.shared
enum class PetEmotion { HAPPY, NEUTRAL, SAD }
data class Pet(var xp: Int, var stageIndex: Int, var emotion: PetEmotion)
object EmotionCenter {
    fun happy(p: Pet) { p.emotion = PetEmotion.HAPPY }
    fun sad(p: Pet) { p.emotion = PetEmotion.SAD }
    fun neutral(p: Pet) { p.emotion = PetEmotion.NEUTRAL }
}