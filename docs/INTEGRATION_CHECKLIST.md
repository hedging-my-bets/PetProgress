# PetProgress — 100% Fixes Pack (2025-11-15)
1) Replace `config/stages.json` & add `config/deeplinks.json`.
2) iOS: add XP/Emotion/DeepLinkRouter/NightNudge/WidgetActionsRow; add URL Type (myapp) in Info.plist; route URLs to router; include actions row in Medium widget.
3) Android: add XP.kt/Emotion.kt/DeepLinkRouter.kt/NightNudge.kt; add scheme intent-filter; handle myapp:// in MainActivity.onNewIntent; call schedule8pm().
4) Emotions: ✓→HAPPY (auto-neutral ~15s), ✕→SAD, 🕒→NEUTRAL.
5) QA: widgets act; 8pm nudge; rollover (midnight+grace) applies 1..5× penalty; thresholds honored.
