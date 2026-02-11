# Grounded Web Demo

This is a functional web-based demo of the Grounded iOS app, allowing you to test all core features in your browser.

## How to Run

1. Open `index.html` in any modern web browser (Chrome, Firefox, Edge, Safari)
2. Or use a local server:
   ```bash
   # If you have Python installed:
   python -m http.server 8000
   
   # Then open: http://localhost:8000
   ```

## Features You Can Test

### Onboarding
- 5-screen introduction to the app
- Personalization with name and goals
- Progress indicators

### Home Screen
- View daily and weekly session stats
- Access the grounding button
- See featured resources

### Grounding Exercise
- Complete the 5-4-3-2-1 technique
- Rate your mood before and after
- Track mood improvement
- Sessions are saved to local storage

### Habits
- Add custom habits with icons
- Use pre-built templates
- Mark habits as complete
- Track daily streaks
- View completion history

### Resources
- Browse educational articles about DPDR
- Search and filter by category
- Read full article content

### Insights
- View total grounding sessions
- See average mood improvement
- Track habit completion rates
- Visual statistics

### Profile
- View your personalization
- Access settings (UI only)
- Reset demo data

## Data Persistence

All data is stored in your browser's localStorage, so your progress persists between sessions. Use the "Reset Demo" button in the Profile tab to clear all data.

## Notes

This is a simplified web version of the iOS app. The actual iOS app will include:
- Native iOS animations and haptics
- CloudKit sync across devices
- Push notifications
- Additional grounding exercises
- Superwall paywall integration
- More advanced insights with charts
