package com.petprogress.shared
object XP {
    const val GAIN_PER_TASK = 25
    val THRESHOLDS = (0..30).map { it * 100 }
    fun penaltyMultiplier(level: Int): Double {
        val L = level.coerceIn(1,30); return 1.0 + (5.0 - 1.0) * (L - 1) / 29.0
    }
}