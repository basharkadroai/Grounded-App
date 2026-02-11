import Foundation
import SwiftUI
import SuperwallKit

class SuperwallManager: ObservableObject {
    static let shared = SuperwallManager()
    
    @Published var isPremium: Bool = false
    @Published var showPaywall: Bool = false
    
    private init() {
        loadSubscriptionStatus()
    }
    
    // MARK: - Configuration
    
    func configure() {
        // TODO: Replace with your actual Superwall API key from https://superwall.com/dashboard
        let apiKey = "pk_YOUR_API_KEY_HERE"
        
        Superwall.configure(apiKey: apiKey)
        
        // Set user attributes
        Superwall.shared.setUserAttributes([
            "app_version": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        ])
        
        checkSubscriptionStatus()
    }
    
    // MARK: - Subscription Status
    
    func checkSubscriptionStatus() {
        isPremium = Superwall.shared.subscriptionStatus == .active
    }
    
    private func loadSubscriptionStatus() {
        // Check with Superwall on launch
        Task {
            await MainActor.run {
                checkSubscriptionStatus()
            }
        }
    }
    
    // MARK: - Paywall Presentation
    
    func presentPaywall(for event: PaywallEvent) {
        Superwall.shared.register(event: event.rawValue)
    }
    
    func dismissPaywall() {
        showPaywall = false
    }
    
    // MARK: - Feature Access
    
    func canAccessFeature(_ feature: PremiumFeature) -> Bool {
        if isPremium {
            return true
        }
        
        switch feature {
        case .unlimitedGrounding:
            return checkGroundingLimit()
        case .unlimitedHabits:
            return checkHabitLimit()
        case .advancedInsights:
            return false
        case .cloudSync:
            return false
        case .dataExport:
            return false
        case .audioGuides:
            return false
        case .customExercises:
            return false
        }
    }
    
    private func checkGroundingLimit() -> Bool {
        let today = Calendar.current.startOfDay(for: Date())
        let sessions = UserDefaults.standard.integer(forKey: "sessionsToday_\(today.timeIntervalSince1970)")
        return sessions < 3 // Free tier: 3 sessions per day
    }
    
    private func checkHabitLimit() -> Bool {
        let habitCount = UserDefaults.standard.integer(forKey: "habitCount")
        return habitCount < 3 // Free tier: 3 habits
    }
    
    func incrementSessionCount() {
        let today = Calendar.current.startOfDay(for: Date())
        let key = "sessionsToday_\(today.timeIntervalSince1970)"
        let current = UserDefaults.standard.integer(forKey: key)
        UserDefaults.standard.set(current + 1, forKey: key)
    }
    
    // MARK: - Restore Purchases
    
    func restorePurchases() {
        Superwall.shared.restorePurchases()
        checkSubscriptionStatus()
    }
}

// MARK: - Enums

enum PaywallEvent: String {
    case groundingLimitReached = "grounding_limit_reached"
    case habitLimitReached = "habit_limit_reached"
    case premiumResourceAccess = "premium_resource_access"
    case advancedInsightsAccess = "advanced_insights_access"
    case onboardingComplete = "onboarding_complete"
    case dataExportAttempt = "data_export_attempt"
}

enum PremiumFeature {
    case unlimitedGrounding
    case unlimitedHabits
    case advancedInsights
    case cloudSync
    case dataExport
    case audioGuides
    case customExercises
}
