# Grounded - DPDR Mental Health App

<div align="center">

🍃 **Your companion for managing Depersonalization-Derealization Disorder**

[![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)]()

</div>

---

## 📖 Overview

Grounded is a comprehensive iOS mental health application designed to help individuals manage Depersonalization-Derealization Disorder (DPDR) through evidence-based grounding techniques, habit tracking, and educational resources.

### What is DPDR?

Depersonalization-Derealization Disorder is a dissociative disorder characterized by:
- Feeling disconnected from oneself (depersonalization)
- Perceiving the world as foggy or dreamlike (derealization)
- Persistent episodes that cause significant distress
- Intact reality testing (awareness that perceptions are distorted)

## ✨ Features

### 🧘 Grounding Exercises (4 Complete Techniques)
- **5-4-3-2-1 Technique**: Engage all five senses to anchor in the present
- **Body Scan**: Progressive body awareness meditation
- **Breath Work**: 4-7-8 breathing technique with visual guide
- **Sensory Grounding**: Deep focus on individual senses

### ✅ Habit Tracking
- Create custom habits with icons
- Pre-built templates (Water, Exercise, Meditation, etc.)
- Daily completion tracking
- Streak counters and motivation
- Unlimited habits (Premium)

### 📚 Educational Resources
- 6+ comprehensive articles about DPDR
- Categories: Understanding, Coping, Treatment, Community, Crisis
- Evidence-based information
- Easy-to-read format

### 📊 Insights Dashboard
- Track grounding session frequency
- Monitor mood improvement over time
- Habit completion rates
- Visual statistics and trends

### 👤 Profile & Settings
- Personalized experience
- Subscription management
- Privacy controls
- Data export options

### 💎 Freemium Model
**Free Tier:**
- 3 grounding exercises per day
- 3 habit trackers
- Basic educational resources
- 7-day progress tracking

**Premium ($4.99/month or $39.99/year):**
- Unlimited grounding exercises
- Unlimited habit trackers
- Full resource library
- Advanced insights
- CloudKit sync
- Data export
- Priority support

## 🚀 Quick Start

### ⚡ FASTEST: Get Your App Online Now (5 Minutes)

**Live demo at: `https://yourusername.github.io/grounded`**

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/yourusername/grounded.git
git push -u origin main

