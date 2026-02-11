# 🍃 Grounded

A mental health companion app for managing Depersonalization-Derealization Disorder (DPDR).

## Features

- **Grounding Exercises**: 4 evidence-based techniques (5-4-3-2-1, Body Scan, Breath Work, Sensory Grounding)
- **Habit Tracking**: Build healthy routines with streak tracking
- **Resource Library**: Curated educational content about DPDR
- **Insights Dashboard**: Track your progress and mood improvements
- **Beautiful Design**: Calming interface with thoughtful UX

## Quick Start

### For iOS Development (Xcode)

```bash
git clone https://github.com/basharkadroai/Grounded-App.git
cd Grounded-App/Grounded
open Grounded.xcodeproj
```

Press ⌘ + R to run in the iOS Simulator.

**See [CEO_DEMO_GUIDE.md](CEO_DEMO_GUIDE.md) for detailed setup instructions.**

### Web Demo

Try the interactive web demo: [Launch Demo](https://basharkadroai.github.io/Grounded-App/)

Or run locally:
```bash
cd demo
open index.html
```

## Project Structure

```
Grounded-App/
├── Grounded/              # iOS App (SwiftUI)
│   ├── Views/            # All SwiftUI views
│   ├── Models/           # Data models (SwiftData)
│   ├── Services/         # Business logic
│   └── Assets.xcassets/  # Colors, images
├── demo/                 # Web demo (HTML/CSS/JS)
├── Marketing/            # Press kit & materials
└── AppStore/             # App Store listing content
```

## Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Tech Stack

- **SwiftUI** - Modern declarative UI
- **SwiftData** - Data persistence
- **CloudKit** - Cloud sync (optional)
- **Superwall** - Paywall management (optional)

## Documentation

- [CEO Demo Guide](CEO_DEMO_GUIDE.md) - Complete demo walkthrough
- [Setup Guide](Grounded/SETUP_GUIDE.md) - Development setup
- [PRD](grounded_prd.md) - Product requirements

## License

Proprietary - All rights reserved

## Contact

For questions or support, please open an issue.
