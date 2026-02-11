import Foundation
import UserNotifications
import SwiftData

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    @Published var isAuthorized = false
    
    private init() {
        checkAuthorizationStatus()
    }
    
    // MARK: - Authorization
    
    func requestAuthorization() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            await MainActor.run {
                isAuthorized = granted
            }
            return granted
        } catch {
            return false
        }
    }
    
    func checkAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.isAuthorized = settings.authorizationStatus == .authorized
            }
        }
    }
    
    // MARK: - Habit Reminders
    
    func scheduleHabitReminder(for habit: Habit) {
        guard isAuthorized, let reminderTime = habit.reminderTime else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Time for \(habit.name)"
        content.body = "Don't forget to complete your habit today!"
        content.sound = .default
        content.categoryIdentifier = "HABIT_REMINDER"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: reminderTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: "habit_\(habit.id.uuidString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    func cancelHabitReminder(for habit: Habit) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["habit_\(habit.id.uuidString)"]
        )
    }
    
    func updateHabitReminders(habits: [Habit]) {
        // Cancel all existing habit reminders
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            let habitIdentifiers = requests.filter { $0.identifier.starts(with: "habit_") }.map { $0.identifier }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: habitIdentifiers)
        }
        
        // Schedule new reminders
        for habit in habits {
            scheduleHabitReminder(for: habit)
        }
    }
    
    // MARK: - Daily Check-in
    
    func scheduleDailyCheckIn(at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Daily Check-in"
        content.body = "How are you feeling today? Take a moment to ground yourself."
        content.sound = .default
        content.categoryIdentifier = "DAILY_CHECKIN"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: time)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: "daily_checkin",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelDailyCheckIn() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily_checkin"])
    }
    
    // MARK: - Weekly Insights
    
    func scheduleWeeklyInsights(dayOfWeek: Int, hour: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Your Weekly Progress"
        content.body = "Check out your insights and see how you've been doing this week!"
        content.sound = .default
        content.categoryIdentifier = "WEEKLY_INSIGHTS"
        
        var components = DateComponents()
        components.weekday = dayOfWeek // 1 = Sunday, 2 = Monday, etc.
        components.hour = hour
        components.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(
            identifier: "weekly_insights",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelWeeklyInsights() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["weekly_insights"])
    }
    
    // MARK: - Grounding Reminder
    
    func scheduleGroundingReminder(after hours: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Time to Ground"
        content.body = "It's been a while. Take a few minutes for a grounding exercise."
        content.sound = .default
        content.categoryIdentifier = "GROUNDING_REMINDER"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(hours * 3600), repeats: false)
        let request = UNNotificationRequest(
            identifier: "grounding_reminder_\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // MARK: - Notification Categories
    
    func setupNotificationCategories() {
        let habitCategory = UNNotificationCategory(
            identifier: "HABIT_REMINDER",
            actions: [],
            intentIdentifiers: [],
            options: []
        )
        
        let checkinCategory = UNNotificationCategory(
            identifier: "DAILY_CHECKIN",
            actions: [],
            intentIdentifiers: [],
            options: []
        )
        
        let insightsCategory = UNNotificationCategory(
            identifier: "WEEKLY_INSIGHTS",
            actions: [],
            intentIdentifiers: [],
            options: []
        )
        
        let groundingCategory = UNNotificationCategory(
            identifier: "GROUNDING_REMINDER",
            actions: [],
            intentIdentifiers: [],
            options: []
        )
        
        UNUserNotificationCenter.current().setNotificationCategories([
            habitCategory,
            checkinCategory,
            insightsCategory,
            groundingCategory
        ])
    }
    
    // MARK: - Badge Management
    
    func updateBadgeCount(_ count: Int) {
        UNUserNotificationCenter.current().setBadgeCount(count)
    }
    
    func clearBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
