import Foundation
import SwiftData

@Model
class User {
    var id: UUID
    var name: String?
    var onboardingCompleted: Bool
    var goals: [String]
    var createdAt: Date
    var isPremium: Bool
    
    init(id: UUID = UUID(), name: String? = nil, onboardingCompleted: Bool = false, goals: [String] = [], createdAt: Date = Date(), isPremium: Bool = false) {
        self.id = id
        self.name = name
        self.onboardingCompleted = onboardingCompleted
        self.goals = goals
        self.createdAt = createdAt
        self.isPremium = isPremium
    }
}
