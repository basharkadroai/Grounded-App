# ⚡ Appetize.io Quick Start

## 🎯 Goal
Test full iOS app on Windows browser using Appetize.io (FREE, no credit card!)

---

## ✅ What You Need
- Mac with Xcode (to build)
- Windows PC (to test)
- 15 minutes total time

---

## 🚀 3 Simple Steps

### STEP 1: Build on Mac (11 min)

```bash
# 1. Create Xcode project
# File > New > Project > iOS App
# Name: Grounded

# 2. Add all files from Grounded/ folder

# 3. Select simulator (not device)
# Top of Xcode: Choose "iPhone 15 Pro"

# 4. Build
# Press ⌘B

# 5. Find .app file
# Product > Show Build Folder in Finder
# Go to: Products/Debug-iphonesimulator/

# 6. Compress
cd ~/Library/Developer/Xcode/DerivedData/Grounded-*/Build/Products/Debug-iphonesimulator/
zip -r Grounded.zip Grounded.app
```

**✅ You now have: `Grounded.zip`**

---

### STEP 2: Upload to Appetize (2 min)

```bash
# 1. Sign up (FREE, no credit card)
https://accounts.appetize.io/signup

# 2. Login
https://appetize.io/login

# 3. Upload
Click "Upload App"
Select: Grounded.zip
Wait 1-2 minutes

# 4. Launch
Click "Launch" button
```

**✅ App is now live!**

---

### STEP 3: Test on Windows (Unlimited)

```bash
# 1. Copy app link from Appetize

# 2. Open on Windows PC
Paste link in Chrome/Edge/Firefox

# 3. Test everything!
- Complete onboarding
- Try grounding exercises
- Add habits
- Browse resources
- View insights
```

**🎉 Full iOS app running on Windows!**

---

## 📋 Quick Checklist

- [ ] Mac with Xcode available
- [ ] Grounded files ready
- [ ] Xcode project created
- [ ] Files added to project
- [ ] Built for simulator (⌘B)
- [ ] .app file found
- [ ] Compressed to .zip
- [ ] Appetize account created (FREE)
- [ ] App uploaded
- [ ] Tested on Windows

---

## 🆓 Appetize.io Free Plan

- ✅ 100 minutes per month
- ✅ NO credit card required
- ✅ Upload unlimited apps
- ✅ Share public links
- ✅ iOS & Android support

**100 minutes = 5-10 complete testing sessions**

---

## 🔧 If Build Fails

### Quick Fix:
```bash
# Remove Superwall dependency
# Comment out in SuperwallManager.swift

# Set iOS version
# Project > General > Minimum Deployments > iOS 17.0

# Clean and rebuild
⌘⇧K (Clean)
⌘B (Build)
```

### Still Failing?
See: `BUILD_FOR_APPETIZE.md` for detailed troubleshooting

---

## 🆘 No Mac Access?

### Alternatives:

**Option 1: Borrow Mac**
- Friend, library, Apple Store
- Takes 15 minutes total

**Option 2: Use iSwift.dev**
- No Mac needed
- See real iOS design
- Single screens only
- Guide: `Preview/QUICK_START.md`

**Option 3: Use Web Demo**
- No Mac needed
- Full functionality
- Basic styling
- Run: `cd demo && launch.bat`

---

## 📖 Full Guides

- **Complete Appetize Guide**: `APPETIZE_COMPLETE_GUIDE.md`
- **Detailed Build Guide**: `BUILD_FOR_APPETIZE.md`
- **All Options**: `WINDOWS_PREVIEW_OPTIONS.md`

---

## ⏱️ Time Breakdown

| Task | Time |
|------|------|
| Create Xcode project | 2 min |
| Add files | 3 min |
| Build | 2 min |
| Find & compress | 2 min |
| Sign up Appetize | 1 min |
| Upload | 1 min |
| **Total** | **11 min** |

---

## 💡 Pro Tips

1. **Test locally first**: Run in Xcode simulator (⌘R)
2. **Share link**: Give Appetize URL to team
3. **Monitor usage**: Check remaining minutes in dashboard
4. **Build once**: Upload once, test unlimited times
5. **Multiple versions**: Upload different builds for testing

---

<div align="center">

**Ready to start?**

1. Open Xcode on Mac
2. Follow steps above
3. Test on Windows in 15 minutes!

**No Mac? Use iSwift.dev + Web Demo instead!**

</div>
