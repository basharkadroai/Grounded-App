# Grounded - Project Overview

## What Has Been Built

A complete MVP (Phase 1) implementation of the Grounded mental health app for managing DPDR (Depersonalization-Derealization Disorder).

## Project Structure

```
Grounded/
├── demo/                          # Web-based demo (test in browser)
│   ├── index.html                 # Main HTML file
│   ├── styles.css                 # All styling
│   ├── app.js                     # Full app logic
│   ├── launch.bat                 # Windows launcher
│   └── README.md                  # Demo instructions
│
├── Grounded/                      # iOS Swift/SwiftUI source code
│   ├── Models/                    # Data models
│   │   ├── User.swift
│   │   ├── GroundingSession.swift
│   │   ├── Habit.swift
│   │   └── Resource.swift
│   │
│   ├── Views/                     # UI screens
│   │   ├── OnboardingView.swift
│   │   ├── MainTabView.swift
│   │   ├── HomeView.swift
│   │   ├── GroundingExerciseSelectionView.swift
│   │   ├── FiveFourThreeTwoOneView.swift
│   │   ├── HabitTrackerView.swift
│   │   ├── ResourceLibraryView.swift
│   │   ├── InsightsView.swift
│   │   └── ProfileView.swift
│   │
│   ├── Assets.xcassets/           # Color assets
│   │   └── Colors/
│   │       ├── AccentColor.colorset/
│   │       ├── BackgroundColor.colorset/
│   │       └── PrimaryColor.colorset/
│   │
│   ├── GroundedApp.swift          # App entry point
│   ├── ContentView.swift          # Root view
│   ├── Info.plist                 # App configuration
│   └── README.md                  # iOS project info
│
├── grounded_prd.md                # Original Product Requirements Document
├── QUICKSTART.md                  # How to test the demo
└── PROJECT_OVERVIEW.md            # This file
```

## Features Implemented

### ✅ Onboarding (5 Screens)
- Welcome screen with branding
- DPDR education
- How grounding works explanation
- Personalization (name, goals)
- Completion screen

### ✅ Home Screen
- Personalized greeting
- Prominent "I need to ground" button
- Daily and weekly session statistics
- Featured resource card
- Clean, calming design

### ✅ Grounding Exercise (5-4-3-2-1 Technique)
- Pre-exercise mood rating (1-5 scale)
- Step-by-step guided exercise through 5 senses
- Progress indicators
- Post-exercise mood rating
- Mood improvement calculation
- Session saved to history

### ✅ Habit Tracker
- Add custom habits with icons
- Pre-built templates (Water, Exercise, Meditate, etc.)
- Daily completion tracking
- Streak calculation
- Visual completion indicators
- Empty state for first-time users

### ✅ Resource Library
- 6 educational articles about DPDR
- Categories: Understanding DPDR, Coping Strategies, Treatment, Community, Crisis
- Search functionality (UI ready)
- Category filtering (UI ready)
- Full article reading view
- Read time indicators

### ✅ Insights Dashboard
- Total grounding sessions count
- Average mood improvement calculation
- Habit completion rate (last 7 days)
- Visual statistics
- Empty states for new users

### ✅ Profile & Settings
- User profile display
- Settings menu (UI ready)
- About section
- Support links
- Demo reset functionality

## Technical Implementation

### iOS App (Swift/SwiftUI)
- **Architecture**: MVVM pattern
- **Data Persistence**: SwiftData (iOS 17+)
- **UI Framework**: SwiftUI
- **Minimum iOS**: 16.0
- **Design System**: SF Symbols, custom color palette

### Web Demo (HTML/CSS/JS)
- **Storage**: localStorage API
- **Responsive**: Mobile-first design
- **Animations**: CSS transitions
- **State Management**: Vanilla JavaScript

## Design System

### Colors
- **Primary**: #8BA888 (Soft sage green) - calming, grounding
- **Accent**: #E8A598 (Soft coral) - CTAs and highlights
- **Background**: #FAFAF8 (Light neutral)
- **Card Background**: #F5F5F0 (Warm off-white)
- **Text Primary**: #2C2C2C (Dark charcoal)
- **Text Secondary**: #666666 (Gray)

### Typography
- **System Font**: SF Pro (iOS) / System fonts (Web)
- **Hierarchy**: Clear size differentiation
- **Line Spacing**: Generous for readability

### Visual Style
- Minimalist, uncluttered interfaces
- Ample white space
- Soft shadows and rounded corners (12-16pt radius)
- Subtle animations (0.3s ease-in-out)
- Gentle haptic feedback (iOS)

## How to Test

### Web Demo (Immediate Testing)
1. Navigate to `demo/` folder
2. Double-click `launch.bat` (Windows)
3. Or open `index.html` in any browser
4. Complete onboarding and test all features

### iOS App (Requires Mac + Xcode)
1. Install Xcode 15+ on macOS
2. Create new iOS App project
3. Copy Swift files from `Grounded/` folder
4. Add color assets
5. Build and run on simulator or device

## What's Next (Phase 2)

### Additional Features
- [ ] Body Scan grounding exercise
- [ ] Breath Work exercise with visual guide
- [ ] Sensory Grounding exercise
- [ ] CloudKit sync for cross-device support
- [ ] Push notifications for habit reminders
- [ ] Superwall paywall integration
- [ ] Advanced insights with charts
- [ ] Data export (CSV/PDF)
- [ ] Apple Watch companion app

### Technical Improvements
- [ ] Unit tests
- [ ] UI tests
- [ ] Performance optimization
- [ ] Accessibility audit
- [ ] Localization support

## Development Timeline

- **Phase 1 (MVP)**: ✅ Complete (4-6 weeks estimated)
- **Phase 2 (Enhancement)**: 3-4 weeks
- **Phase 3 (Polish & Launch)**: 2-3 weeks
- **Phase 4 (Post-Launch)**: Ongoing

## Success Metrics

### User Engagement
- Daily Active Users (DAU)
- Grounding exercise completion rate
- Habit tracker usage rate
- Resource article read rate

### Health Outcomes
- Average mood improvement per session
- User-reported DPDR episode frequency
- Habit streak lengths

### Business Metrics
- Free to Premium conversion rate
- User retention (Day 1, 7, 30)
- Average Revenue Per User (ARPU)

## Resources

- **PRD**: See `grounded_prd.md` for complete product requirements
- **Quick Start**: See `QUICKSTART.md` for testing instructions
- **iOS README**: See `Grounded/README.md` for iOS-specific info
- **Demo README**: See `demo/README.md` for web demo details

## Support

For questions or issues:
1. Check the QUICKSTART.md guide
2. Review the PRD for feature specifications
3. Test the web demo first before iOS development
4. Ensure all prerequisites are met for iOS development

---

**Status**: MVP Complete ✅  
**Last Updated**: February 11, 2026  
**Version**: 1.0.0
