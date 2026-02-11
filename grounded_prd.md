# Product Requirements Document: Grounded

**Version:** 1.0  
**Last Updated:** February 11, 2026  
**Platform:** iOS (Swift/SwiftUI, Xcode)  
**Target Condition:** Depersonalization-Derealization Disorder (DPDR)

---

## Executive Summary

**Grounded** is a mental health iOS application designed to help individuals manage Depersonalization-Derealization Disorder (DPDR) through evidence-based grounding techniques, habit tracking, and educational resources. The app provides a calming, professional interface that serves as a safe space for users experiencing dissociative symptoms.

### What is DPDR?

Depersonalization-Derealization Disorder (DPDR) is a dissociative disorder characterized by:
- **Depersonalization**: Feeling disconnected from oneself, like an outside observer of one's own thoughts and body
- **Derealization**: Feeling detached from surroundings, perceiving the world as foggy, dreamlike, or unreal
- Persistent or recurrent episodes that cause significant distress
- Awareness that these perceptions are distorted (reality testing remains intact)

Common triggers include stress, anxiety, and fatigue. Grounding techniques that engage the five senses are clinically proven to help manage symptoms.

---

## Product Vision

Create a calming, accessible iOS app that empowers DPDR sufferers to:
1. Quickly access grounding techniques during episodes
2. Build consistent mental health habits
3. Understand their condition through trusted educational content
4. Track progress over time

---

## Technical Stack

### Core Technologies
- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **IDE**: Xcode 15+
- **Minimum iOS Version**: iOS 16.0
- **Architecture**: MVVM (Model-View-ViewModel)

### Third-Party Services
- **Paywall**: Superwall SDK
- **Analytics** (Optional): TelemetryDeck or similar privacy-focused solution
- **Local Storage**: SwiftData or Core Data
- **CloudKit** (for sync across devices)

---

## Design Principles

### Visual Identity
**Inspiration**: Calm, Headspace, Sanvello, Bearable

