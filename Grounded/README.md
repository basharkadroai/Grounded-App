# Grounded - DPDR Support App

A mental health iOS application designed to help individuals manage Depersonalization-Derealization Disorder (DPDR) through evidence-based grounding techniques, habit tracking, and educational resources.

## Requirements

- Xcode 15.0+
- iOS 16.0+
- Swift 5.9+

## Features (MVP - Phase 1)

### Core Features
- **Onboarding Flow**: 5-screen introduction to the app and DPDR
- **Grounding Exercises**: 5-4-3-2-1 technique with mood tracking
- **Habit Tracker**: Track up to 3 daily habits with streak counting
- **Resource Library**: 6+ educational articles about DPDR
- **Insights Dashboard**: Basic statistics and mood improvement tracking

### Architecture
- SwiftUI for all UI components
- SwiftData for local data persistence
- MVVM architecture pattern

## Project Structure

```
Grounded/
├── Models/
│   ├── User.swift
│   ├── GroundingSession.swift
│   ├── Habit.swift
│   └── Resource.swift
├── Views/
│   ├── OnboardingView.swift
│   ├── MainTabView.swift
│   ├── HomeView.swift
│   ├── GroundingExerciseSelectionView.swift
│   ├── FiveFourThreeTwoOneView.swift
│   ├── HabitTrackerView.swift
│   ├── ResourceLibraryView.swift
│   ├── InsightsView.swift
│   └── ProfileView.swift
├── Assets.xcassets/
│   └── Colors/
├── GroundedApp.swift
└── ContentView.swift
```

## Getting Started

1. Open the project in Xcode 15+
2. Select your target device or simulator (iOS 16.0+)
3. Build and run (⌘R)

## Color Palette

- **Primary**: Soft sage green (#8BA888) - calming, grounding
- **Accent**: Soft coral (#E8A598) - for CTAs and highlights
- **Background**: Light neutral (#FAFAF8)

## Next Steps (Phase 2)

- Additional grounding exercises (Body Scan, Breath Work, Sensory Grounding)
- CloudKit sync for cross-device support
- Superwall integration for freemium model
- Push notifications for habit reminders
- Advanced insights with correlations

## License

Proprietary - All rights reserved

## Support

For questions or support, contact the development team.
