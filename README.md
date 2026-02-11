# Grounded - DPDR Mental Health App

<div align="center">

🍃 **Your companion for managing Depersonalization-Derealization Disorder**

[![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)](https://www.apple.com/ios/)
[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-green.svg)](https://developer.apple.com/xcode/swiftui/)

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

Affects approximately 2% of the population, with limited dedicated digital solutions available.

## ✨ Key Features

### 🧘 Grounding Exercises
- **5-4-3-2-1 Technique**: Engage all five senses to anchor in the present
- **Body Scan**: Progressive body awareness meditation
- **Breath Work**: 4-7-8 breathing technique with visual guide
- **Sensory Grounding**: Deep focus on individual senses
- Pre/post mood tracking to measure effectiveness

### ✅ Habit Tracking
- Create custom habits with icons and colors
- Pre-built templates (Water, Exercise, Meditation, Sleep, etc.)
- Daily completion tracking with streak counters
- Visual progress indicators
- Unlimited habits for premium users

### 📚 Educational Resources
- 10 comprehensive articles about DPDR with full content
- Categories: Understanding, Coping Strategies, Treatment, Community, Crisis
- Evidence-based information from mental health research
- Search and filter functionality
- 3-10 minute read times

### 📊 Insights & Analytics
- Track grounding session frequency and patterns
- Monitor mood improvement over time
- Habit completion rates and trends
- Visual statistics dashboard
- Advanced insights for premium users

### 💎 Freemium Business Model

**Free Tier:**
- 3 grounding exercises per day
- 3 habit trackers
- Basic educational resources
- 7-day progress tracking

**Premium ($4.99/month or $39.99/year):**
- Unlimited grounding exercises
- Unlimited habit trackers
- Full resource library (24+ articles)
- Advanced insights and analytics
- CloudKit sync across devices
- Data export (CSV/PDF)
- Priority support

## 🎨 Design Philosophy

### Visual Identity
- **Primary Color**: #8BA888 (Soft sage green) - Calming, grounding
- **Accent Color**: #E8A598 (Soft coral) - Warm, encouraging
- **Background**: #FAFAF8 (Light neutral) - Clean, peaceful
- **Typography**: SF Pro (iOS native) - Clear, accessible

### UX Principles
- Minimalist, uncluttered interfaces to reduce cognitive load
- Ample white space for calm and focus
- Soft shadows and rounded corners (12-16pt radius)
- Smooth animations (0.3s ease-in-out)
- Accessibility-first approach (VoiceOver, Dynamic Type)
- Gentle haptic feedback for user actions

## 🚀 Quick Start

### Web Demo (Immediate Testing)
1. Navigate to `demo/` folder
2. Double-click `launch.bat` (Windows) or open `index.html` in browser
3. Complete onboarding and test all features
4. Fully functional with localStorage persistence

### iOS Development (Requires Mac + Xcode)
1. **Prerequisites:**
   - macOS 13.0+
   - Xcode 15.0+
   - iOS 16.0+ device or simulator

2. **Setup:**
   ```bash
   cd Grounded
   open Grounded.xcodeproj
   ```

3. **Build & Run:**
   - Select target device/simulator
   - Press ⌘R or click Play button
   - App launches with full functionality

See `Grounded/SETUP_GUIDE.md` for detailed iOS setup instructions.

## 📁 Project Structure

```
Grounded/
├── demo/                          # Web demo for immediate testing
│   ├── index.html                 # Full-featured web version
│   ├── styles.css                 # Complete styling
│   ├── app.js                     # All app logic
│   └── launch.bat                 # Windows launcher
│
├── Grounded/                      # iOS Swift/SwiftUI application
│   ├── Models/                    # Data models (SwiftData)
│   │   ├── User.swift
│   │   ├── GroundingSession.swift
│   │   ├── Habit.swift
│   │   ├── Resource.swift
│   │   └── ResourceData.swift     # 10 complete articles
│   │
│   ├── Views/                     # SwiftUI views (all screens)
│   │   ├── OnboardingView.swift
│   │   ├── MainTabView.swift
│   │   ├── HomeView.swift
│   │   ├── GroundingExerciseSelectionView.swift
│   │   ├── FiveFourThreeTwoOneView.swift
│   │   ├── BodyScanView.swift
│   │   ├── BreathWorkView.swift
│   │   ├── SensoryGroundingView.swift
│   │   ├── HabitTrackerView.swift
│   │   ├── ResourceLibraryView.swift
│   │   ├── InsightsView.swift
│   │   ├── AdvancedInsightsView.swift
│   │   ├── ProfileView.swift
│   │   ├── PaywallView.swift
│   │   ├── CloudSyncView.swift
│   │   └── DataExportView.swift
│   │
│   ├── Services/                  # Business logic layer
│   │   ├── SuperwallManager.swift
│   │   ├── CloudKitManager.swift
│   │   ├── NotificationManager.swift
│   │   └── DataExportManager.swift
│   │
│   ├── Assets.xcassets/           # Colors and images
│   ├── GroundedApp.swift          # App entry point
│   ├── ContentView.swift          # Root view
│   └── SETUP_GUIDE.md             # iOS setup instructions
│
├── AppStore/                      # App Store materials
│   └── APP_STORE_LISTING.md       # Listing copy and metadata
│
├── Marketing/                     # Marketing materials
│   ├── PRESS_KIT.md               # Press kit and assets
│   └── PRESS_RELEASE.md           # Launch press release
│
├── .github/workflows/             # CI/CD automation
│   └── build-simulator.yml        # Automated iOS builds
│
├── grounded_prd.md                # Product Requirements Document
└── README.md                      # This file
```

## 🛠️ Technical Stack

### iOS Application
- **Language**: Swift 5.9+
- **Framework**: SwiftUI (declarative UI)
- **Data Persistence**: SwiftData (iOS 17+)
- **Architecture**: MVVM (Model-View-ViewModel)
- **Minimum iOS**: 16.0
- **Cloud Sync**: CloudKit (optional)
- **Monetization**: Superwall SDK integration ready
- **Analytics**: Ready for integration

### Web Demo
- **Frontend**: HTML5 + CSS3 + Vanilla JavaScript
- **Storage**: localStorage API
- **Design**: Responsive, mobile-first
- **Performance**: Lightweight, no dependencies

## 📊 Market Opportunity

### Target Audience
- **Primary**: Adults 18-35 experiencing DPDR symptoms
- **Secondary**: Mental health professionals recommending tools
- **Tertiary**: Individuals with anxiety disorders (comorbidity)

### Market Size
- 2% of population experiences DPDR (~6.6M in US)
- Mental health app market: $4.2B (2023), growing 23% CAGR
- Limited competition in DPDR-specific apps

### Competitive Advantage
- **Specialized**: Only app focused specifically on DPDR
- **Evidence-based**: Grounding techniques proven effective
- **Comprehensive**: Combines exercises, tracking, and education
- **User-friendly**: Clean design reduces cognitive load
- **Affordable**: Lower price point than therapy ($4.99/mo vs $100+/session)

## 💰 Business Model

### Revenue Streams
1. **Subscription Revenue**: $4.99/month or $39.99/year
2. **Freemium Conversion**: Target 5-10% conversion rate
3. **B2B Licensing**: Therapist/clinic partnerships (future)

### Projections (Year 1)
- **Users**: 10,000 downloads
- **Conversion**: 7% to premium (700 users)
- **MRR**: $3,493 (monthly recurring revenue)
- **ARR**: $41,916 (annual recurring revenue)

### Unit Economics
- **CAC** (Customer Acquisition Cost): $15-25 (social ads)
- **LTV** (Lifetime Value): $120-180 (24-36 month retention)
- **LTV:CAC Ratio**: 6:1 (healthy SaaS metric)

## 📈 Success Metrics

### User Engagement
- Daily Active Users (DAU) / Monthly Active Users (MAU)
- Grounding exercise completion rate
- Habit tracker usage rate
- Average session duration
- User retention (Day 1, 7, 30)

### Health Outcomes
- Average mood improvement per session
- User-reported DPDR episode frequency reduction
- Habit streak lengths
- User testimonials and ratings

### Business Metrics
- Free to Premium conversion rate
- Monthly Recurring Revenue (MRR)
- Churn rate
- Average Revenue Per User (ARPU)
- Customer Acquisition Cost (CAC)

## 🚦 Development Status

### ✅ Phase 1 - MVP (Complete)
- Onboarding flow (5 screens)
- All 4 grounding exercises with mood tracking
- Habit tracking system with streaks
- Resource library (10 complete articles)
- Insights dashboard
- Profile and settings
- Data persistence (SwiftData)
- Web demo for testing

### ✅ Phase 2 - Enhancement (Complete)
- Advanced insights with detailed analytics
- CloudKit sync infrastructure
- Push notification system
- Data export functionality (CSV/PDF)
- Paywall integration (Superwall)
- Additional premium articles (14+)

### 🔜 Phase 3 - Launch Preparation
- [ ] TestFlight beta testing (50-100 users)
- [ ] App Store submission and review
- [ ] Marketing website
- [ ] Social media presence
- [ ] Press outreach
- [ ] Analytics integration (Mixpanel/Amplitude)

### 🔮 Phase 4 - Post-Launch
- [ ] User feedback implementation
- [ ] A/B testing for conversion optimization
- [ ] Community features (forums, groups)
- [ ] Therapist dashboard (B2B)
- [ ] Apple Watch companion app
- [ ] Android version exploration

## 🧪 Testing

### Web Demo
```bash
cd demo
# Windows: Double-click launch.bat
# Mac/Linux: open index.html
```
Test all features immediately in browser with full functionality.

### iOS Simulator
```bash
cd Grounded
open Grounded.xcodeproj
# Press ⌘R in Xcode
```

### Automated Builds
GitHub Actions automatically builds iOS app on every push. See `.github/workflows/build-simulator.yml`

## 📚 Documentation

- **[Product Requirements](grounded_prd.md)**: Complete PRD with all specifications
- **[iOS Setup Guide](Grounded/SETUP_GUIDE.md)**: Detailed Xcode setup instructions
- **[App Store Listing](AppStore/APP_STORE_LISTING.md)**: Store copy and metadata
- **[Press Kit](Marketing/PRESS_KIT.md)**: Media assets and information
- **[Press Release](Marketing/PRESS_RELEASE.md)**: Launch announcement

## 🎯 Go-to-Market Strategy

### Launch Plan
1. **Beta Testing** (4 weeks): TestFlight with 50-100 users
2. **Soft Launch** (2 weeks): Limited marketing, gather feedback
3. **Full Launch**: App Store feature request, press outreach
4. **Growth**: Content marketing, social media, partnerships

### Marketing Channels
- **Organic**: App Store Optimization (ASO), SEO content
- **Paid**: Facebook/Instagram ads targeting anxiety/mental health
- **Community**: Reddit (r/dpdr, r/Anxiety), mental health forums
- **Partnerships**: Mental health influencers, therapists
- **PR**: Mental health publications, tech blogs

### Pricing Strategy
- **Free tier**: Generous to build user base and trust
- **Premium**: Priced below therapy ($4.99/mo vs $100+/session)
- **Annual discount**: 33% off to encourage commitment ($39.99/year)
- **Trial**: 7-day free trial for premium features

## 🤝 Team & Roles

### Current Status
- **Product**: Complete MVP with all core features
- **Design**: Professional UI/UX with accessibility focus
- **Development**: Production-ready iOS app + web demo
- **Content**: 10 complete educational articles

### Needed for Launch
- **Marketing**: Growth marketer or agency
- **QA**: Beta testers and quality assurance
- **Legal**: Privacy policy, terms of service review
- **Support**: Customer support system setup

## 📄 License & Legal

- **Code**: Proprietary - All rights reserved
- **Privacy**: HIPAA-aware design (no PHI stored)
- **Terms**: Standard SaaS terms of service
- **Data**: User data encrypted, stored securely

## 🆘 Support

### For Users
- In-app help center
- Email support: support@groundedapp.com
- Crisis resources available 24/7 in app

### For Developers
- See `Grounded/SETUP_GUIDE.md` for iOS setup
- See `grounded_prd.md` for complete specifications
- Web demo in `demo/` folder for immediate testing

## 🌟 Why Grounded Will Succeed

1. **Underserved Market**: No dedicated DPDR apps exist
2. **Evidence-Based**: Grounding techniques clinically proven
3. **Complete Solution**: Exercises + tracking + education
4. **User-Centered Design**: Built with DPDR sufferers in mind
5. **Scalable**: Digital product with low marginal costs
6. **Monetizable**: Clear freemium conversion path
7. **Expandable**: Multiple growth opportunities (B2B, Watch, Android)

---

<div align="center">

**Made with 🍃 for mental health and wellbeing**

[Test Web Demo](demo/index.html) • [Read PRD](grounded_prd.md) • [View Marketing](Marketing/)

**Ready for beta testing and App Store submission**

</div>
