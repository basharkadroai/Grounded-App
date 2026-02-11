# 🍃 How to Preview Your SwiftUI App on Windows

Since you're on Windows and can't run Xcode, here's how to see your app running:

## Method 1: GitHub Actions (BEST - 100% Free)

### Step 1: Push Your Code
```cmd
git add .
git commit -m "Add app preview workflow"
git push
```

### Step 2: Run the Workflow
1. Go to your GitHub repository
2. Click the **"Actions"** tab at the top
3. Click **"Build and Preview iOS App"** in the left sidebar
4. Click the **"Run workflow"** button (top right)
5. Click the green **"Run workflow"** button in the dropdown
6. Wait 3-5 minutes for it to complete ⏱️

### Step 3: Download Your Preview
1. Once complete, scroll down to **"Artifacts"**
2. Download **"grounded-app-preview"** (it's a .zip file)
3. Extract the zip file
4. Open **`preview.html`** in your browser

### What You'll Get:
- ✅ Screenshots of your app running in iOS Simulator
- ✅ Video recording of your app (15 seconds)
- ✅ Built app package (.zip)
- ✅ HTML preview page with everything

---

## Method 2: Use the Demo (Already Working!)

Your `demo/index.html` already has a working version of your app!

```cmd
cd demo
start index.html
```

This shows your full app with:
- Onboarding flow
- Home screen
- Grounding exercises
- Habit tracking
- Resources library
- Insights
- Profile

---

## Method 3: Remote Mac Access (Free Options)

### MacStadium Free Trial
- Get a free Mac in the cloud for 24 hours
- Run Xcode and iOS Simulator
- https://www.macstadium.com/

### MacinCloud Free Trial
- 1 hour free trial
- Full Xcode access
- https://www.macincloud.com/

---

## Quick Comparison

| Method | Time | Quality | Cost |
|--------|------|---------|------|
| GitHub Actions | 5 min | Real iOS Simulator | Free |
| Demo HTML | Instant | Web mockup | Free |
| Remote Mac | Setup time | Real Xcode | Free trial |

**Recommendation:** Use GitHub Actions - it's the best balance of quality and convenience!

---

## Troubleshooting

### GitHub Actions fails?
- Check the "Actions" tab for error logs
- Make sure your Xcode project builds correctly
- The workflow will show exactly what went wrong

### Want to see it faster?
- The workflow runs automatically on every push to main/master
- Or manually trigger it anytime from the Actions tab

### Need help?
- Check the workflow logs in GitHub Actions
- All steps are clearly labeled and show progress
