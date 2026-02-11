# Grounded iOS App - Complete Setup Guide

## Prerequisites

- macOS 13.0 or later
- Xcode 15.0 or later
- iOS 16.0+ device or simulator
- Apple Developer Account (for device testing)

## Step 1: Create Xcode Project

1. Open Xcode
2. Select "Create a new Xcode project"
3. Choose "iOS" → "App"
4. Configure project:
   - Product Name: `Grounded`
   - Team: Select your team
   - Organization Identifier: `com.yourcompany`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Storage: `SwiftData`
   - Include Tests: ✓ (optional)

## Step 2: Add Source Files

1. In Xcode, right-click on the `Grounded` folder
2. Select "Add Files to Grounded..."
3. Add all files from this directory:
   - `Models/` folder
   - `Views/` folder
   - `Services/` folder
   - `GroundedApp.swift`
   - `ContentView.swift`

## Step 3: Configure Assets

1. Open `Assets.xcassets` in Xcode
2. Add the color sets from `Assets.xcassets/Colors/`:
   - AccentColor
   - BackgroundColor
   - PrimaryColor

3. For each color:
   - Right-click in Assets → New Color Set
   - Name it (e.g., "AccentColor")
   - Set the color values from the JSON files

## Step 4: Configure Info.plist

Add these keys to your Info.plist:

```xml
<key>CFBundleDisplayName</key>
<string>Grounded</string>

<key>UILaunchScreen</key>
<dict>
    <key>UIColorName</key>
    <string>BackgroundColor</string>
</dict>

<key>NSUserTrackingUsageDescription</key>
<string>We use tracking to provide personalized mental health insights.</string>

<key>NSHealthShareUsageDescription</key>
<string>Grounded can integrate with Health data to provide better insights.</string>
```

## Step 5: Add Superwall SDK (Optional)

### Using Swift Package Manager:

1. In Xcode, go to File → Add Package Dependencies
2. Enter URL: `https://github.com/superwall-me/Superwall-iOS`
3. Select version: 3.0.0 or later
4. Click "Add Package"

### Configure Superwall:

1. Sign up at [superwall.com](https://superwall.com)
2. Create a new app and get your API key
3. In `Services/SuperwallManager.swift`:
   - Uncomment `import SuperwallKit`
   - Replace `"YOUR_API_KEY_HERE"` with your actual API key
   - Uncomment Superwall integration code

## Step 6: Build and Run

1. Select a simulator or connected device
2. Press ⌘R or click the Play button
3. The app should build and launch

## Step 7: Test Core Features

### Onboarding
- Complete the 5-screen onboarding flow
- Enter your name and select goals

### Grounding Exercises
- Tap "I need to ground" on home screen
- Try all 4 exercises:
  - 5-4-3-2-1 Technique
  - Body Scan
  - Breath Work
  - Sensory Grounding

### Habits
- Add a new habit
- Mark it complete
- Check streak counter

### Resources
- Browse educational articles
- Read full content

### Insights
- View session statistics
- Check mood improvement

## Troubleshooting

### Build Errors

**"Cannot find type 'SuperwallKit'"**
- Make sure Superwall SDK is added via SPM
- Or comment out Superwall-related code in `SuperwallManager.swift`

**"Cannot find 'Color' in scope"**
- Make sure all color assets are properly added
- Check color names match exactly

**SwiftData errors**
- Ensure iOS deployment target is 16.0+
- Clean build folder (⌘⇧K)

### Runtime Issues

**App crashes on launch**
- Check SwiftData model container is properly configured
- Verify all @Model classes are included in modelContainer

**Colors not showing**
- Verify color assets are in the main bundle
- Check color names in code match asset names

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
│   ├── BodyScanView.swift
│   ├── BreathWorkView.swift
│   ├── SensoryGroundingView.swift
│   ├── HabitTrackerView.swift
│   ├── ResourceLibraryView.swift
│   ├── InsightsView.swift
│   ├── ProfileView.swift
│   └── PaywallView.swift
├── Services/
│   └── SuperwallManager.swift
├── Assets.xcassets/
│   └── Colors/
├── GroundedApp.swift
├── ContentView.swift
└── Info.plist
```

## Next Steps

### Phase 2 Features
- [ ] CloudKit sync implementation
- [ ] Push notifications for habit reminders
- [ ] Advanced insights with Charts framework
- [ ] Audio guides for exercises
- [ ] Data export (CSV/PDF)

### Testing
- [ ] Unit tests for models
- [ ] UI tests for critical flows
- [ ] TestFlight beta testing

### App Store Preparation
- [ ] App Store screenshots
- [ ] App Store description
- [ ] Privacy policy
- [ ] Terms of service
- [ ] App Store review submission

## Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [SwiftData Documentation](https://developer.apple.com/documentation/swiftdata)
- [Superwall Documentation](https://docs.superwall.com)
- [App Store Guidelines](https://developer.apple.com/app-store/review/guidelines/)

## Support

For issues or questions:
1. Check this setup guide
2. Review the PRD (`grounded_prd.md`)
3. Test the web demo first (`demo/`)
4. Check Xcode console for error messages

---

**Version**: 1.0.0  
**Last Updated**: February 11, 2026  
**Minimum iOS**: 16.0
