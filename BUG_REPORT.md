# PoseMe — Bug Report

**Date:** 2026-10-01
**App version:** 1.0.0+1
**Platform:** Flutter (Android target, tested on HONOR LLD-AL10)
**Audit type:** Full interactive-element functionality audit

---

## Summary

A complete audit of every interactive element in the PoseMe UI identified **6 broken or non-functional controls**. Five were wired to empty callbacks (silent no-ops), and one had a state-management bug where the UI never refreshed after a state change. All six have been fixed. No UI, theme, or architectural changes were made.

---

## Bugs Found & Fixed

### BUG-01 — Home: Settings icon does nothing

| Field | Detail |
|---|---|
| **Severity** | Medium |
| **Screen** | Home (`lib/screens/home_screen.dart`) |
| **Element** | Settings icon button (top-right of top bar) |
| **Symptom** | Tapping the settings icon produces no response — no navigation, no feedback. |
| **Root cause** | Callback was an empty closure: `onSettings: () {}`. |
| **Fix** | Now navigates to `ProfileScreen` via `PosePageRoute`. |
| **Status** | ✅ Fixed |

---

### BUG-02 — Live Camera: Flip camera button does nothing

| Field | Detail |
|---|---|
| **Severity** | Medium |
| **Screen** | Live Camera (`lib/screens/live_camera_screen.dart`) |
| **Element** | Camera flip icon (top-right, next to flash) |
| **Symptom** | Tapping the flip button silently does nothing. |
| **Root cause** | Empty callback — camera switching is not implemented (no camera plugin in project). |
| **Fix** | Now shows a `SnackBar`: "Camera switching is coming soon." |
| **Status** | ✅ Fixed (communicates status honestly) |

---

### BUG-03 — Pose Result: Save Photo button does nothing

| Field | Detail |
|---|---|
| **Severity** | Medium |
| **Screen** | Pose Match Result (`lib/screens/pose_match_result_screen.dart`) |
| **Element** | "Save Photo" primary button |
| **Symptom** | Tapping Save Photo silently does nothing. |
| **Root cause** | Empty callback — photo saving not implemented. |
| **Fix** | Now shows a `SnackBar`: "Saving photos is coming soon." |
| **Status** | ✅ Fixed (communicates status honestly) |

---

### BUG-04 — Pose Discovery: Pose cards do nothing when tapped

| Field | Detail |
|---|---|
| **Severity** | Medium |
| **Screen** | Pose Discovery (`lib/screens/pose_discovery_screen.dart`) |
| **Element** | Pose cards (grid items) |
| **Symptom** | Tapping a pose card silently does nothing. |
| **Root cause** | Empty callback — pose detail view not implemented. |
| **Fix** | Now shows a `SnackBar`: "Pose details are coming soon." |
| **Status** | ✅ Fixed (communicates status honestly) |

---

### BUG-05 — Profile: Menu rows do nothing when tapped

| Field | Detail |
|---|---|
| **Severity** | Medium |
| **Screen** | Profile (`lib/screens/profile_screen.dart`) |
| **Element** | History, Settings, Help & Support rows |
| **Symptom** | Tapping any menu row silently does nothing. |
| **Root cause** | Empty callbacks — menu actions not implemented. |
| **Fix** | Each row now shows a `SnackBar`: "{label} is coming soon." |
| **Status** | ✅ Fixed (communicates status honestly) |

---

### BUG-06 — Pose Discovery: Favorite heart icon never updates visually