# Then: Settings > Pages > Source: "GitHub Actions"
# Wait 2 minutes, visit: https://yourusername.github.io/grounded
```

📖 **Complete Guide:** [`START_HERE.md`](START_HERE.md) | [`GITHUB_SOLUTION.md`](GITHUB_SOLUTION.md)

---

## 🚀 Quick Start

### 🎨 Option 1: Preview Real iOS Design (2 Minutes - FREE!)

**See actual iOS styling on Windows - No Mac needed!**

1. Go to: **https://www.iswift.dev**
2. Open: `Preview/HomeScreenPreview.swift`
3. Copy all code (Ctrl+A, Ctrl+C)
4. Paste into iSwift.dev
5. See REAL iOS design with native fonts, shadows, and animations!

**Preview more screens:**
- Any file from `Grounded/Views/` folder
- Switch between iPhone/iPad devices
- Toggle dark mode
- Interactive buttons

📖 **Full Guide:** [`Preview/COMPLETE_PREVIEW_GUIDE.md`](Preview/COMPLETE_PREVIEW_GUIDE.md)  
⚡ **Quick Start:** [`Preview/QUICK_START.md`](Preview/QUICK_START.md)

---

### 📱 Option 2: Full iOS App on Windows (FREE - Requires Mac to Build)

**Test complete app with full navigation using Appetize.io!**

**What you get:**
- ✅ Real iOS simulator in browser
- ✅ Full app navigation
- ✅ All features working
- ✅ 100 minutes FREE per month
- ✅ NO credit card required

**⚠️ Important:** Appetize requires a compiled iOS Simulator build (not source code).

**Steps:**
1. Build `.app` file on Mac (11 minutes) OR use GitHub Actions (free!)
2. Sign up at Appetize.io (FREE)
3. Upload compiled app
4. Test on Windows browser!

📖 **Complete Guide:** [`APPETIZE_COMPLETE_GUIDE.md`](APPETIZE_COMPLETE_GUIDE.md)  
⚡ **Build Guide:** [`BUILD_FOR_APPETIZE.md`](BUILD_FOR_APPETIZE.md)  
🔧 **Upload Issues?** [`FIX_APPETIZE_UPLOAD.md`](FIX_APPETIZE_UPLOAD.md) | [`QUICK_FIX_GUIDE.md`](QUICK_FIX_GUIDE.md)

---

### 🌐 Option 3: Web Demo (Immediate - Full Functionality)

1. Navigate to the `demo/` folder
2. Double-click `launch.bat` (Windows) or open `index.html` in any browser
3. Complete onboarding and test all features

**Web Demo Features:**
- ✅ All 4 grounding exercises
- ✅ Full habit tracking
- ✅ Resource library
- ✅ Insights dashboard
- ✅ Data persistence (localStorage)
- ⚠️ Basic HTML/CSS styling (not native iOS look)

**Note:** Web demo shows functionality, but doesn't look like real iOS. Use iSwift.dev (above) to see actual iOS design!

---

### Build the iOS App (Requires Mac + Xcode)

1. **Prerequisites:**
   - macOS 13.0+
   - Xcode 15.0+
   - iOS 16.0+ device or simulator

2. **Setup:**
   ```bash
   # Open Xcode and create new iOS App project
   # Name: Grounded
   # Interface: SwiftUI
   # Storage: SwiftData
   ```

3. **Add Files:**
   - Copy all files from `Grounded/` folder to your Xcode project
   - Add color assets from `Grounded/Assets.xcassets/`

4. **Build & Run:**
   ```bash
   # In Xcode, press ⌘R or click Play button
   ```

See [`Grounded/SETUP_GUIDE.md`](Grounded/SETUP_GUIDE.md) for detailed instructions.

## 📁 Project Structure

```
Grounded/
├── demo/                          # Web demo (test immediately!)
│   ├── index.html
│   ├── styles.css
│   ├── app.js
│   └── launch.bat
│
├── Grounded/                      # iOS Swift/SwiftUI app
│   ├── Models/                    # Data models (SwiftData)
│   │   ├── User.swift
│   │   ├── GroundingSession.swift
│   │   ├── Habit.swift
│   │   └── Resource.swift
│   │
│   ├── Views/                     # SwiftUI views
│   │   ├── OnboardingView.swift
│   │   ├── HomeView.swift
│   │   ├── FiveFourThreeTwoOneView.swift
│   │   ├── BodyScanView.swift
│   │   ├── BreathWorkView.swift
│   │   ├── SensoryGroundingView.swift
│   │   ├── HabitTrackerView.swift
│   │   ├── ResourceLibraryView.swift
│   │   ├── InsightsView.swift
│   │   ├── ProfileView.swift
│   │   └── PaywallView.swift
│   │
│   ├── Services/                  # Business logic
│   │   └── SuperwallManager.swift
│   │
│   ├── Assets.xcassets/           # Colors & images
│   ├── GroundedApp.swift          # App entry point
│   └── SETUP_GUIDE.md             # iOS setup instructions
│
├── grounded_prd.md                # Product Requirements Document
├── QUICKSTART.md                  # Testing guide
├── FEATURE_CHECKLIST.md           # Complete feature list
├── PROJECT_OVERVIEW.md            # Project details
└── README.md                      # This file
```

## 🎨 Design System

### Color Palette
- **Primary**: #8BA888 (Soft sage green) - Calming, grounding
- **Accent**: #E8A598 (Soft coral) - CTAs and highlights
- **Background**: #FAFAF8 (Light neutral)
- **Text**: #2C2C2C (Dark charcoal)

### Design Principles
- Minimalist, uncluttered interfaces
- Ample white space for calm
- Soft shadows and rounded corners
- Smooth animations (0.3s ease-in-out)
- Accessibility-first approach

## 🛠️ Technical Stack

### iOS App
- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Data**: SwiftData (iOS 17+)
- **Architecture**: MVVM
- **Minimum iOS**: 16.0
- **Monetization**: Superwall SDK (optional)

### Web Demo
- **HTML5** + **CSS3** + **Vanilla JavaScript**
- **Storage**: localStorage API
- **Responsive**: Mobile-first design

## 📋 Development Status

### ✅ Phase 1 (MVP) - COMPLETE
- [x] Onboarding flow (5 screens)
- [x] All 4 grounding exercises
- [x] Habit tracking with streaks
- [x] Resource library (6 articles)
- [x] Insights dashboard
- [x] Profile & settings
- [x] Paywall UI and logic
- [x] Data persistence
- [x] Web demo

### 🚧 Phase 2 (Enhancement) - Planned
- [ ] CloudKit sync
- [ ] Push notifications
- [ ] Advanced insights with Charts
- [ ] Audio guides
- [ ] Data export (CSV/PDF)

### 🔮 Phase 3 (Launch) - Planned
- [ ] TestFlight beta
- [ ] App Store submission
- [ ] Marketing materials
- [ ] Analytics integration

## 📊 Success Metrics

### User Engagement
- Daily/Weekly Active Users
- Grounding exercise completion rate
- Habit tracker usage rate
- Average session duration

### Health Outcomes
- Average mood improvement per session
- DPDR episode frequency reduction
- User-reported quality of life improvements

### Business Metrics
- Free to Premium conversion rate
- User retention (Day 1, 7, 30)
- Average Revenue Per User (ARPU)

## 🧪 Testing

### Web Demo Testing
```bash
# Navigate to demo folder
cd demo

