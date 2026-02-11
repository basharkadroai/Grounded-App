import Foundation
import SwiftUI

// Superwall Manager for handling paywall and subscription logic
// Note: This is a placeholder implementation. To use Superwall:
// 1. Add Superwall SDK via SPM: https://github.com/superwall-me/Superwall-iOS
// 2. Get your API key from superwall.com
// 3. Uncomment the import and implementation below

// import SuperwallKit

class SuperwallManager: ObservableObject {
    static let shared = SuperwallManager()
    
    @Published var isPremium: Bool = false
    @Published var showPaywall: Bool = false
    
    private init() {
        loadSubscriptionStatus()
    }
    
    // MARK: - Configuration
    
    func configure() {
        // Uncomment when Superwall SDK is added:
        // Superwall.configure(apiKey: "YOUR_API_KEY_HERE")
        // checkSubscriptionStatus()
        
        // For demo purposes, check UserDefaults
        loadSubscriptionStatus()
    }
    
    // MARK: - Subscription Status
    
    func checkSubscriptionStatus() {
        // Uncomment when Superwall SDK is added:
        // isPremium = Superwall.shared.subscriptionStatus.isActive
        
        // Demo implementation
        isPremium = UserDefaults.standard.bool(forKey: "isPremium")
    }
    
    private func loadSubscriptionStatus() {
        isPremium = UserDefaults.standard.bool(forKey: "isPremium")
    }
    
    // MARK: - Paywall Presentation
    
    func presentPaywall(for event: PaywallEvent) {
        // Uncomment when Superwall SDK is added:
        // Superwall.shared.register(event: event.rawValue)
        
        // Demo implementation
        showPaywall = true
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
    
    // MARK: - Demo Purchase (Remove in production)
    
    func purchasePremium() {
        isPremium = true
        UserDefaults.standard.set(true, forKey: "isPremium")
    }
    
    func restorePurchases() {
        // Uncomment when Superwall SDK is added:
        // Superwall.shared.restorePurchases()
        
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