| Field | Detail |
|---|---|
| **Severity** | High (functional state bug) |
| **Screen** | Pose Discovery (`lib/screens/pose_discovery_screen.dart`) |
| **Element** | Heart/favorite button on each pose card |
| **Symptom** | Tapping the heart toggles the underlying state, but the icon **never changes appearance** — it stays gray. The Favorites screen also does not reflect the change. |
| **Root cause** | `_FavoriteButton` called `FavoritesStore.instance.toggle(id)`, which fires `notifyListeners()`, but **no widget was listening**. The button read `widget.active` from its parent, and the parent (`_PoseCard`) never rebuilt on store changes. |
| **Fix** | `_FavoriteButton` now registers a listener on `FavoritesStore` in `initState`, removes it in `dispose`, and reads `isFavorite()` directly from the store in `build`. The heart icon now updates instantly. |
| **Status** | ✅ Fixed |

---

## Elements Verified as Working

| Screen | Element | Result |
|---|---|---|
| Home | Find My Pose | ✅ Navigates to Pose Setup |
| Home | Explore Poses | ✅ Navigates to Pose Discovery |
| Home | Quick Start cards (Upload / Take Photo / AI Ideas) | ✅ Navigate correctly |
| Home | Settings icon | ✅ Fixed — navigates to Profile |
| Bottom Nav | Home / Poses / Camera / Favorites / Profile | ✅ All switch or push correctly |
| Pose Setup | Upload a Pose | ✅ Opens gallery, returns image |
| Pose Setup | Take a Photo | ✅ Opens camera, returns image |
| Pose Setup | Back | ✅ Pops to previous screen |
| Reference Pose | Analyze Pose | ✅ Navigates to Pose Analysis |
| Reference Pose | Choose Another | ✅ Pops to Pose Setup |
| Reference Pose | Back | ✅ Pops correctly |
| Pose Analysis | ML Kit pose detection | ✅ Real detection runs |
| Pose Analysis | Try It Live | ✅ Navigates to Live Camera |
| Pose Analysis | Back / Go Back | ✅ Pop correctly |
| Live Camera | Back | ✅ Pops correctly |
| Live Camera | Flash | ✅ Visual toggle works |
| Live Camera | Flip | ✅ Fixed — shows status message |
| Live Camera | Capture | ✅ Navigates to Result screen |
| Pose Result | Close | ✅ Pops correctly |
| Pose Result | Save Photo | ✅ Fixed — shows status message |
| Pose Result | Try Again | ✅ Pops correctly |
| Pose Result | Try Another Pose | ✅ Navigates to Discovery |
| Pose Discovery | Category chips | ✅ Filter grid correctly |
| Pose Discovery | Pose cards | ✅ Fixed — shows status message |
| Pose Discovery | Favorite hearts | ✅ Fixed — update visually |
| Favorites | List | ✅ Updates live via ListenableBuilder |
| Profile | Menu rows | ✅ Fixed — show status messages |

---

## Known Placeholders (Underlying Functionality Not Implemented)

These are **not bugs** — they are features whose underlying functionality does not exist yet. The UI now communicates their status honestly instead of silently doing nothing.

| Feature | Current behavior |
|---|---|
| Live camera preview | No camera plugin in project; screen is a UI placeholder |
| Pose match scoring | Result screen shows "Score coming soon" — no fake scores |
| Photo saving | Shows "Saving photos is coming soon." |
| Pose detail view | Shows "Pose details are coming soon." |
| Profile menu actions | Shows "{label} is coming soon." |
| Camera switching / flash hardware | Shows "Camera switching is coming soon." |

---

## Verification

| Check | Result |
|---|---|
| `flutter analyze` | ✅ No issues found |
| `flutter test` | ✅ All tests passed |
| `flutter build apk --debug` | ✅ Built successfully |

---

## Files Modified

| File | Change |
|---|---|
| `lib/screens/home_screen.dart` | Settings icon → navigate to Profile |
| `lib/screens/live_camera_screen.dart` | Flip button → status snackbar |
| `lib/screens/pose_match_result_screen.dart` | Save Photo → status snackbar |
| `lib/screens/pose_discovery_screen.dart` | Pose card → status snackbar; favorite button → store listener fix |
| `lib/screens/profile_screen.dart` | Menu rows → status snackbars |
