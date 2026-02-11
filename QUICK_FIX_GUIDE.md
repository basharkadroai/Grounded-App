# ⚡ Quick Fix Guide - Appetize Upload

## 🔴 The Problem

**Error:** "Please upload an x86_64 or arm64 simulator build"

**Cause:** Your zip has source code, not a compiled binary.

---

## ✅ Quick Solutions

### 1️⃣ Have a Mac? (10 minutes)

```bash
# Open in Xcode
cd Grounded
open Grounded.xcodeproj

# Select simulator (not device!)
# Build: ⌘B
# Find: Product > Show Build Folder
# Navigate: Products/Debug-iphonesimulator/
# Zip: zip -r Grounded-Compiled.zip Grounded.app
# Upload to Appetize ✅
```

---

### 2️⃣ No Mac? Use GitHub Actions (Free!)

```bash
# Push to GitHub
git push origin main

# Go to GitHub > Actions tab
# Run "Build iOS Simulator" workflow
# Download artifact
# Upload to Appetize ✅
```

---

### 3️⃣ Want to Preview NOW? (30 seconds)

```bash
cd demo
launch.bat
```

**Plus:** https://www.iswift.dev + `Preview/HomeScreenPreview.swift`

---

## 📖 Full Guides

- **Detailed fix:** `FIX_APPETIZE_UPLOAD.md`
- **Windows options:** `WINDOWS_QUICK_START.md`
- **Complete explanation:** `APPETIZE_ISSUE_RESOLVED.md`

---

## 🎯 Decision Tree

```
Do you have a Mac?
├─ YES → Build in Xcode (10 min)
└─ NO
   ├─ Code on GitHub? → Use GitHub Actions (free)
   ├─ Can spend $10-50? → Hire someone or rent cloud Mac
   └─ Want immediate preview? → Use web demo + iSwift.dev
```

---

<div align="center">

**Choose your path above!**

All solutions work. Pick what's easiest for you.

</div>
