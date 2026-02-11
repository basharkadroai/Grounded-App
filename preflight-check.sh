#!/bin/bash

# Grounded App - Pre-Flight Check
# Run this before the CEO demo to ensure everything is ready

echo "🍃 Grounded App - Pre-Flight Check"
echo "=================================="
echo ""

# Check if we're in the right directory
if [ ! -f "GroundedApp.swift" ]; then
    echo "❌ Error: Run this script from the Grounded/ directory"
    echo "   cd Grounded-App/Grounded"
    exit 1
fi

echo "✅ In correct directory"

# Check for Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not found"
    echo "   Install Xcode from the App Store"
    exit 1
fi

echo "✅ Xcode installed"

# Check Xcode version
XCODE_VERSION=$(xcodebuild -version | head -n 1)
echo "✅ $XCODE_VERSION"

# Check for Swift
SWIFT_VERSION=$(swift --version | head -n 1)
echo "✅ $SWIFT_VERSION"

# Check all required files exist
echo ""
echo "Checking files..."

FILES=(
    "GroundedApp.swift"
    "ContentView.swift"
    "Views/HomeView.swift"
    "Views/MainTabView.swift"
    "Views/OnboardingView.swift"
    "Views/GroundingExerciseSelectionView.swift"
    "Views/HabitTrackerView.swift"
    "Views/ResourceLibraryView.swift"
    "Views/InsightsView.swift"
    "Views/ProfileView.swift"
    "Models/User.swift"
    "Models/GroundingSession.swift"
    "Models/Habit.swift"
    "Services/SuperwallManager.swift"
    "Services/CloudKitManager.swift"
)

MISSING=0
for file in "${FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ Missing: $file"
        MISSING=$((MISSING + 1))
    fi
done

if [ $MISSING -gt 0 ]; then
    echo ""
    echo "❌ $MISSING files missing!"
    exit 1
fi

echo ""
echo "Checking for simulators..."

# List available simulators
SIMULATORS=$(xcrun simctl list devices available | grep "iPhone" | head -5)
if [ -z "$SIMULATORS" ]; then
    echo "❌ No iPhone simulators found"
    echo "   Open Xcode and install iOS simulators"
    exit 1
fi

echo "✅ iPhone simulators available:"
echo "$SIMULATORS" | sed 's/^/  /'

echo ""
echo "=================================="
echo "✅ ALL CHECKS PASSED!"
echo ""
echo "Ready for demo! 🚀"
echo ""
echo "To run the app:"
echo "  1. open Grounded.xcodeproj"
echo "  2. Select iPhone 15 Pro simulator"
echo "  3. Press ⌘ + R"
echo ""
echo "Or run: xcodebuild -project Grounded.xcodeproj -scheme Grounded -destination 'platform=iOS Simulator,name=iPhone 15 Pro'"