# Open in browser
# Windows: Double-click launch.bat
# Mac/Linux: open index.html
```

### iOS Testing
```bash
# In Xcode
# 1. Select simulator or device
# 2. Press ⌘R to build and run
# 3. Complete onboarding
# 4. Test all features
```

## 📚 Documentation

- **[PRD](grounded_prd.md)**: Complete product requirements
- **[Quick Start](QUICKSTART.md)**: How to test the demo
- **[Setup Guide](Grounded/SETUP_GUIDE.md)**: iOS app setup
- **[Feature Checklist](FEATURE_CHECKLIST.md)**: All features status
- **[Project Overview](PROJECT_OVERVIEW.md)**: Technical details

## 🤝 Contributing

This is a proprietary project. For questions or collaboration:
1. Review the PRD and documentation
2. Test the web demo
3. Check the feature checklist
4. Contact the development team

## 📄 License

Proprietary - All rights reserved

## 🆘 Support

### For Users
- In-app help center
- Contact support via profile
- Crisis resources available 24/7

### For Developers
- Check `SETUP_GUIDE.md` for iOS setup
- Review `QUICKSTART.md` for testing
- See `FEATURE_CHECKLIST.md` for status

## 🎯 Roadmap

**Q2 2026:**
- ✅ MVP development complete
- 🚧 TestFlight beta testing
- 📅 App Store submission

**Q3 2026:**
- Phase 2 features (CloudKit, notifications)
- Advanced insights
- Audio guides

**Q4 2026:**
- Community features
- Therapist integration
- Android version exploration

## 🌟 Acknowledgments

- Designed for individuals managing DPDR
- Evidence-based grounding techniques
- Inspired by Calm, Headspace, and Sanvello
- Built with compassion and understanding

---

<div align="center">

**Made with 🍃 for mental health and wellbeing**

[Test Web Demo](demo/index.html) • [Read PRD](grounded_prd.md) • [Setup iOS](Grounded/SETUP_GUIDE.md)

</div>
