# ⚡ Quick Guide: Build Grounded for Appetize.io

## 🎯 Goal
Build iOS Simulator `.app` file to upload to Appetize.io for testing on Windows.

---

## ✅ Prerequisites

- Mac computer
- Xcode 15.0+ installed
- Grounded project files

---

## 🚀 Fast Track (10 Minutes)

### 1. Create Xcode Project (2 min)

```bash
# Open Xcode
# File > New > Project
# iOS > App
# Name: Grounded
# Interface: SwiftUI
# Storage: SwiftData
# Language: Swift
```

---

### 2. Add Project Files (3 min)

**Copy these folders to Xcode:**

```
Grounded/
├── Models/
│   ├── User.swift
│   ├── GroundingSession.swift
│   ├── Habit.swift
│   ├── Resource.swift
│   └── ResourceData.swift
│
├── Views/
│   ├── MainTabView.swift
│   ├── OnboardingView.swift
│   ├── HomeView.swift
│   ├── FiveFourThreeTwoOneView.swift
│   ├── BodyScanView.swift
│   ├── BreathWorkView.swift
│   ├── SensoryGroundingView.swift
│   ├── GroundingExerciseSelectionView.swift
│   ├── HabitTrackerView.swift
│   ├── ResourceLibraryView.swift
│   ├── InsightsView.swift
│   ├── AdvancedInsightsView.swift
│   ├── ProfileView.swift
│   ├── CloudSyncView.swift
│   ├── DataExportView.swift
│   └── PaywallView.swift
│
├── Services/
│   ├── SuperwallManager.swift
│   ├── CloudKitManager.swift
│   ├── NotificationManager.swift
│   └── DataExportManager.swift
│
├── Assets.xcassets/
│   └── Colors/
│
└── GroundedApp.swift
```

**Drag and drop into Xcode project navigator**

---

### 3. Update GroundedApp.swift (1 min)

Replace the default app file with:

```swift
import SwiftUI
import SwiftData

@main
struct GroundedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    User.self,
                    GroundingSession.self,
                    Habit.self
                ])
        }
    }
}
```

---

### 4. Update ContentView.swift (1 min)

```swift
import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [User]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        if users.isEmpty || !users[0].onboardingCompleted {
            OnboardingView()
        } else {
            MainTabView()
        }
    }
}
```

---

### 5. Build for Simulator (2 min)

1. **Select Simulator:**
   - Top of Xcode: Click device selector
   - Choose: "iPhone 15 Pro" (or any simulator)

2. **Build:**
   - Press `⌘B` (Command + B)
   - OR: Product > Build
   - Wait for "Build Succeeded"

---

### 6. Find .app File (1 min)

**In Xcode:**
- Product > Show Build Folder in Finder
- Navigate to: `Products/Debug-iphonesimulator/`
- Find: `Grounded.app`

**OR via Terminal:**
```bash
cd ~/Library/Developer/Xcode/DerivedData/Grounded-*/Build/Products/Debug-iphonesimulator/
ls -la
# You'll see: Grounded.app
```

---

### 7. Compress for Appetize (1 min)

```bash
# In the same folder as Grounded.app
zip -r Grounded.zip Grounded.app

# Verify
ls -lh Grounded.zip
```

**✅ Done! You now have `Grounded.zip` ready for Appetize.io**

---

## 🔧 If Build Fails

### Error: "Cannot find 'SuperwallKit'"

**Option 1: Remove Superwall (Easiest)**
```swift
// In SuperwallManager.swift
// Comment out all Superwall imports and code

// In PaywallView.swift
// Replace with simple "Premium" message
```

**Option 2: Add Superwall SDK**
```bash
# In Xcode:
# File > Add Package Dependencies
# Enter: https://github.com/superwall-me/Superwall-iOS
# Add to project
```

---

### Error: "SwiftData requires iOS 17.0"

**Fix:**
1. Select project in Xcode
2. Go to "General" tab
3. Set "Minimum Deployments" to iOS 17.0

---

### Error: "Cannot find color 'PrimaryColor'"

**Fix:**
1. Copy `Assets.xcassets/Colors/` folder
2. Add to Xcode project
3. Ensure colors are in asset catalog

---

### Error: "Build Failed" (General)

**Try:**
1. Clean build folder: `⌘⇧K` (Command + Shift + K)
2. Rebuild: `⌘B`
3. Restart Xcode
4. Check error messages in Issue Navigator

---

## 🎯 Minimal Build (If Full Build Fails)

Create a simplified version with just core features:

### Files Needed:
```
Minimal/
├── GroundedApp.swift
├── ContentView.swift
├── Models/
│   ├── User.swift
│   └── GroundingSession.swift
└── Views/
    ├── OnboardingView.swift
    ├── HomeView.swift
    └── FiveFourThreeTwoOneView.swift
```

This gives you:
- ✅ Onboarding
- ✅ Home screen
- ✅ One grounding exercise
- ✅ Basic functionality

**Build this first, then add more features!**

---

## 📋 Build Checklist

- [ ] Xcode project created
- [ ] All files added to project
- [ ] Simulator selected (not device)
- [ ] Build succeeded (⌘B)
- [ ] .app file located
- [ ] .app compressed to .zip
- [ ] Ready to upload to Appetize!

---

## 🚀 Upload to Appetize

1. **Go to:** https://appetize.io/login
2. **Click:** "Upload App" or "New App"
3. **Select:** `Grounded.zip`
4. **Wait:** 1-2 minutes for processing
5. **Launch:** Click "Launch" to test
6. **Share:** Copy public link for Windows testing

---

## ⏱️ Time Estimate

| Step | Time |
|------|------|
| Create Xcode project | 2 min |
| Add files | 3 min |
| Configure app | 2 min |
| Build | 2 min |
| Find & compress | 2 min |
| **Total** | **11 min** |

*Plus upload time to Appetize: 2-3 min*

---

## 💡 Pro Tips

### 1. Test Locally First
```bash
# Run in simulator before uploading
⌘R in Xcode
```

### 2. Check File Size
```bash
# Smaller = faster upload
ls -lh Grounded.zip

# Should be under 100MB
```

### 3. Build Release Version
```bash
# For better performance
# In Xcode: Product > Scheme > Edit Scheme
# Run > Build Configuration > Release
```

### 4. Keep Build Folder
```bash
# Don't clean if you need to rebuild
# Saves time on subsequent builds
```

---

## 🆘 Still Having Issues?

### Can't Build?
- Start with minimal version
- Add features one by one
- Test after each addition

### No Mac Access?
- Borrow from friend/library
- Rent cloud Mac ($30-50/month)
- Hire someone to build ($10-20)
- Use iSwift.dev instead (no build needed)

### Build Works but Crashes?
- Test on Xcode simulator first
- Check console logs
- Remove complex features
- Start simple, add gradually

---

## 📖 Next Steps

After building:
1. Upload to Appetize.io
2. Test on Windows browser
3. Share link with team
4. Iterate and improve

**Full Guide:** `APPETIZE_COMPLETE_GUIDE.md`

---

<div align="center">

**Ready to build?**

Open Xcode and follow the steps above!

Takes ~11 minutes from start to finish.

</div>
