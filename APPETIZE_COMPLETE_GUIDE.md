# 🚀 Complete Guide: Use Appetize.io to Preview Grounded iOS App

## ✅ GOOD NEWS: Appetize.io Has a FREE Plan!

**No credit card required!** You can sign up and test for free.

---

## 📋 What You Need

### Requirements:
1. ✅ **Appetize.io account** (FREE, no credit card)
2. ✅ **iOS Simulator .app file** (need Mac with Xcode to build)
3. ✅ **Windows PC** (to view the app in browser)

### What Appetize.io Needs:
- **File Format**: `.app` file (iOS Simulator build)
- **Compressed**: Must be in `.zip` or `.tar.gz` format
- **NOT Supported**: `.ipa` files (App Store builds)

---

## 🎯 Step-by-Step Process

### STEP 1: Sign Up for Appetize.io (FREE)

1. **Go to:** https://accounts.appetize.io/signup

2. **Create Account:**
   - Enter your email
   - Create password
   - NO credit card required!

3. **Verify Email:**
   - Check your inbox
   - Click verification link

4. **Login:**
   - Go to: https://appetize.io/login
   - Enter credentials

**✅ Done! You now have a FREE Appetize.io account**

---

### STEP 2: Build the iOS Simulator .app File

**⚠️ This requires a Mac with Xcode installed**

#### Option A: Build in Xcode (Easiest)

1. **Create Xcode Project:**
   ```bash
   # Open Xcode
   # File > New > Project
   # Choose: iOS > App
   # Name: Grounded
   # Interface: SwiftUI
   # Storage: SwiftData
   ```

2. **Add Project Files:**
   - Copy all files from `Grounded/` folder
   - Add to Xcode project:
     - `Models/` folder
     - `Views/` folder
     - `Services/` folder
     - `Assets.xcassets/`
     - `GroundedApp.swift`
     - `ContentView.swift`