**Color Palette**:
- Primary: Soft sage green (#8BA888) or muted teal (#6B9B9E) - calming, grounding
- Secondary: Warm off-white (#F5F5F0)
- Accent: Soft coral (#E8A598) for CTAs
- Background: Light neutral (#FAFAF8)
- Text: Dark charcoal (#2C2C2C)

**Typography**:
- Primary: SF Pro (system font) - professional, accessible
- Hierarchy: Clear size differentiation between headers, body, and captions
- Line spacing: Generous for easy reading during distress

**Visual Style**:
- Minimalist, uncluttered interfaces
- Ample white space
- Soft shadows and rounded corners (12-16pt radius)
- Subtle animations (ease-in-out, 0.3s duration)
- No jarring transitions or sudden movements
- Gentle haptic feedback

**Iconography**:
- SF Symbols for consistency
- Simple, recognizable icons
- Filled style for active states, outlined for inactive

---

## Core Features

### 1. Onboarding Flow

**Objective**: Help users understand the app while creating a sense of safety and personalization.

**Screens**:

1. **Welcome Screen**
   - Hero image (abstract, calming illustration)
   - "Welcome to Grounded"
   - Tagline: "Your companion for managing DPDR"
   - CTA: "Get Started"

2. **What is DPDR?** (Educational)
   - Brief, empathetic explanation
   - "You're not alone" messaging
   - Option to skip if already familiar

3. **How Grounding Works**
   - Explain the science behind grounding techniques
   - Visual metaphor (tree with roots)
   - 30 seconds or less

4. **Personalization**
   - "What name would you like us to use?" (optional)
   - "What are your goals?" (checkboxes: manage episodes, build habits, learn more, track progress)
   - Notification preferences

5. **Paywall Integration**
   - Present Superwall paywall
   - Clear free vs. premium features
   - "Start Free Trial" or "Continue with Free Version"

6. **Permission Requests**
   - Notifications (for habit reminders)
   - HealthKit integration (optional - for stress/heart rate data)

**Implementation Notes**:
- Use `TabView` with `PageTabViewStyle` for smooth swiping
- Store onboarding completion in `UserDefaults`
- Use Superwall's `Paywall.present()` method
- Graceful skip options - never force users through long flows

---

### 2. Grounding Button (Core Feature)

**Objective**: Provide immediate access to grounding exercises during DPDR episodes.

**Main Screen Placement**:
- Prominent placement on Home tab
- Large, accessible button (minimum 60pt height)
- Text: "I need to ground" or "Ground Now"
- Color: Calming accent color with subtle pulse animation when idle

**Grounding Exercise Flow**:

**Exercise Types** (rotate or user-selectable):

1. **5-4-3-2-1 Technique**
   - 5 things you can see
   - 4 things you can touch
   - 3 things you can hear
   - 2 things you can smell
   - 1 thing you can taste
   - **Implementation**: Step-by-step screens with text prompts, optional text input for each sense

2. **Body Scan**
   - Guided focus on different body parts
   - "Notice your feet on the ground..."
   - Progress indicator
   - Gentle haptic feedback for each body zone

3. **Breath Work**
   - Visual breathing guide (expanding/contracting circle)
   - 4-7-8 technique or box breathing
   - Optional audio cues
   - Session timer

4. **Sensory Grounding**
   - Focus on one sense at a time
   - Prompts: "Describe something you see in detail"
   - Freeform text input

**Session Details**:
- Duration: 2-10 minutes per exercise
- Calming background (soft gradient)
- Optional calming background sounds (white noise, nature sounds)
- Exit anytime with "I'm feeling better" button
- Session completion saved to history

**Post-Session**:
- "How do you feel now?" (1-5 scale)
- Optional journal entry
- Celebrate completion (gentle animation)
- Suggest next action (e.g., "Take a short walk")

**SwiftUI Components**:
```swift
struct GroundingButton: View
struct GroundingExerciseView: View
struct SensoryPromptView: View
struct BreathingAnimationView: View
```

---

### 3. Habit Tracker

**Objective**: Help users build consistent self-care routines that reduce DPDR episodes.

**Habit Categories**:
- Sleep (8+ hours)
- Hydration (track water intake)
- Exercise/Movement
- Meditation/Mindfulness
- Journaling
- Social connection
- Medication adherence (if applicable)
- Screen time limits

**Features**:

**Habit Creation**:
- Pre-built templates for DPDR-specific habits
- Custom habit creation
- Set frequency (daily, specific days, X times per week)
- Set reminder time
- Associate with goals

**Tracking Interface**:
- Daily checklist view
- Tap to mark complete (satisfying animation + haptic)
- Streak counter
- Weekly/monthly calendar view
- Heatmap visualization

**Data Visualization**:
- Current streak
- Longest streak
- Completion percentage
- Correlation insights (premium): "You complete grounding exercises 40% more on days when you track sleep"

**Implementation**:
- `@State` and `@Binding` for real-time updates
- Core Data/SwiftData for persistence
- CloudKit for cross-device sync
- Local notifications for reminders

**SwiftUI Components**:
```swift
struct HabitTrackerView: View
struct HabitCard: View
struct HabitDetailView: View
struct StreakBadgeView: View
struct CalendarHeatmapView: View
```

---

### 4. Educational Resources

**Objective**: Provide evidence-based information about DPDR, reducing fear and isolation.

**Content Categories**:

1. **Understanding DPDR**
   - What is DPDR?
   - Common symptoms
   - Causes and triggers
   - Neurological basis
   - You're not "going crazy"

2. **Coping Strategies**
   - Grounding techniques (detailed guides)
   - Managing anxiety
   - Sleep hygiene
   - Stress reduction
   - When to seek professional help

3. **Treatment Options**
   - Therapy approaches (CBT, EMDR)
   - Medication overview
   - Finding the right therapist
   - Questions to ask professionals

4. **Community & Stories**
   - Anonymous user stories (curated)
   - Expert interviews
   - Research updates
   - DPDR myths debunked

5. **Crisis Resources**
   - Hotline numbers (region-specific)
   - When to seek emergency care
   - Grounding in crisis

**Content Format**:
- Short articles (3-5 min read)
- Infographics
- Video content (optional, premium)
- Audio guides (optional)

**Implementation**:
- JSON-based content system (easy updates)
- Markdown rendering for articles
- Bookmark/favorite functionality
- Search functionality
- Progress tracking (articles read)
- Offline access

**SwiftUI Components**:
```swift
struct ResourceLibraryView: View
struct ArticleCardView: View
struct ArticleDetailView: View
struct SearchBarView: View
struct BookmarkView: View
```

---

## Navigation Structure

### Tab Bar (Main Navigation)
1. **Home** (SF Symbol: house.fill)
   - Grounding button
   - Daily check-in
   - Quick stats
   - Featured resource

2. **Habits** (SF Symbol: checklist)
   - Today's habits
   - Streak overview
   - Add new habit

3. **Resources** (SF Symbol: book.fill)
   - Resource library
   - Search
   - Bookmarks

4. **Insights** (SF Symbol: chart.line.uptrend.xyaxis)
   - Progress over time
   - Pattern recognition
   - Goal tracking
   - **Premium feature indicator**

5. **Profile** (SF Symbol: person.crop.circle.fill)
   - Settings
   - Subscription management
   - About
   - Support

---

## Freemium Model (Superwall Integration)

### Free Tier
- 3 grounding exercises per day
- 3 habit trackers
- Basic educational resources (50% of content)
- Basic progress stats (last 7 days)

### Premium Tier ($4.99/month or $39.99/year)
- Unlimited grounding exercises
- Unlimited habit trackers
- Full resource library
- Advanced insights and correlations
- Custom exercise creation
- CloudKit sync across devices
- Export data (CSV/PDF)
- Priority support
- Audio guides
- No ads/promotional content

### Superwall Implementation

**Paywall Trigger Points**:
1. After 3 grounding exercises (soft paywall)
2. When attempting to add 4th habit
3. When accessing premium resources
4. After onboarding (optional trial offer)
5. In Insights tab

**Implementation Steps**:
1. Add Superwall SDK via SPM:
   ```
   https://github.com/superwall-me/Superwall-iOS
   ```

2. Configure in AppDelegate/App struct:
   ```swift
   import SuperwallKit

   Superwall.configure(apiKey: "YOUR_API_KEY")
   ```

3. Present paywall:
   ```swift
   Superwall.shared.register(event: "grounding_limit_reached")
   ```

4. Check subscription status:
   ```swift
   Superwall.shared.subscriptionStatus
   ```

---

## Data Models

### User
```swift
@Model
class User {
    var id: UUID
    var name: String?
    var onboardingCompleted: Bool
    var goals: [String]
    var createdAt: Date
    var isPremium: Bool
}
```

### GroundingSession
```swift
@Model
class GroundingSession {
    var id: UUID
    var exerciseType: ExerciseType
    var startTime: Date
    var endTime: Date
    var duration: TimeInterval
    var preMoodRating: Int?
    var postMoodRating: Int?
    var notes: String?
}

enum ExerciseType: String, Codable {
    case fiveFourThreeTwoOne
    case bodyScan
    case breathWork
    case sensoryGrounding
}
```

### Habit
```swift
@Model
class Habit {
    var id: UUID
    var name: String
    var icon: String
    var frequency: HabitFrequency
    var reminderTime: Date?
    var createdAt: Date
    var completions: [HabitCompletion]
}

struct HabitCompletion {
    var date: Date
    var completed: Bool
}

enum HabitFrequency: Codable {
    case daily
    case specificDays([Weekday])
    case timesPerWeek(Int)
}
```

### Resource
```swift
struct Resource: Identifiable, Codable {
    var id: UUID
    var title: String
    var category: ResourceCategory
    var content: String // Markdown
    var readTime: Int // minutes
    var isPremium: Bool
    var isBookmarked: Bool
}

enum ResourceCategory: String, Codable {
    case understandingDPDR
    case copingStrategies
    case treatment
    case community
    case crisis
}
```

---

## Key User Flows

### Flow 1: First-Time User → Grounding Exercise
1. Launch app
2. Complete onboarding (5 screens)
3. See Superwall paywall → choose free or trial
4. Land on Home tab
5. Tap "Ground Now" button
6. Select or auto-start exercise (5-4-3-2-1)
7. Complete exercise steps
8. Rate mood improvement
9. See completion celebration
10. Return to Home with session logged

### Flow 2: Existing User → Daily Check-In
1. Open app (already onboarded)
2. Home tab shows daily check-in prompt
3. Mark habits complete
4. View streak updates
5. Access grounding button if needed

### Flow 3: Learning About DPDR
1. Navigate to Resources tab
2. Browse or search for article
3. Tap article card
4. Read content (markdown formatted)
5. Bookmark for later
6. Return to browse more

---

## Technical Requirements

### Development Environment
- Xcode 15.0+
- Swift 5.9+
- iOS 16.0+ deployment target
- SwiftUI lifecycle

### Dependencies (Swift Package Manager)
- Superwall SDK
- Optional: TelemetryDeck (analytics)

### Performance Requirements
- App launch: < 2 seconds
- Grounding exercise start: < 0.5 seconds
- Smooth 60fps animations
- Offline functionality for core features

### Accessibility
- VoiceOver support for all UI elements
- Dynamic Type support
- High contrast mode support
- Minimum touch target size: 44x44pt
- Descriptive labels for all interactive elements

### Privacy & Security
- No personal data sharing without explicit consent
- Local-first data storage
- Optional CloudKit sync with encryption
- Compliance with App Store privacy requirements
- Crash data anonymization

---

## Development Phases

### Phase 1: MVP (4-6 weeks)
- Onboarding flow
- Home tab with grounding button
- One grounding exercise (5-4-3-2-1)
- Basic habit tracker (3 habits max)
- 10 educational articles
- Superwall integration
- Basic data persistence

**Deliverables**:
- Functional app ready for TestFlight
- Core user flow working end-to-end

### Phase 2: Enhancement (3-4 weeks)
- Additional grounding exercises (body scan, breath work)
- Full habit tracking features (custom habits, streaks, calendar)
- Expanded resource library (30+ articles)
- Insights tab (basic stats)
- CloudKit sync
- Notifications

### Phase 3: Polish & Launch (2-3 weeks)
- Advanced insights (correlations, patterns)
- Audio guides
- Data export
- Comprehensive testing
- App Store assets
- Marketing materials
- Soft launch

### Phase 4: Post-Launch (Ongoing)
- User feedback integration
- Content updates
- Performance optimization
- Feature expansion based on analytics
- Community features (optional)

---

## Success Metrics

### User Engagement
- Daily Active Users (DAU)
- Weekly Active Users (WAU)
- Average session duration
- Grounding exercise completion rate
- Habit tracker usage rate
- Resource article read rate

### Retention
- Day 1, 7, 30 retention rates
- Subscription retention (for premium)

### Business Metrics
- Conversion rate (free → premium)
- Average Revenue Per User (ARPU)
- Churn rate
- Lifetime Value (LTV)

### Health Outcomes (Self-Reported)
- DPDR episode frequency reduction
- Mood improvement scores
- User-reported quality of life improvements

---

## App Store Optimization

### App Name
"Grounded - DPDR Support"

### Subtitle
"Manage depersonalization with grounding exercises"

### Keywords
dpdr, depersonalization, derealization, grounding, dissociation, mental health, anxiety, mindfulness, meditation, therapy

### Description Highlights
- Clinically-informed grounding techniques
- Evidence-based habit tracking
- Comprehensive DPDR education
- Designed by mental health experts
- Privacy-first approach

### Screenshots (6-8)
1. Home screen with grounding button
2. Grounding exercise in action
3. Habit tracker with streaks
4. Resource library
5. Insights dashboard
6. Calming design showcase

---

## Risk Mitigation

### Technical Risks
- **Superwall integration issues**: Test thoroughly in sandbox, have backup IAP implementation ready
- **CloudKit sync conflicts**: Implement robust conflict resolution, prioritize local data
- **Performance on older devices**: Test on iPhone 11/iOS 16, optimize animations

### Product Risks
- **User acquisition in niche market**: Partner with DPDR communities, therapist recommendations
- **Content accuracy concerns**: Work with licensed mental health professionals for review
- **Crisis situations**: Clear disclaimers, prominent crisis resources, not a replacement for therapy

### Business Risks
- **Low conversion rate**: Strong value proposition for premium, generous free tier to build trust
- **High churn**: Regular content updates, community features, personalization

---

## Future Considerations

### Potential Features (Post-Launch)
- Community forum (moderated)
- Therapist directory integration
- Wearable device integration (Apple Watch for quick grounding)
- AI-powered pattern recognition
- Peer support matching
- Integration with therapy platforms (BetterHelp, Talkspace)
- Android version
- Web companion dashboard

### Monetization Expansion
- B2B licensing (therapist/clinic packages)
- Corporate wellness partnerships
- Affiliate partnerships with mental health services

---

## Appendix

### Useful Resources for Development

**DPDR Information**:
- Cleveland Clinic: DPDR Overview
- Mayo Clinic: Symptoms and Causes
- Unreal Charity: DPDR Support Organization

**SwiftUI Development**:
- Apple's SwiftUI Tutorials
- Hacking with Swift
- SwiftUI Lab

**Mental Health App Design**:
- Apple Health app design patterns
- Calm app UI patterns
- Headspace onboarding flows

**Superwall Documentation**:
- Superwall iOS SDK Docs
- Superwall Dashboard for paywall configuration

---

## Contact & Support

**Developer**: [Your Name]  
**Project Start**: February 2026  
**Expected MVP**: Q2 2026  

---

*This PRD is a living document and will be updated as the product evolves based on user feedback and market research.*
