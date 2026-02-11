# 🚀 Production Backend Setup Guide

## Overview

This guide will help you set up the REAL backend services for Grounded:
1. Superwall (Paywall & Subscriptions)
2. CloudKit (Cloud Sync)
3. Push Notifications

## 1. Superwall Setup (Paywall & Subscriptions)

### Step 1: Create Superwall Account
1. Go to https://superwall.com
2. Sign up for an account
3. Create a new project called "Grounded"

### Step 2: Get API Key
1. In Superwall dashboard, go to Settings → API Keys
2. Copy your **Public API Key** (starts with `pk_`)

### Step 3: Add API Key to App
1. Open `Grounded/Services/SuperwallManager.swift`
2. Find line: `let apiKey = "pk_YOUR_API_KEY_HERE"`
3. Replace with your actual key: `let apiKey = "pk_abc123..."`

### Step 4: Configure Paywalls in Superwall
1. In Superwall dashboard, go to Paywalls
2. Create paywalls for these events:
   - `grounding_limit_reached`
   - `habit_limit_reached`
   - `premium_resource_access`
   - `advanced_insights_access`
   - `onboarding_complete`
   - `data_export_attempt`

### Step 5: Set Up Products
1. Go to Products in Superwall dashboard
2. Create subscription products:
   - **Monthly**: $9.99/month
   - **Yearly**: $79.99/year (save 33%)
3. Link to App Store Connect products (see below)

### Step 6: App Store Connect Setup
1. Go to https://appstoreconnect.apple.com
2. Create In-App Purchases:
   - Product ID: `com.grounded.app.monthly`
   - Product ID: `com.grounded.app.yearly`
3. Set pricing and descriptions
4. Submit for review

**Superwall is now configured!** ✅

---

## 2. CloudKit Setup (Cloud Sync)

### Step 1: Enable iCloud in Xcode
1. Open `Grounded.xcodeproj` in Xcode
2. Select the Grounded target
3. Go to "Signing & Capabilities" tab
4. Click "+ Capability"
5. Add "iCloud"

### Step 2: Configure iCloud Container
1. In iCloud capability, check "CloudKit"
2. Click "+" to add container
3. Enter: `iCloud.com.grounded.app`
4. Make sure it's selected

### Step 3: Update CloudKitManager
The container identifier is already set in `CloudKitManager.swift`:
```swift
container = CKContainer(identifier: "iCloud.com.grounded.app")
```

### Step 4: Create CloudKit Schema
1. Go to https://icloud.developer.apple.com
2. Select your container: `iCloud.com.grounded.app`
3. Create Record Types:

**User Record:**
- Record Type: `User`
- Fields:
  - `name` (String)
  - `onboardingCompleted` (Int64)
  - `goals` (String List)
  - `isPremium` (Int64)
  - `createdAt` (Date/Time)

**GroundingSession Record:**
- Record Type: `GroundingSession`
- Fields:
  - `exerciseType` (String)
  - `startTime` (Date/Time)
  - `endTime` (Date/Time)
  - `duration` (Double)
  - `preMoodRating` (Int64)
  - `postMoodRating` (Int64)
  - `notes` (String)

**Habit Record:**
- Record Type: `Habit`
- Fields:
  - `name` (String)
  - `icon` (String)
  - `frequencyData` (Bytes)
  - `reminderTime` (Date/Time)
  - `createdAt` (Date/Time)
  - `completionsData` (Bytes)

### Step 5: Deploy Schema
1. Click "Deploy Schema Changes"
2. Deploy to Production

**CloudKit is now configured!** ✅

---

## 3. Push Notifications Setup

### Step 1: Enable Push Notifications in Xcode
1. Open `Grounded.xcodeproj` in Xcode
2. Select the Grounded target
3. Go to "Signing & Capabilities" tab
4. Click "+ Capability"
5. Add "Push Notifications"

### Step 2: Create APNs Key
1. Go to https://developer.apple.com/account
2. Go to Certificates, Identifiers & Profiles
3. Click Keys → "+" to create new key
4. Name it "Grounded Push Notifications"
5. Check "Apple Push Notifications service (APNs)"
6. Download the `.p8` file
7. Note the Key ID

### Step 3: Configure in App
The app is already configured to request notification permissions.
Notifications will work automatically once the capability is enabled.

**Push Notifications are now configured!** ✅

---

## 4. Testing

### Test Superwall
1. Run the app
2. Complete 3 grounding sessions
3. On the 4th session, paywall should appear
4. Test purchase flow

### Test CloudKit
1. Run the app on two devices with same iCloud account
2. Create a habit on device 1
3. Go to Profile → Cloud Sync → Sync Now
4. Open app on device 2
5. Go to Profile → Cloud Sync → Sync Now
6. Habit should appear on device 2

### Test Push Notifications
1. Run the app
2. Grant notification permission
3. Go to Profile → Notifications
4. Enable "Habit Reminders"
5. Add a habit with reminder time
6. Wait for notification at scheduled time

---

## 5. Environment Variables (Optional)

For better security, you can use environment variables:

### Create Config.xcconfig
```
SUPERWALL_API_KEY = pk_your_actual_key_here
CLOUDKIT_CONTAINER = iCloud.com.grounded.app
```

### Update Code
```swift
let apiKey = ProcessInfo.processInfo.environment["SUPERWALL_API_KEY"] ?? "pk_YOUR_API_KEY_HERE"
```

---

## 6. Production Checklist

Before App Store submission:

- [ ] Superwall API key added
- [ ] Paywalls configured in Superwall dashboard
- [ ] In-App Purchases created in App Store Connect
- [ ] iCloud capability enabled
- [ ] CloudKit schema deployed
- [ ] Push Notifications capability enabled
- [ ] APNs key created
- [ ] Privacy policy updated with data collection info
- [ ] Terms of service created
- [ ] Tested on real device (not simulator)
- [ ] Tested subscription purchase
- [ ] Tested CloudKit sync
- [ ] Tested push notifications

---

## 7. Costs

**Superwall:**
- Free tier: Up to $10k MRR
- After: 1% of revenue

**CloudKit:**
- Free tier: 10GB storage, 200GB transfer
- Very generous limits for most apps

**APNs:**
- Completely free

**Total estimated cost for first 1000 users:** $0-50/month

---

## 8. Support

**Superwall Issues:**
- Docs: https://docs.superwall.com
- Support: support@superwall.com

**CloudKit Issues:**
- Docs: https://developer.apple.com/icloud/cloudkit/
- Forums: https://developer.apple.com/forums/

**APNs Issues:**
- Docs: https://developer.apple.com/documentation/usernotifications
- Forums: https://developer.apple.com/forums/

---

## Quick Start (TL;DR)

1. Get Superwall API key → Add to `SuperwallManager.swift`
2. Enable iCloud in Xcode → Create CloudKit schema
3. Enable Push Notifications in Xcode
4. Test everything
5. Submit to App Store

**Estimated setup time:** 2-3 hours
