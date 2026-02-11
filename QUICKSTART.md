# Grounded - Quick Start Guide

## Testing the App (Windows)

Since you're on an Asus device running Windows, I've created a web-based demo you can test right now!

### Option 1: Double-Click Launch (Easiest)
1. Navigate to the `demo` folder
2. Double-click `launch.bat`
3. The app will open in your default browser

### Option 2: Manual Launch
1. Navigate to the `demo` folder
2. Double-click `index.html`
3. The app will open in your browser

### Option 3: Local Server (Recommended for best experience)
1. Open Command Prompt in the `demo` folder
2. If you have Python installed, run:
   ```
   python -m http.server 8000
   ```
3. Open your browser and go to: `http://localhost:8000`

## What You Can Test

### ✅ Complete Onboarding Flow
- Welcome screen with app introduction
- Learn about DPDR
- Understand how grounding works
- Personalize with your name and goals
- Complete setup

### ✅ Grounding Exercise (5-4-3-2-1 Technique)
1. Click "I need to ground" button on home screen
2. Rate your mood before starting (1-5)
3. Go through each sense step:
   - 5 things you can see
   - 4 things you can touch
   - 3 things you can hear
   - 2 things you can smell
   - 1 thing you can taste
4. Rate your mood after completing
5. See your mood improvement!

### ✅ Habit Tracking
1. Go to Habits tab
2. Click "Add Your First Habit"
3. Choose a name and icon
4. Or use a template (Drink Water, Exercise, etc.)
5. Mark habits complete each day
6. Build streaks!

### ✅ Educational Resources
1. Go to Resources tab
2. Browse articles about DPDR
3. Click to read full content
4. Learn about coping strategies

### ✅ Insights Dashboard
1. Go to Insights tab
2. View total grounding sessions
3. See average mood improvement
4. Track habit completion rates

### ✅ Profile & Settings
1. Go to Profile tab
2. View your personalization
3. Access settings
4. Use "Reset Demo" to start over

## Data Persistence

All your data (habits, sessions, preferences) is saved in your browser's local storage. It will persist even if you close and reopen the browser!

## Next Steps for iOS Development

To build the actual iOS app:

1. **Install Xcode** (Mac required)
   - Download from Mac App Store
   - Requires macOS

2. **Create Xcode Project**
   - Open Xcode
   - Create new iOS App project
   - Choose SwiftUI interface
   - Set minimum iOS version to 16.0

3. **Add the Swift Files**
   - Copy all files from `Grounded/` folder
   - Add to Xcode project

4. **Configure Assets**
   - Add color assets from `Grounded/Assets.xcassets/`

5. **Test on Simulator or Device**
   - Build and run (⌘R)

## iOS App vs Web Demo

The web demo includes all core functionality, but the iOS app will have:
- Native iOS animations and haptics
- Better performance
- CloudKit sync across devices
- Push notifications for reminders
- Apple Watch companion app (future)
- Superwall paywall for premium features
- HealthKit integration

## Need Help?

If you encounter any issues with the demo:
1. Try a different browser (Chrome recommended)
2. Clear browser cache and reload
3. Check browser console for errors (F12)
4. Use "Reset Demo" button to start fresh

Enjoy testing Grounded! 🍃