3. **Select Simulator Target:**
   - At top of Xcode, click device selector
   - Choose: "iPhone 15 Pro" (or any simulator)
   - NOT "Any iOS Device" (that's for real devices)

4. **Build the App:**
   - Press `⌘B` (Command + B) to build
   - OR: Product > Build
   - Wait for build to complete

5. **Find the .app File:**
   - In Xcode menu: Product > Show Build Folder in Finder
   - Navigate to: `Products/Debug-iphonesimulator/`
   - You'll see: `Grounded.app`

6. **Compress the .app File:**
   ```bash
   # In Terminal, navigate to the folder
   cd ~/Library/Developer/Xcode/DerivedData/Grounded-*/Build/Products/Debug-iphonesimulator/
   
   # Create zip file
   zip -r Grounded.zip Grounded.app
   ```

**✅ You now have: `Grounded.zip`**

---

#### Option B: Build via Command Line

```bash
# Navigate to your Xcode project folder
cd /path/to/Grounded

# Build for simulator
xcodebuild -scheme Grounded \
  -sdk iphonesimulator \
  -configuration Debug \
  -derivedDataPath ./build

# Find the .app file
cd build/Build/Products/Debug-iphonesimulator/

# Compress it
zip -r Grounded.zip Grounded.app
```

**✅ You now have: `Grounded.zip`**

---

### STEP 3: Upload to Appetize.io

1. **Login to Appetize.io:**
   - Go to: https://appetize.io/login

2. **Upload App:**
   - Click "Upload App" or "New App"
   - Select your `Grounded.zip` file
   - Wait for upload to complete (may take 1-2 minutes)

3. **Configure Settings:**
   - **Platform**: iOS
   - **Device**: iPhone 15 Pro (or your choice)
   - **iOS Version**: Latest available
   - **Orientation**: Portrait

4. **Save:**
   - Click "Save" or "Create"
   - Appetize will process your app

**✅ Your app is now uploaded!**

---

### STEP 4: Test on Windows PC

1. **Get App Link:**
   - In Appetize dashboard, find your app
   - Click "Launch" or copy the public link

2. **Open in Browser:**
   - Open Chrome, Edge, or Firefox
   - Paste the Appetize link
   - App loads in browser!

3. **Interact with App:**
   - ✅ Click buttons
   - ✅ Navigate between screens
   - ✅ Complete onboarding
   - ✅ Try grounding exercises
   - ✅ Add habits
   - ✅ Browse resources
   - ✅ View insights

4. **Test Features:**
   - Full iOS simulator in browser
   - Real iOS styling
   - Native animations
   - Complete navigation
   - All features work!

**🎉 You're now testing the full iOS app on Windows!**

---

## 🆓 Appetize.io Free Plan Details

### What's Included (FREE):
- ✅ Upload apps
- ✅ Test in browser
- ✅ 100 minutes per month
- ✅ 1 concurrent session
- ✅ Public app links
- ✅ iOS & Android support
- ✅ NO credit card required

### Limitations:
- ⚠️ 100 minutes total per month
- ⚠️ 1 app running at a time
- ⚠️ Public links (anyone with link can access)

### How Long is 100 Minutes?
- **Quick test**: 5-10 minutes
- **Thorough test**: 20-30 minutes
- **Demo to stakeholders**: 10-15 minutes
- **Total**: Enough for 3-5 complete testing sessions

---

## 🔧 Troubleshooting

### "I don't have a Mac"

**Options:**

1. **Borrow a Mac:**
   - Friend, family, coworker
   - Apple Store (use demo Mac)
   - Library or university computer lab

2. **Rent Cloud Mac:**
   - MacStadium: $50-100/month
   - MacinCloud: $30-50/month
   - AWS Mac instances: Pay per hour

3. **Use Mac Build Service:**
   - Codemagic: Free tier available
   - Bitrise: Free tier available
   - GitHub Actions: Free for public repos

4. **Ask Someone to Build:**
   - Post on developer forums
   - Hire freelancer on Fiverr ($10-20)
   - Ask in iOS developer communities

---

### "Build Failed in Xcode"

**Common Issues:**

1. **Missing Dependencies:**
   ```
   Error: Cannot find 'SuperwallKit' in scope
   ```
   **Fix:** Comment out Superwall code or add SDK

2. **SwiftData Errors:**
   ```
   Error: @Model requires iOS 17.0
   ```
   **Fix:** Set deployment target to iOS 17.0+

3. **Asset Errors:**
   ```
   Error: Cannot find color 'PrimaryColor'
   ```
   **Fix:** Add color assets from `Assets.xcassets/`

**General Fix:**
- Start with minimal code
- Add files gradually
- Build after each addition
- Fix errors as they appear

---

### "Upload Failed to Appetize"

**Check:**
1. File is `.zip` or `.tar.gz` (not `.ipa`)
2. Contains `.app` bundle (not just files)
3. Built for simulator (not device)
4. File size under 500MB

**Fix:**
```bash
# Verify zip contents
unzip -l Grounded.zip

# Should show:
# Grounded.app/
# Grounded.app/Info.plist
# Grounded.app/Grounded
# etc.
```

---

### "App Crashes on Appetize"

**Try:**
1. Test on local Xcode simulator first
2. Check console logs in Appetize
3. Remove complex dependencies
4. Start with simple version
5. Add features gradually

---

## 📊 Alternative: Simplified Build

If full app build is too complex, create a simplified version:

### Minimal Grounded App

1. **Create new Xcode project**
2. **Add only essential files:**
   - `GroundedApp.swift`
   - `ContentView.swift`
   - `HomeView.swift`
   - `FiveFourThreeTwoOneView.swift`
3. **Remove dependencies:**
   - No Superwall
   - No CloudKit
   - No complex features
4. **Build and upload**

This gives you a working demo with core features!

---

## 🎯 Expected Results

### What You'll See on Appetize:

1. **Real iOS Simulator:**
   - Exact iOS interface
   - Native fonts (SF Pro)
   - Real shadows and blur
   - Smooth animations

2. **Full Navigation:**
   - Tab bar works
   - Screen transitions
   - Back buttons
   - Modal sheets

3. **Interactive Features:**
   - Buttons respond
   - Forms work
   - Lists scroll
   - Animations play

4. **Complete App:**
   - Onboarding flow
   - All 4 grounding exercises
   - Habit tracking
   - Resource library
   - Insights dashboard
   - Profile settings

---

## 💡 Pro Tips

### 1. Test Locally First
Before uploading to Appetize, test on Xcode simulator:
```bash
# Run in simulator
⌘R in Xcode
```

### 2. Create Multiple Builds
- **Minimal**: Core features only
- **Full**: All features
- **Demo**: Best features for showing

### 3. Share Links
Appetize gives you a public URL:
```
https://appetize.io/app/your-app-id
```
Share with anyone to demo!

### 4. Monitor Usage
- Check remaining minutes in dashboard
- 100 minutes = ~5 thorough tests
- Plan your testing sessions

### 5. Optimize Build Size
- Remove unused assets
- Compress images
- Smaller = faster upload

---

## 📋 Quick Reference

### Build Commands:
```bash
# Build for simulator
xcodebuild -scheme Grounded -sdk iphonesimulator

# Find .app file
cd ~/Library/Developer/Xcode/DerivedData/Grounded-*/Build/Products/Debug-iphonesimulator/

# Compress
zip -r Grounded.zip Grounded.app
```

### Appetize URLs:
- **Sign Up**: https://accounts.appetize.io/signup
- **Login**: https://appetize.io/login
- **Dashboard**: https://appetize.io/dashboard
- **Docs**: https://docs.appetize.io

### File Requirements:
- **Format**: `.zip` or `.tar.gz`
- **Contains**: `YourApp.app` bundle
- **Build Type**: iOS Simulator (not device)
- **Size**: Under 500MB

---

## 🎉 Success Checklist

- [ ] Created FREE Appetize.io account
- [ ] Built iOS Simulator .app file on Mac
- [ ] Compressed .app into .zip file
- [ ] Uploaded to Appetize.io
- [ ] Tested app in browser on Windows
- [ ] Verified all features work
- [ ] Shared link with stakeholders

---

## 🆘 Need Help?

### Can't Build on Mac?
- Use iSwift.dev for single screens (FREE, no Mac needed)
- Use web demo for functionality testing
- Hire someone to build ($10-20 on Fiverr)

### Don't Want to Use Appetize?
- **iSwift.dev**: Single screens, real iOS styling
- **Web Demo**: Full app, basic styling
- **Both**: Best of both worlds

### Want Professional Testing?
- **BrowserStack**: Paid, but more features
- **TestFlight**: Apple's official beta testing
- **Physical Device**: Best for final testing

---

## 📖 Additional Resources

- **Appetize Docs**: https://docs.appetize.io
- **Xcode Guide**: https://developer.apple.com/xcode/
- **SwiftUI Tutorial**: https://developer.apple.com/tutorials/swiftui
- **Our Setup Guide**: `Grounded/SETUP_GUIDE.md`

---

<div align="center">

**Ready to see the full iOS app on Windows?**

1. Sign up: https://accounts.appetize.io/signup (FREE!)
2. Build .app file on Mac
3. Upload to Appetize
4. Test on Windows! 🚀

**No Mac? Use iSwift.dev + Web Demo instead!**

</div>
